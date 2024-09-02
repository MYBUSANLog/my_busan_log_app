import 'package:busan_trip/screen/item_detail_screen2.dart';
import 'package:flutter/material.dart';

import 'item_detail_screen.dart';

class ExhibitionListScreen extends StatefulWidget {
  const ExhibitionListScreen({super.key});

  @override
  State<ExhibitionListScreen> createState() => _ExhibitionListScreenState();
}

class _ExhibitionListScreenState extends State<ExhibitionListScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isAtStart = true;
  bool _isAtEnd = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {
      _isAtStart = _scrollController.position.pixels == 0;
      _isAtEnd = _scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent;
    });
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.position.pixels + 100,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.position.pixels - 100,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '전시회',
          style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            )),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    child: Row(
                      children: [
                        _buildButton(0, '인기순'),
                        _buildButton(1, '추천순'),
                        _buildButton(2, '최근등록순'),
                        _buildButton(3, '가격낮은순'),
                        _buildButton(4, '가격높은순'),
                      ],
                    ),
                  ),
                  if (!_isAtStart)
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 30,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (!_isAtEnd)
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 30,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    '상품 ',
                    style: TextStyle(
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '({item.stock})',
                    style: TextStyle(
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w600,
                      color: Color(0xff0e4194),
                      fontSize: 14,
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
      ),
    );
  }

  Widget _buildButton(int index, String text) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onButtonPressed(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff0e4194) : Colors.transparent,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: GestureDetector(
          onTap: () => _onButtonPressed(index),
          child: Row(
            children: [
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'NotoSansKR',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ItemDetailScreen2()),
              // );
            },
            child: Row(
              children: [
                Text(
                  '3',
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                SizedBox(width: 13,),
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
