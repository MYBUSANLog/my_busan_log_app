import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantMap extends StatefulWidget {
  const RestaurantMap({super.key});

  @override
  State<RestaurantMap> createState() => _RestaurantMapState();
}

class _RestaurantMapState extends State<RestaurantMap> {

  // home_screen copy(나현)
  int _current = 0;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // 페이지 이동 처리 영욱 수정
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/restaurant_map'); // 맛집 페이지로 이동
        break;
      case 1:
        Navigator.pushNamed(context, '/ai_recommend'); // AI추천 페이지로 이동
        break;
      case 2:
        Navigator.pushNamed(context, '/home'); // 홈 페이지로 이동
        break;
      case 3:
        Navigator.pushNamed(context, '/notifications'); // 알림 페이지로 이동
        break;
      case 4:
        Navigator.pushNamed(context, '/profile'); // 프로필 페이지로 이동
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                Text(
                  '내 주변 맛집 찾기',
                  style: TextStyle(
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),

          // 여기에 지도 API 추가
          Container(
            width: double.infinity,
            height: 350, // 비율에 따라 조정
            color: Colors.white,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
            ),
          ),

          Expanded(
            child: DraggableScrollableSheet(
              initialChildSize: 0.4,
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: ListView(
                    controller: scrollController,
                    padding: EdgeInsets.all(16),
                    children: [
                      _buildRestaurantItem(
                          '라마앤바바나',
                          '부산 부산진구 · 인도음식',
                          '361M',
                          '16,000원 ~',
                          'https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20150930_144%2F1443594464963pvo4n_JPEG%2F166875548337904_8.jpg'
                      ),
                      _buildRestaurantItem(
                          '오십사 서면점',
                          '부산 부산진구 · 육류,고기요리',
                          '312M',
                          '16,000원 ~',
                          'https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240727_76%2F1722067391668Rm3yo_JPEG%2F1000006972.jpg'
                      ),
                      _buildRestaurantItem(
                          '린선다이닝 서면본점',
                          '부산 부산진구 · 중식당',
                          '324M',
                          '16,000원 ~',
                          'https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240702_169%2F1719927154396InEcH_JPEG%2FIMG_9155.jpg'
                      ),
                      _buildRestaurantItem(
                          '상록회관연탄구이 부산서면점',
                          '부산 부산진구 · 육류,고기요리',
                          '195M',
                          '16,000원 ~',
                          'https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240423_137%2F1713876164679b9wUm_JPEG%2F1713870744202.jpg'
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: Offset(0, -2),
              blurRadius: 4.0,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xff0e4194),
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: TextStyle(fontSize: 10),
            unselectedLabelStyle: TextStyle(fontSize: 10),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                label: '맛집',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'AI추천',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: '알림',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '프로필',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantItem(String name, String category, String distance, String price, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          height: 1.0,
                        ),
                      ),
                      Text(
                        distance,
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                  Text(
                    category,
                    style: TextStyle(
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.grey,
                      height: 1.0,
                    ),
                  ),
                  SizedBox(height: 7),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      price,
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
