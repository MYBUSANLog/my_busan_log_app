import 'package:busan_trip/app_http/item_http.dart';
import 'package:busan_trip/screen/item_detail_screen2.dart';
import 'package:busan_trip/vo/item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'item_detail_screen.dart';

class ExhibitionListScreen extends StatefulWidget {
  const ExhibitionListScreen({super.key});

  @override
  State<ExhibitionListScreen> createState() => _ExhibitionListScreenState();
}

class _ExhibitionListScreenState extends State<ExhibitionListScreen> {
  late Future<List<Item>> _citem; // 데이터를 불러오기 위한 Future 객체
  late Future<int> _cnum; // 데이터를 불러오기 위한 Future 객체
  late int _totalItemCount; // 저장할 총 아이템 수

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

  String sortBy = 'popularity'; // 기본 정렬 기준, 초기에는 '인기순'으로 설정
  int c_type = 4; // 기본 카테고리 타입,

  @override
  void initState() {
    super.initState();
    _listScrollController.addListener(_scrollListener);
    _loadMoreItems();// 초기 데이터 로드

    _citem = ItemHttp.fetchCtype(c_type, sortBy, 0, itemsPerPage); // 첫 페이지 데이터를 불러옴
    _cnum = ItemHttp.fetchNum(c_type); //
  }

  Future<void> _loadInitialData() async {
    // 아이템 수를 가져옵니다.
    _totalItemCount = await _cnum;

    // 아이템 리스트를 가져옵니다.
    _citem = ItemHttp.fetchCtype(c_type, sortBy, 0, itemsPerPage);

    // 초기 데이터를 로드합니다.
    _loadMoreItems();
  }

  // 스크롤 리스너: 스크롤 시 데이터 추가 로드 및 상단 이동 버튼 처리
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
    if (isLoading) return; // 이미 로딩 중이면 중복 요청 방지

    setState(() {
      isLoading = true;
    });

    // fetchCtype 호출: c_type, sortBy, 시작 위치, 불러올 개수를 전달
    List<Item> newItems = await ItemHttp.fetchCtype(c_type, sortBy, currentPage * itemsPerPage, itemsPerPage);

    // 받아온 데이터를 FavoriteCard 형태로 변환하고 리스트에 추가
    setState(() {
      // 받아온 데이터를 FavoriteCard 형태로 변환하고 리스트에 추가
      favoriteCards.addAll(newItems.asMap().entries.map((entry) {
        int index = entry.key + currentPage * itemsPerPage;  // 전체 목록에서의 정확한 인덱스를 계산
        Item item = entry.value;
        return FavoriteCard(item: item, index: index);  // index와 item을 함께 전달
      }).toList());
      currentPage++; // 페이지 증가
      isLoading = false; // 로딩 종료
    });
  }


  @override
  void dispose() {
    _listScrollController.dispose();
    _buttonScrollController.dispose();
    super.dispose();
  }

  // 버튼 클릭 시 호출, 정렬 기준 변경 및 데이터 다시 로드
  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;

      // 클릭한 버튼에 따라 정렬 기준(sortBy) 변경
      if (index == 0) {
        sortBy = 'popularity';
      } else if (index == 1) {
        sortBy = 'wishes';
      } else if (index == 2) {
        sortBy = 'latest';
      } else if (index == 3) {
        sortBy = 'priceA';
      } else if (index == 4) {
        sortBy = 'priceD';
      }

      // 데이터 초기화 후 다시 로드
      favoriteCards.clear(); // 기존 데이터를 지우고
      currentPage = 0; // 페이지 초기화
      _loadMoreItems(); // 새로운 정렬 기준에 맞춰 데이터 로드
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
                FutureBuilder<int>(
                  future: _cnum,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text(
                        '(...)',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w600,
                          color: Color(0xff0e4194),
                          fontSize: 14,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        '(오류)',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w600,
                          color: Color(0xff0e4194),
                          fontSize: 14,
                        ),
                      );
                    } else {
                      return Text(
                        '(${snapshot.data ?? 0})',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w600,
                          color: Color(0xff0e4194),
                          fontSize: 14,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              controller: _listScrollController,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: favoriteCards.length + 1, // 로딩 표시를 위해 +1
              itemBuilder: (context, index) {
                // 마지막 아이템인 경우 로딩 인디케이터를 표시
                if (index == favoriteCards.length) {
                  return isLoading
                      ? Center(child: CircularProgressIndicator()) // 로딩 중일 때 보여줄 위젯
                      : SizedBox(); // 로딩이 끝나면 아무것도 안 보여줌
                }

                // favoriteCards에서 아이템을 가져옵니다.
                final FavoriteCard favoriteCard = favoriteCards[index]; // `favoriteCards`에서 해당 인덱스의 FavoriteCard 가져오기

                // 인덱스는 1부터 시작하도록 `index + 1`로 변경
                return FavoriteCard(item: favoriteCard.item, index: index + 1); // 인덱스를 1씩 증가시켜 전달
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

class FavoriteCard extends StatefulWidget {
  final Item item;
  final int index;

  FavoriteCard({required this.item, required this.index});

  @override
  _FavoriteCardState createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ItemDetailScreen(item: widget.item)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Text(
              '${widget.index}',  // 인덱스 표시
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.item.i_image, // 아이템 이미지
                width: 75,
                height: 75,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.item.i_name, // 아이템 이름
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                          overflow: TextOverflow.ellipsis, // 제목이 길 경우 ...으로 표시
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                  Row(
                    children: [
                      Text(
                        '${_formatAddress(widget.item.i_address)} · ${_mapTypeToString(widget.item.c_type)}  · ',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Icon(Icons.star_rounded, size: 16, color: Colors.amber), // 별 아이콘 추가
                      Text(
                        ' ${widget.item.averageScore}', // 평점
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${NumberFormat('#,###').format(widget.item.i_price)}원~',  // 아이템 가격
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 주소 형식을 변환하는 함수
  String _formatAddress(String address) {
    final parts = address.split(' ');
    if (parts.length >= 3) {
      return '${parts[0]} ${parts[1]}';
    }
    return address;
  }

  // 카테고리 타입을 문자열로 변환하는 함수
  String _mapTypeToString(int type) {
    switch (type) {
      case 1:
        return '호텔';
      case 2:
        return '테마파크';
      case 3:
        return '액티비티';
      case 4:
        return '전시회';
      default:
        return '기타';
    }
  }
}