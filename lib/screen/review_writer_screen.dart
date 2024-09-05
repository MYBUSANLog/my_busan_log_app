import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../app_util/img_util.dart';
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
  final storage = FirebaseStorage.instance;
  List<Uint8List> previewImgBytesList = [];
  List<String> uploadedImageUrls = [];

  bool isLoading = false; // 로딩 상태 관리
  int uploadProgress = 0; // 업로드 진행 상태 관리

  // 별점 선택 함수
  void onRatingSelected(int rating) {
    setState(() {
      _selectedRating = rating;
    });
  }

  // 필드 변경 시 호출되는 함수
  void _onFieldChanged() {
    setState(() {
      _isContentEntered = _contentController.text.isNotEmpty;
    });
  }

  bool _isAllFieldsEntered() {
    return _selectedRating > 0 && _isContentEntered && previewImgBytesList.isNotEmpty;
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
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
                                      onRatingSelected(index + 1); // 별점 선택 함수 호출
                                    },
                                    child: Icon(
                                      Icons.star_rounded,
                                      size: 50,
                                      color: index < _selectedRating
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
                                onTap: () async {
                                  final picker = ImagePicker();
                                  List<XFile> imgFiles = await picker.pickMultiImage();
                                  if(imgFiles.isNotEmpty) {
                                    List<Uint8List>? imageBytesList = [];
                                    for(var imgFile in imgFiles) {
                                      try {
                                        Uint8List bytes =
                                        await ImgUtil.convertResizedUint8List(
                                            xFile: imgFile);
                                        print("선택한 이미지의 데이터 크기: ${bytes.lengthInBytes} bytes");
                                        imageBytesList.add(bytes);
                                      } catch (e) {
                                        print(
                                            "이미지 데이터 크기 오류 발생! 선택한 이미지의 데이터 크기: ${await imgFile.length()} bytes");
                                        print("오류: $e");
                                      }
                                    }
                                    setState(() {
                                      previewImgBytesList.addAll(imageBytesList);
                                    });
                                  }
                                },
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
                              previewImgBytesList.isEmpty
                                  ? Text(
                                '(사진을 한 장 이상 필수로 첨부해주세요)',
                                style: TextStyle(
                                    fontFamily: 'NotoSansKR',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    height: 1.0,
                                    color: Colors.grey[600]
                                ),
                              )
                                  : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: previewImgBytesList.map((bytes) => Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: ImgBox(
                                      bytes: bytes,
                                      onRemove: () {
                                        setState(() {
                                          previewImgBytesList.remove(bytes);
                                        });
                                      },
                                    ),
                                  )).toList(),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                height: 200.0,
                                child: TextField(
                                  controller: _contentController,
                                  onChanged: (value) => _onFieldChanged(),
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
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 흐림 효과
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text(
                        '사진 처리 중... ($uploadProgress/${previewImgBytesList.length})',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
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

class ImgBox extends StatelessWidget {
  final Uint8List bytes;
  final Function onRemove;

  ImgBox({
    required this.bytes,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                bytes,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              )),
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () {
                onRemove();
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black54,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
