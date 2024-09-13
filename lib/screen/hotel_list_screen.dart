import 'package:busan_trip/screen/item_detail_screen2.dart';
import 'package:flutter/material.dart';

import 'item_detail_screen.dart';

class HotelListScreen extends StatefulWidget {
  const HotelListScreen({super.key});

  @override
  State<HotelListScreen> createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> {
  final ScrollController _listScrollController = ScrollController(); // ListView.builder용
  final ScrollController _buttonScrollController = ScrollController(); // SingleChildScrollView용
  List<FavoriteCard> favoriteCards = [];
  bool isLoading = false;
  int currentPage = 0;
  final int itemsPerPage = 20;

  bool _isAtStart = true;
  bool _isAtEnd = false;
  int _selectedIndex = 0;
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    _listScrollController.addListener(_scrollListener);
    _loadMoreItems();
  }

  void _scrollListener() {
    if (_listScrollController.position.pixels > 200) {
      setState(() {
        _showScrollToTopButton = true;
      });
    } else {
      setState(() {
        _showScrollToTopButton = false;
      });
    }

    if (_listScrollController.position.pixels >=
        _listScrollController.position.maxScrollExtent - 500 &&
        !isLoading) {
      // 스크롤이 맨 아래에서 500px 남을 때, 다음 100개를 불러옵니다.
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    if (isLoading) return; // 이미 로딩 중이면 중복 요청 방지d

    setState(() {
      isLoading = true;
    });

    // 여기서는 데이터를 불러오는 작업을 시뮬레이션합니다.
    // 실제로는 API 호출이나 로컬 데이터베이스에서 데이터를 가져와야 합니다.
    await Future.delayed(Duration(seconds: 2)); // 데이터 불러오기 시뮬레이션

    List<FavoriteCard> newItems = List.generate(itemsPerPage, (index) {
      return FavoriteCard(index: index); // 새로 불러온 100개의 FavoriteCard
    });

    setState(() {
      favoriteCards.addAll(newItems); // 새로 불러온 100개 추가
      currentPage++;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    _buttonScrollController.dispose();
    super.dispose();
  }

  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _scrollToTop() {
    _listScrollController.animateTo(
      0, // 맨 위로 이동
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // body 부분 수정
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '호텔',
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
      backgroundColor: Colors.white,
      body: Column(  // Column 사용
        children: [
          SizedBox(height: 15),
          Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _buttonScrollController,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
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
                  '(100)',
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w600,
                    color: Color(0xff0e4194),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Expanded(  // ListView.builder를 Expanded로 감쌈
            child: ListView.builder(
              controller: _listScrollController,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: favoriteCards.length + 1, // 로딩 표시를 위해 +1
              itemBuilder: (context, index) {
                if (index == favoriteCards.length) {
                  return isLoading
                      ? Center(child: CircularProgressIndicator()) // 로딩 중일 때 보여줄 위젯
                      : SizedBox(); // 로딩이 끝나면 아무것도 안 보여줌
                }
                final adjustedIndex = index + 1;

                return FavoriteCard(index: adjustedIndex);
              },
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
      floatingActionButton: _showScrollToTopButton
          ? FloatingActionButton(
        onPressed: _scrollToTop,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(  // 둥근 모서리 설정
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: Colors.grey[300]!)
        ),
        child: Icon(
          Icons.keyboard_arrow_up,
          color: Colors.black,
          size: 35,
        ),
      )
          : null,
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

class FavoriteCard extends StatelessWidget {
  final int index;

  FavoriteCard({required this.index});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Text(
                    '${index}',  // index 숫자 표시
                    style: TextStyle(
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240327_99%2F1711515295127evmbz_JPEG%2F%25B7%25CE%25B8%25AE%25BF%25A9%25BF%25D5.jpg',
                      width: 75,
                      height: 75,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '롯데월드 어드벤처 부산',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 7),
                    Text(
                      '부산 기장군 · 테마파크 · 후기 99+',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.grey,
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
        ],
      ),
    );
  }
}
