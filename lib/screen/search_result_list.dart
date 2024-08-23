// SearchScreen 코드 유지

import 'package:busan_trip/enums/enum_sort_by.dart';
import 'package:busan_trip/provider/sort_filter_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResultList extends StatefulWidget {
  final String searchTerm;

  const SearchResultList({required this.searchTerm, super.key});

  @override
  _SearchResultListState createState() => _SearchResultListState();
}

class _SearchResultListState extends State<SearchResultList> {
  late TextEditingController _controller;
  String _displayedText = "";

  static const double kMiddleSpacing = 16.0;

  @override
  void initState() {
    super.initState();
    // 전달받은 검색어로 컨트롤러 초기화
    _controller = TextEditingController(text: widget.searchTerm);
    _displayedText = widget.searchTerm;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmitted(String value) {
    final searchTerm = value.trim();
    if (searchTerm.isNotEmpty) {
      setState(() {
        _displayedText = searchTerm; // 입력된 값을 Text에 표시
      });
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          )
        ),
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: '여행지를 검색해주세요',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 10.0),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    suffixIcon: _controller.text.isNotEmpty
                        ? IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.grey[400],
                        size: 20,
                      ),
                      onPressed: () {
                        _controller.clear();
                        setState(() {});
                      },
                    )
                        : null,
                  ),
                  cursorColor: Color(0xff0e4194),
                  onSubmitted: _handleSubmitted, // 텍스트 입력 후 Enter 처리
                  textInputAction: TextInputAction.search,
                ),
              ),
            ),
            SizedBox(width: 15,),
            GestureDetector(
              onTap: () {

              },
              child: Column(
                children: [
                  Icon(
                    Icons.sort,
                    size: 20,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(width: 15,)
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    '검색 결과 :',
                    style: TextStyle(
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      height: 1.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      _displayedText, // TextField에 입력한 값을 표시
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              ListView.builder(
                shrinkWrap: true, // ListView의 높이를 자식의 높이에 맞추기
                physics: NeverScrollableScrollPhysics(), // 스크롤 비활성화
                itemCount: 12, // 예시로 12개 항목을 추가
                itemBuilder: (context, index) => Column(
                  children: [
                    FavoriteCard(),
                    SizedBox(height: 15),
                  ],
                ),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      )
    );
  }
}

class FavoriteCard extends StatefulWidget {
  const FavoriteCard({super.key});

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  bool isFavorited = false;

  void toggleFavorite() {
    setState(() {
      isFavorited = !isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detail_screen');
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240327_99%2F1711515295127evmbz_JPEG%2F%25B7%25CE%25B8%25AE%25BF%25A9%25BF%25D5.jpg',
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '롯데월드 어드벤처 부산',
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                height: 1.0,
                              ), overflow: TextOverflow.ellipsis
                          ),
                          GestureDetector(
                            onTap: toggleFavorite,
                            child: Column(
                              children: [
                                Icon(
                                  isFavorited ? Icons.favorite : Icons.favorite_outline,
                                  size: 25,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7,),
                      Text(
                        '부산 기장군 · 테마파크 · 후기 99+',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey,
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '29,000원~',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
