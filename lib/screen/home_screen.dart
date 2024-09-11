import 'package:busan_trip/screen/activity_list_screen.dart';
import 'package:busan_trip/screen/exhibition_list_screen.dart';
import 'package:busan_trip/screen/hotel_list_screen.dart';
import 'package:busan_trip/screen/item_detail_screen.dart';
import 'package:busan_trip/screen/realtime_list_screen.dart';
import 'package:busan_trip/screen/search_screen.dart';
import 'package:busan_trip/screen/themepark_list_screen.dart';
import 'package:busan_trip/screen/tour_list_screen.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/item_model.dart';
import '../vo/item.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedSegment = '인기상품 모음.zip';
  var searHistory = [];
  final CarouselController _controller = CarouselController();
  List imgList = [
    "https://plus.unsplash.com/premium_photo-1661962660197-6c2430fb49a6?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1551279076-6887dee32c7e?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1552873547-b88e7b2760e2?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1561555804-4b9e0848fdbe?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1683041133704-1de1c55d050c?q=80&w=1075&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ];

  bool isFavorited = false;

  void toggleFavorite() {
    setState(() {
      isFavorited = !isFavorited;
    });
  }

  final Future<void> _loadingFuture = _simulateLoading();

  static Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 5));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ItemModel>(context, listen: false).set6HotItems();
    Provider.of<ItemModel>(context, listen: false).set6NewItems();
  }




  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ));



    return Scaffold(
      body: FutureBuilder<void>(
        future: _loadingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildDetailContent();
          } else {
            return _buildDetailContent();
          }
        },
      ),
    );
  }



  Widget _buildDetailContent() {
    final SearchController controller = SearchController();

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height, // 최소 높이를 화면 높이로 설정
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/006.png',
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SearchScreen()),
                          );
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.search_outlined,
                              size: 35,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  sliderWidget(),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HotelListScreen()),
                          );
                        },
                        child: Column(
                          children: [
                            // Icon(Icons.hotel, size: 35),
                            Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/mybusanlog-b600f.appspot.com/o/my_busan_log%2Ftheme_icons%2Fhotel.png?alt=media&token=43194f84-1d3c-4187-bdfc-7cfa0bcb5167',
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            Text('호텔', style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ThemeparkListScreen()),
                          );
                        },
                        child: Column(
                          children: [
                            Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/mybusanlog-b600f.appspot.com/o/my_busan_log%2Ftheme_icons%2Fthemepark.png?alt=media&token=361518e5-fb23-4efc-93b2-81edd5a2825a',
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            Text('테마파크', style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ActivityListScreen()),
                          );
                        },
                        child: Column(
                          children: [
                            Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/mybusanlog-b600f.appspot.com/o/my_busan_log%2Ftheme_icons%2Factivity.png?alt=media&token=2abcc830-ca87-4135-b583-91d2b6b98eb6',
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            Text('액티비티', style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ExhibitionListScreen()),
                          );
                        },
                        child: Column(
                          children: [
                            Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/mybusanlog-b600f.appspot.com/o/my_busan_log%2Ftheme_icons%2Fexhibition.png?alt=media&token=c61a8140-6f34-4d7f-b109-556b633428c7',
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            Text('전시회', style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TourListScreen()),
                          );
                        },
                        child: Column(
                          children: [
                            Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/mybusanlog-b600f.appspot.com/o/my_busan_log%2Ftheme_icons%2Ftour.png?alt=media&token=8bceef40-2606-444e-80c7-ce48c8f6cccf',
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            Text('관광지', style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                      // Other GestureDetector widgets here
                    ],
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CupertinoSlidingSegmentedControl<String>(
                        backgroundColor: Colors.grey[100]!,
                        thumbColor: Color(0xff0e4194),
                        groupValue: _selectedSegment,
                        onValueChanged: (String? newValue) {
                          setState(() {
                            _selectedSegment = newValue!;
                          });
                        },
                        children: {
                          '인기상품 모음.zip': Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              '인기상품 모음.zip',
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                height: 1.0,
                                color: _selectedSegment == '인기상품 모음.zip' ? Colors.white : Colors.grey[500],
                              ),
                            ),
                          ),
                          '신규상품 모음.zip': Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              '신규상품 모음.zip',
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                height: 1.0,
                                color: _selectedSegment == '신규상품 모음.zip' ? Colors.white : Colors.grey[500],
                              ),
                            ),
                          ),
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (_selectedSegment == '인기상품 모음.zip')
                    _buildPopularItems()
                  else if (_selectedSegment == '신규상품 모음.zip')
                    _buildNewItems(),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Divider(color: Colors.grey[200], thickness: 7.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Column(
                    children: [
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/banner.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'ⓘ 광고 ',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            height: 1.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                  Column(
                    children: [
                      FeedCard(),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget sliderWidget() {

    return ClipRRect(
      borderRadius: BorderRadius.circular(15), // 전체 슬라이더 모서리를 둥글게
      child: CarouselSlider(
        carouselController: _controller,
        items: imgList.map(
              (imgLink) {
            return Builder(
              builder: (context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), // 이미지 컨테이너도 둥글게
                  ),
                  child: ClipRRect(
                    child: Image.network(
                      imgLink,
                      fit: BoxFit.cover, // 이미지의 BoxFit 설정
                    ),
                  ),
                );
              },
            );
          },
        ).toList(),
        options: CarouselOptions(
          height: 200,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
          onPageChanged: (index, reason) {
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _buildPopularItems() {
    return Consumer<ItemModel>(
      builder: (context, itemModel, child) {
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // 스크롤을 비활성화
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 한 줄에 3개
            childAspectRatio: 1,
            crossAxisSpacing: 10, // 아이템 간의 수평 간격
            mainAxisSpacing: 10, // 아이템 간의 수직 간격
          ),
          itemCount: itemModel.hotItem6.length,
          itemBuilder: (context, index) {
            Item item = itemModel.hotItem6[index];
            return FavoriteCard(item: item);
          },
        );
      },
    );
  }


  Widget _buildNewItems() {
    return Consumer<ItemModel>(
      builder: (context, itemModel, child) {
        return Container(
          height: 400,
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), // 스크롤을 비활성화
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 한 줄에 3개
              crossAxisSpacing: 10.0, // 아이템 간의 수평 간격
              mainAxisSpacing: 10.0, // 아이템 간의 수직 간격
              childAspectRatio: 1, // 아이템의 가로 세로 비율
            ),
            itemCount: itemModel.newItem6.length,
            itemBuilder: (context, index) {
              Item item = itemModel.newItem6[index];
              return FavoriteCard(item: item);
            },
          ),
        );
      },
    );
  }

}





class FavoriteCard extends StatelessWidget {
  final formatter = NumberFormat('#,###');
  final Item item;

  FavoriteCard({required this.item, super.key});

  String _formatAddress(String address) {
    // 주소를 공백을 기준으로 나눕니다.
    final parts = address.split(' ');

    if (parts.length >= 3) {
      // 부산광역시 기장군 기장읍 동부산관광로 42에서 '부산 기장군'을 추출
      return '${parts[0]} ${parts[1]}';
    }

    // 예상된 형식이 아닌 경우 원래 주소를 반환합니다.
    return address;
  }

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
        return '기타'; // 기본값
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ItemDetailScreen(item: item)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      '${item.i_image}',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    '${_formatAddress(item.i_address)} · ${_mapTypeToString(item.c_type)}',
                    style: TextStyle(
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w400,
                      fontSize: 8,
                      color: Colors.black,
                      height: 1.0,
                    ),
                  ),
                  Container(
                    child: Text(
                      '${item.i_name}',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 1.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ),
                  Text(
                    '${formatter.format(item.i_price)}원 ~',
                    style: TextStyle(
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}


class FeedCard extends StatefulWidget {
  const FeedCard({super.key});

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  bool isBookmarked = false;

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 22),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://search.pstatic.net/common/?src=https%3A%2F%2Fpup-review-phinf.pstatic.net%2FMjAyNDA3MjVfNTUg%2FMDAxNzIxODkwNTkwMzU5.YEYe-tSqM0YZ4LcjruvVppEJF93Qhw2h_f3Slli_aEUg.lgD2YFS88Wy9BeCzykPo-dG70Q3j0AefL3RIDfQl5Zwg.JPEG%2F1721650628775-27.jpg.jpg%3Ftype%3Dw1500_60_sharpen',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 16.0,
                right: 16.0,
                child: GestureDetector(
                  onTap: toggleBookmark,
                  child: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  'https://i.pinimg.com/564x/62/00/71/620071d0751e8cd562580a83ec834f7e.jpg',
                  width: 50,
                  height: 50,
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
                          '주먹밥 쿵야',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            height: 1.0,
                          ),
                        ),

                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 20,
                              color: Colors.amber,
                            ),
                            Text(
                              ' 5.0',
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 15, color: Colors.grey,),
                        Text(
                          ' 해운대 해수욕장',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey,
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
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