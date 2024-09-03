import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../model/review_model.dart';
import '../vo/review.dart';

class ReviewWriterScreen extends StatefulWidget {

  const ReviewWriterScreen({super.key});

  @override
  State<ReviewWriterScreen> createState() => _ReviewWriterScreenState();
}

class _ReviewWriterScreenState extends State<ReviewWriterScreen> {
  TextEditingController _contentController = TextEditingController();
  bool _isContentEntered = false;
  int _selectedRating = 0;
  final ImagePicker _picker = ImagePicker();
  File? _reviewImage;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        // List<File> _reviewImages = [];
        _reviewImage = File(image.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _reviewImage = null;
    });
  }

  void _onFieldChanged() {
    setState(() {
      _isContentEntered = _contentController.text.isNotEmpty;
    });
  }

  bool _isAllFieldsEntered() {
    return _selectedRating > 0 && _isContentEntered;
  }

  void _validateAndNavigate() {
    if (_isAllFieldsEntered()) {
      Review review = Review(
        r_score: _selectedRating.toDouble(),
        r_content: _contentController.text,
      );

      Provider.of<ReviewModel>(context, listen: false).writeReview = review;
      Provider.of<ReviewModel>(context, listen: false).saveReview();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('리뷰 작성이 완료되었습니다'),
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ));

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            )),
        elevation: 0,
        title: Text(
          '리뷰쓰기',
          style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ReviewWriterCard(
                selectedRating: _selectedRating,
                onRatingSelected: (rating) {
                  setState(() {
                    _selectedRating = rating;
                  });
                },
                reviewImage: _reviewImage,
                pickImage: _pickImage,
                removeImage: _removeImage,
                contentController: _contentController,
                onFieldChanged: _onFieldChanged,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: _isAllFieldsEntered() ? _validateAndNavigate : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _isAllFieldsEntered()
                ? const Color(0xff0e4194)
                : Colors.grey,
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: Text(
            '완료',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class ReviewWriterCard extends StatelessWidget {
  final int selectedRating;
  final Function(int) onRatingSelected;
  final File? reviewImage;
  final VoidCallback pickImage;
  final VoidCallback removeImage;
  final TextEditingController contentController;
  final VoidCallback onFieldChanged;

  const ReviewWriterCard({
    super.key,
    required this.selectedRating,
    required this.onRatingSelected,
    required this.reviewImage,
    required this.pickImage,
    required this.removeImage,
    required this.contentController,
    required this.onFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 14),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://d6bztw1vgnv55.cloudfront.net/1504819/offer_photos/132159/990717_original_1724998310.jpg?width=480&height=360',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '롯데월드 어드벤처 부산',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 1.0,
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '[QR바로입장] 부산 롯데월드 어드벤처',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          height: 1.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey[200], thickness: 7.0,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Column(
              children: [
                Text(
                  '상품은 어떠셨나요?',
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    height: 1.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        onRatingSelected(index + 1);
                      },
                      child: Icon(
                        Icons.star_rounded,
                        size: 50,
                        color: index < selectedRating
                            ? Colors.amber
                            : Colors.grey[300],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey[200], thickness: 1.0,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 14),
            child: Column(
              children: [
                GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Color(0xff0e4194))
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 24,
                            color: Color(0xff0e4194),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '사진 첨부하기',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              height: 1.0,
                              color: Color(0xff0e4194),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                reviewImage == null
                    ? Container()
                    : Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        reviewImage!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: removeImage,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black54,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 200.0,
                  child: TextField(
                    controller: contentController,
                    onChanged: (value) => onFieldChanged(),
                    decoration: InputDecoration(
                      hintText: '상품에 대한 자세한 리뷰를 남겨주세요.',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                    ),
                    cursorColor: Color(0xff0e4194),
                    textAlignVertical: TextAlignVertical.top,
                    maxLines: null,
                    expands: true,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey[200], thickness: 1.0,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '·  ',
                      style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          height: 1.0,
                          color: Colors.grey[800]
                      ),
                    ),
                    Expanded(
                      child: Text(
                          '작성한 리뷰는 모든 사용자들에게 공개되는 게시물입니다. 작성자의 개인정보에 대한 내용이 포함되지 않도록 주의해주세요.',
                          style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              height: 1.2,
                              color: Colors.grey[600]
                          ),
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.visible
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '·  ',
                      style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          height: 1.0,
                          color: Colors.grey[800]
                      ),
                    ),
                    Expanded(
                      child: Text(
                          '상품 및 상점을 향한 과도한 욕설 및 타인을 향한 비방글이 작성되면 작성된 게시물은 삭제될 예정이니, 이 점을 주의해주세요.',
                          style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              height: 1.2,
                              color: Colors.grey[600]
                          ),
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.visible
                      ),
                    )
                  ],
                ),
                SizedBox(height: 3),
              ],
            ),
          )
        ],
      ),
    );
  }
}

