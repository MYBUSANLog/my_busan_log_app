import 'dart:async';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AiRecommendScreen extends StatefulWidget {
  const AiRecommendScreen({super.key});

  @override
  State<AiRecommendScreen> createState() => _AiRecommendScreenState();
}

class _AiRecommendScreenState extends State<AiRecommendScreen> {
  // ScrollController _scrollController = ScrollController();
  // bool isShow = false;

  int _current = 0;
  int _nowIndex = 1; // 홈을 기본 선택으로 설정  영욱 수정


  final TextStyle notoSansStyle = TextStyle(fontFamily: 'NotoSansKR',);
  final PageController _pageController = PageController();
  final CarouselController _controller = CarouselController();
  final List<String> imgList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuS22glNZwAX2uBzHpdoinyWJ4yR6sy5MdUQ&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFQnvMpdsDIb0WdFnB1zJMBcuv_6u7K7X0MQ&s',
    'https://cdn.telltrip.com/news/photo/202403/1327_7294_54.jpg',
  ];

  // void _scrollListener(){
  //   var offset = _scrollController.offset;
  //   if(offset > 150 && isShow==false){
  //     print('[1] : ${offset}');
  //     setState(() {
  //       isShow=true;
  //     });
  //   }else{
  //     print('[2] : ${offset}');
  //     setState(() {
  //       isShow=false;
  //     });
  //   }
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _scrollController.addListener(_scrollListener);
  // }
  //
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _scrollController.removeListener(_scrollListener);
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final halfScreenWidth = MediaQuery.of(context).size.width / 2 - 30;


    return Scaffold(
      body: CustomScrollView(
        // controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background:
              Stack(children: [
                ClipRRect(
                  child: CarouselSlider(
                    carouselController: _controller,
                    items: imgList.map(
                          (imgLink) {
                        return Builder(
                          builder: (context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(),
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
                      height: 240,
                      viewportFraction: 1.0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 4),
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Text(
                      'AI 여행일정추천',
                      style: TextStyle(
                          color: Colors.white, // 텍스트 색상 조정 (필요시)
                          fontSize: 25,
                          fontWeight: FontWeight.bold // 텍스트 크기 조정 (필요시)
                      ),
                    ),
                  ),
                ),
              ]),
              collapseMode: CollapseMode.parallax,
            ),
            expandedHeight: 160,
            toolbarHeight: 30.0, // 최소 높이 설정
            pinned: true,
          ),

          //어디로 가시나요 헤더고정 pin
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              minHeight: 00.0,
              maxHeight: 50.0,
              child: Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Text(
                        '어디로 가시나요?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 100,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4.0,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // 이미지가 클릭되면 화면이 이동
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          child: Stack(
                                            children: [
                                              Image.network(
                                                'https://www.visitbusan.net/uploadImgs/files/cntnts/20191229153530528',
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned.fill(
                                                child: Align(
                                                  alignment:
                                                  Alignment.bottomCenter,
                                                  child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.transparent,
                                                          Colors.grey
                                                              .withOpacity(0.7),
                                                        ],
                                                        begin:
                                                        Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                right: 0,
                                                bottom: 10,
                                                child: Center(
                                                  child: Text(
                                                    '해운대구',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4.0,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // 이미지가 클릭되면 화면이 이동
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          child: Stack(
                                            children: [
                                              Image.network(
                                                'https://www.visitbusan.net/uploadImgs/files/cntnts/20191229153530528',
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned.fill(
                                                child: Align(
                                                  alignment:
                                                  Alignment.bottomCenter,
                                                  child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.transparent,
                                                          Colors.grey
                                                              .withOpacity(0.7),
                                                        ],
                                                        begin:
                                                        Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                right: 0,
                                                bottom: 10,
                                                child: Center(
                                                  child: Text(
                                                    '해운대구',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4.0,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // 이미지가 클릭되면 화면이 이동
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          child: Stack(
                                            children: [
                                              Image.network(
                                                'https://www.visitbusan.net/uploadImgs/files/cntnts/20191229153530528',
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned.fill(
                                                child: Align(
                                                  alignment:
                                                  Alignment.bottomCenter,
                                                  child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.transparent,
                                                          Colors.grey
                                                              .withOpacity(0.7),
                                                        ],
                                                        begin:
                                                        Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                right: 0,
                                                bottom: 10,
                                                child: Center(
                                                  child: Text(
                                                    '해운대구',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4.0,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // 이미지가 클릭되면 화면이 이동
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          child: Stack(
                                            children: [
                                              Image.network(
                                                'https://www.visitbusan.net/uploadImgs/files/cntnts/20191229153530528',
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned.fill(
                                                child: Align(
                                                  alignment:
                                                  Alignment.bottomCenter,
                                                  child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.transparent,
                                                          Colors.grey
                                                              .withOpacity(0.7),
                                                        ],
                                                        begin:
                                                        Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                right: 0,
                                                bottom: 10,
                                                child: Center(
                                                  child: Text(
                                                    '해운대구',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4.0,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // 이미지가 클릭되면 화면이 이동
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          child: Stack(
                                            children: [
                                              Image.network(
                                                'https://www.visitbusan.net/uploadImgs/files/cntnts/20191229153530528',
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned.fill(
                                                child: Align(
                                                  alignment:
                                                  Alignment.bottomCenter,
                                                  child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.transparent,
                                                          Colors.grey
                                                              .withOpacity(0.7),
                                                        ],
                                                        begin:
                                                        Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                right: 0,
                                                bottom: 10,
                                                child: Center(
                                                  child: Text(
                                                    '해운대구',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4.0,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // 이미지가 클릭되면 화면이 이동
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          child: Stack(
                                            children: [
                                              Image.network(
                                                'https://www.visitbusan.net/uploadImgs/files/cntnts/20191229153530528',
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned.fill(
                                                child: Align(
                                                  alignment:
                                                  Alignment.bottomCenter,
                                                  child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.transparent,
                                                          Colors.grey
                                                              .withOpacity(0.7),
                                                        ],
                                                        begin:
                                                        Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                right: 0,
                                                bottom: 10,
                                                child: Center(
                                                  child: Text(
                                                    '해운대구',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 25),

                        //광고배너
                        Container(
                          width: double.infinity,
                          height: 120,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(12), // 모서리 둥글게
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  // 위쪽 모서리만 둥글게
                                  child: Image.network(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGtGQJVnKEIhwj53JEjfgi-pGj8YMRULqq6g&s',
                                    width: double.infinity,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'ⓘ광고 ',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //상품추천 헤더고정 pin
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              minHeight: 00.0,
              maxHeight: 50.0,
              child: Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Text(
                        '상품추천',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //상품리스트
          SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: halfScreenWidth,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FavoriteItemCard(),
                    FavoriteItemCard(),
                    FavoriteItemCard(),
                    FavoriteItemCard(),
                    FavoriteItemCard(),
                    FavoriteItemCard(),
                    FavoriteItemCard(),
                    FavoriteItemCard(),
                    FavoriteItemCard(),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minHeight;
  final double maxHeight;

  _SliverAppBarDelegate(
      {required this.minHeight, required this.maxHeight, required this.child});

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class FavoriteItemCard extends StatefulWidget {
  const FavoriteItemCard({super.key});

  @override
  State<FavoriteItemCard> createState() => _FavoriteItemCardState();
}

class _FavoriteItemCardState extends State<FavoriteItemCard> {
  bool isFavorited = false;
  final TextStyle notoSansStyle = TextStyle(fontFamily: 'NotoSansKR',);

  void toggleFavorite() {
    setState(() {
      isFavorited = !isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {

    final halfScreenWidth = MediaQuery.of(context).size.width / 2 - 21;


    return Container(
      width: halfScreenWidth,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Stack(
              children: [
                Image.network(
                  'https://lh5.googleusercontent.com/proxy/NMMOm85Vx_vW_o834ShdXDy_JibTGd2OIwgOAEuH_wzhGzJXOT7mLbYnYfULqTNsN4R9oqmt_2BNKDBKdzGIlcr6rFSpX6olLZkp3qJpmyTopfsS5KlzoQ',
                  width: halfScreenWidth,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: IconButton(
                    onPressed: toggleFavorite,
                    icon: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border_outlined,
                      size: 23,
                      color: isFavorited ? Colors.red : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '아르떼뮤지엄',
                  style: notoSansStyle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '19,000~',
                  style: notoSansStyle,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 15,
                    ),
                    Text(
                      '4.9/5.0',
                      style: notoSansStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

