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

  int _current = 0;
  int _selectedIndex = 1; // 홈을 기본 선택으로 설정  영욱 수정
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    bool isFavorited = false; // 하트가 채워져 있는지 여부
    final halfScreenWidth = MediaQuery.of(context).size.width / 2 - 30;
    final TextStyle notoSansStyle = TextStyle(fontFamily: 'NotoSansKR',);
    final PageController _pageController = PageController();

    //상단 이미지
    final List<String> imgList = [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuS22glNZwAX2uBzHpdoinyWJ4yR6sy5MdUQ&s',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFQnvMpdsDIb0WdFnB1zJMBcuv_6u7K7X0MQ&s',
      'https://cdn.telltrip.com/news/photo/202403/1327_7294_54.jpg',
    ];

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 0),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Stack(
              children: [
                ClipRRect(
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
                        fontWeight: FontWeight.bold// 텍스트 크기 조정 (필요시)
                      ),
                    ),
                  ),
                ),

              ]
            ),

            //하단 상품 부분
            Positioned(
              top: 180,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: MediaQuery.of(context).size.width, // 명시적인 너비 설정
                height: MediaQuery.of(context).size.height - 180, // 명시적인 높이 설정
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),


                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      SizedBox(height:20),

                      //상단 추천
                      Row(
                        children: [
                          Container(
                            width: 200,
                            height: 50,
                            child:Text(' 어디로 가시나요?',
                                style: notoSansStyle.copyWith(fontSize: 20,fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),

                      //여행 테마별 이미지 카드
                      Container(
                        width: double.infinity,
                        height: 100,
                        child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // 가로 스크롤 설정
                          child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12), // 모서리 둥글게
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
                                    borderRadius: BorderRadius.circular(12), // 위쪽 모서리만 둥글게
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          'https://www.visitbusan.net/uploadImgs/files/cntnts/20191229153530528',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        //이미지 그림자효과
                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: 50, // 그림자 효과의 높이 조정
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.transparent, // 위쪽은 투명
                                                    Colors.grey.withOpacity(0.7), // 아래쪽은 회색
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          right: 0,
                                          bottom: 10, // 아래쪽 여백 조정
                                          child: Center(
                                            child: Text(
                                              '해운대구',
                                              style: TextStyle(
                                                  color: Colors.white, // 텍스트 색상 조정 (필요시)
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold// 텍스트 크기 조정 (필요시)
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            ),

                            ),
                            SizedBox(width: 10,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12), // 모서리 둥글게
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
                                      borderRadius: BorderRadius.circular(12), // 위쪽 모서리만 둥글게
                                      child: Stack(
                                        children: [
                                          Image.network(
                                            'https://static.hubzum.zumst.com/hubzum/2018/02/06/11/18d4e253c7d94899837fe5d2a8e91102.jpg',
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                          //이미지 그림자효과
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                height: 50, // 그림자 효과의 높이 조정
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.transparent, // 위쪽은 투명
                                                      Colors.grey.withOpacity(0.7), // 아래쪽은 회색
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            right: 0,
                                            bottom: 10, // 아래쪽 여백 조정
                                            child: Center(
                                              child: Text(
                                                '부산진구',
                                                style: TextStyle(
                                                    color: Colors.white, // 텍스트 색상 조정 (필요시)
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold// 텍스트 크기 조정 (필요시)
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ],
                              ),

                            ),
                            SizedBox(width: 10,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12), // 모서리 둥글게
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
                                      borderRadius: BorderRadius.circular(12), // 위쪽 모서리만 둥글게
                                      child: Stack(
                                        children: [
                                          Image.network(
                                            'https://blog.kakaocdn.net/dn/oVM4m/btqDGfyVnZs/RkLBbatvY3YCYoUtSG3xN1/img.jpg',
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                          //이미지 그림자효과
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                height: 50, // 그림자 효과의 높이 조정
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.transparent, // 위쪽은 투명
                                                      Colors.grey.withOpacity(0.7), // 아래쪽은 회색
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            right: 0,
                                            bottom: 10, // 아래쪽 여백 조정
                                            child: Center(
                                              child: Text(
                                                '수영구',
                                                style: TextStyle(
                                                    color: Colors.white, // 텍스트 색상 조정 (필요시)
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold// 텍스트 크기 조정 (필요시)
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ],
                              ),

                            ),
                            SizedBox(width: 10,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12), // 모서리 둥글게
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
                                      borderRadius: BorderRadius.circular(12), // 위쪽 모서리만 둥글게
                                      child: Stack(
                                        children: [
                                          Image.network(
                                            'https://img.danawa.com/prod_img/500000/883/717/img/13717883_1.jpg?_v=20210326105131',
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                          //이미지 그림자효과
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                height: 50, // 그림자 효과의 높이 조정
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.transparent, // 위쪽은 투명
                                                      Colors.grey.withOpacity(0.7), // 아래쪽은 회색
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            right: 0,
                                            bottom: 10, // 아래쪽 여백 조정
                                            child: Center(
                                              child: Text(
                                                '영도구',
                                                style: TextStyle(
                                                    color: Colors.white, // 텍스트 색상 조정 (필요시)
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold// 텍스트 크기 조정 (필요시)
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ],
                              ),

                            ),
                          ],
                        ),
                        ),
                      ),
                      SizedBox(height:25),

                      Container(
                        width: double.infinity,
                        height: 120,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12), // 모서리 둥글게
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(12), // 위쪽 모서리만 둥글게
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
                                  child: Text('ⓘ광고 ',
                                    style: notoSansStyle.copyWith(fontSize: 13,color: Colors.grey),
                                  ),
                                ),

                                  ],
                                ),

                          ),
                      ),
                      SizedBox(height:10),


                      //상품카드
                      Row(
                        children: [
                          Container(
                            width: 200,
                            height: 50,
                            child:Text(' 상품 추천',
                                style: notoSansStyle.copyWith(fontSize: 20,fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12), // 모서리 둥글게
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4.0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),

                            child: Column(
                                children:[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ), // 위쪽 모서리만 둥글게
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          'https://lh5.googleusercontent.com/proxy/NMMOm85Vx_vW_o834ShdXDy_JibTGd2OIwgOAEuH_wzhGzJXOT7mLbYnYfULqTNsN4R9oqmt_2BNKDBKdzGIlcr6rFSpX6olLZkp3qJpmyTopfsS5KlzoQ',
                                          width: 180,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          right: 5, // 오른쪽 여백
                                          top: 5,   // 위쪽 여백
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isFavorited = !isFavorited; // 상태 반전
                                              });
                                            },
                                            icon: Icon(
                                              isFavorited ? Icons.favorite : Icons.favorite_border_outlined,
                                              size: 23,
                                              color: isFavorited ? Colors.red : Colors.white, // 색상 변경
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: halfScreenWidth,
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0), // 왼쪽에 8.0의 여백을 추가합니다.
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
                                        children: [
                                          Text(
                                            '아르떼 뮤지엄',
                                            style: notoSansStyle.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '19,900원~',
                                            style: notoSansStyle,
                                          ),
                                          Container(child: Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.yellow,size: 15,),
                                                Text(
                                                  '4.9/5.0',
                                                  style: notoSansStyle.copyWith(fontSize: 12,),
                                                ),
                                              ]

                                          )

                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12), // 모서리 둥글게
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4.0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),

                            child: Column(
                                children:[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ), // 위쪽 모서리만 둥글게
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          'https://lh5.googleusercontent.com/proxy/NMMOm85Vx_vW_o834ShdXDy_JibTGd2OIwgOAEuH_wzhGzJXOT7mLbYnYfULqTNsN4R9oqmt_2BNKDBKdzGIlcr6rFSpX6olLZkp3qJpmyTopfsS5KlzoQ',
                                          width: 180,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          right: 5, // 오른쪽 여백
                                          top: 5,   // 위쪽 여백
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isFavorited = !isFavorited; // 상태 반전
                                              });
                                            },
                                            icon: Icon(
                                              isFavorited ? Icons.favorite : Icons.favorite_border_outlined,
                                              size: 23,
                                              color: isFavorited ? Colors.red : Colors.white, // 색상 변경
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: halfScreenWidth,
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0), // 왼쪽에 8.0의 여백을 추가합니다.
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
                                        children: [
                                          Text(
                                            '아르떼 뮤지엄',
                                            style: notoSansStyle.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '19,900원~',
                                            style: notoSansStyle,
                                          ),
                                          Container(child: Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.yellow,size: 15,),
                                                Text(
                                                  '4.9/5.0',
                                                  style: notoSansStyle.copyWith(fontSize: 12,),
                                                ),
                                              ]

                                          )

                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12), // 모서리 둥글게
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4.0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),

                            child: Column(
                                children:[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ), // 위쪽 모서리만 둥글게
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          'https://lh5.googleusercontent.com/proxy/NMMOm85Vx_vW_o834ShdXDy_JibTGd2OIwgOAEuH_wzhGzJXOT7mLbYnYfULqTNsN4R9oqmt_2BNKDBKdzGIlcr6rFSpX6olLZkp3qJpmyTopfsS5KlzoQ',
                                          width: 180,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          right: 5, // 오른쪽 여백
                                          top: 5,   // 위쪽 여백
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isFavorited = !isFavorited; // 상태 반전
                                              });
                                            },
                                            icon: Icon(
                                              isFavorited ? Icons.favorite : Icons.favorite_border_outlined,
                                              size: 23,
                                              color: isFavorited ? Colors.red : Colors.white, // 색상 변경
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: halfScreenWidth,
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0), // 왼쪽에 8.0의 여백을 추가합니다.
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
                                        children: [
                                          Text(
                                            '아르떼 뮤지엄',
                                            style: notoSansStyle.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '19,900원~',
                                            style: notoSansStyle,
                                          ),
                                          Container(child: Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.yellow,size: 15,),
                                                Text(
                                                  '4.9/5.0',
                                                  style: notoSansStyle.copyWith(fontSize: 12,),
                                                ),
                                              ]

                                          )

                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12), // 모서리 둥글게
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4.0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),

                            child: Column(
                                children:[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ), // 위쪽 모서리만 둥글게
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          'https://lh5.googleusercontent.com/proxy/NMMOm85Vx_vW_o834ShdXDy_JibTGd2OIwgOAEuH_wzhGzJXOT7mLbYnYfULqTNsN4R9oqmt_2BNKDBKdzGIlcr6rFSpX6olLZkp3qJpmyTopfsS5KlzoQ',
                                          width: 180,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          right: 5, // 오른쪽 여백
                                          top: 5,   // 위쪽 여백
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isFavorited = !isFavorited; // 상태 반전
                                              });
                                            },
                                            icon: Icon(
                                              isFavorited ? Icons.favorite : Icons.favorite_border_outlined,
                                              size: 23,
                                              color: isFavorited ? Colors.red : Colors.white, // 색상 변경
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: halfScreenWidth,
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0), // 왼쪽에 8.0의 여백을 추가합니다.
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
                                        children: [
                                          Text(
                                            '아르떼 뮤지엄',
                                            style: notoSansStyle.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '19,900원~',
                                            style: notoSansStyle,
                                          ),
                                          Container(child: Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.yellow,size: 15,),
                                                Text(
                                                  '4.9/5.0',
                                                  style: notoSansStyle.copyWith(fontSize: 12,),
                                                ),
                                              ]

                                          )

                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12), // 모서리 둥글게
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4.0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),

                            child: Column(
                                children:[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ), // 위쪽 모서리만 둥글게
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          'https://lh5.googleusercontent.com/proxy/NMMOm85Vx_vW_o834ShdXDy_JibTGd2OIwgOAEuH_wzhGzJXOT7mLbYnYfULqTNsN4R9oqmt_2BNKDBKdzGIlcr6rFSpX6olLZkp3qJpmyTopfsS5KlzoQ',
                                          width: 180,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          right: 5, // 오른쪽 여백
                                          top: 5,   // 위쪽 여백
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isFavorited = !isFavorited; // 상태 반전
                                              });
                                            },
                                            icon: Icon(
                                              isFavorited ? Icons.favorite : Icons.favorite_border_outlined,
                                              size: 23,
                                              color: isFavorited ? Colors.red : Colors.white, // 색상 변경
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: halfScreenWidth,
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0), // 왼쪽에 8.0의 여백을 추가합니다.
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
                                        children: [
                                          Text(
                                            '아르떼 뮤지엄',
                                            style: notoSansStyle.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '19,900원~',
                                            style: notoSansStyle,
                                          ),
                                          Container(child: Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.yellow,size: 15,),
                                                Text(
                                                  '4.9/5.0',
                                                  style: notoSansStyle.copyWith(fontSize: 12,),
                                                ),
                                              ]

                                          )

                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12), // 모서리 둥글게
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4.0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),

                            child: Column(
                                children:[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ), // 위쪽 모서리만 둥글게
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          'https://lh5.googleusercontent.com/proxy/NMMOm85Vx_vW_o834ShdXDy_JibTGd2OIwgOAEuH_wzhGzJXOT7mLbYnYfULqTNsN4R9oqmt_2BNKDBKdzGIlcr6rFSpX6olLZkp3qJpmyTopfsS5KlzoQ',
                                          width: 180,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          right: 5, // 오른쪽 여백
                                          top: 5,   // 위쪽 여백
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isFavorited = !isFavorited; // 상태 반전
                                              });
                                            },
                                            icon: Icon(
                                              isFavorited ? Icons.favorite : Icons.favorite_border_outlined,
                                              size: 23,
                                              color: isFavorited ? Colors.red : Colors.white, // 색상 변경
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: halfScreenWidth,
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0), // 왼쪽에 8.0의 여백을 추가합니다.
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
                                        children: [
                                          Text(
                                            '아르떼 뮤지엄',
                                            style: notoSansStyle.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '19,900원~',
                                            style: notoSansStyle,
                                          ),
                                          Container(child: Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.yellow,size: 15,),
                                                Text(
                                                  '4.9/5.0',
                                                  style: notoSansStyle.copyWith(fontSize: 12,),
                                                ),
                                              ]

                                          )

                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12), // 모서리 둥글게
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4.0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),

                            child: Column(
                                children:[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ), // 위쪽 모서리만 둥글게
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          'https://lh5.googleusercontent.com/proxy/NMMOm85Vx_vW_o834ShdXDy_JibTGd2OIwgOAEuH_wzhGzJXOT7mLbYnYfULqTNsN4R9oqmt_2BNKDBKdzGIlcr6rFSpX6olLZkp3qJpmyTopfsS5KlzoQ',
                                          width: 180,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          right: 5, // 오른쪽 여백
                                          top: 5,   // 위쪽 여백
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isFavorited = !isFavorited; // 상태 반전
                                              });
                                            },
                                            icon: Icon(
                                              isFavorited ? Icons.favorite : Icons.favorite_border_outlined,
                                              size: 23,
                                              color: isFavorited ? Colors.red : Colors.white, // 색상 변경
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: halfScreenWidth,
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0), // 왼쪽에 8.0의 여백을 추가합니다.
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
                                        children: [
                                          Text(
                                            '아르떼 뮤지엄',
                                            style: notoSansStyle.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '19,900원~',
                                            style: notoSansStyle,
                                          ),
                                          Container(child: Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.yellow,size: 15,),
                                                Text(
                                                  '4.9/5.0',
                                                  style: notoSansStyle.copyWith(fontSize: 12,),
                                                ),
                                              ]

                                          )

                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12), // 모서리 둥글게
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4.0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),

                            child: Column(
                                children:[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ), // 위쪽 모서리만 둥글게
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          'https://lh5.googleusercontent.com/proxy/NMMOm85Vx_vW_o834ShdXDy_JibTGd2OIwgOAEuH_wzhGzJXOT7mLbYnYfULqTNsN4R9oqmt_2BNKDBKdzGIlcr6rFSpX6olLZkp3qJpmyTopfsS5KlzoQ',
                                          width: 180,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          right: 5, // 오른쪽 여백
                                          top: 5,   // 위쪽 여백
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isFavorited = !isFavorited; // 상태 반전
                                              });
                                            },
                                            icon: Icon(
                                              isFavorited ? Icons.favorite : Icons.favorite_border_outlined,
                                              size: 23,
                                              color: isFavorited ? Colors.red : Colors.white, // 색상 변경
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: halfScreenWidth,
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0), // 왼쪽에 8.0의 여백을 추가합니다.
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
                                        children: [
                                          Text(
                                            '아르떼 뮤지엄',
                                            style: notoSansStyle.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '19,900원~',
                                            style: notoSansStyle,
                                          ),
                                          Container(child: Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.yellow,size: 15,),
                                                Text(
                                                  '4.9/5.0',
                                                  style: notoSansStyle.copyWith(fontSize: 12,),
                                                ),
                                              ]

                                          )

                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12), // 모서리 둥글게
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4.0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),

                            child: Column(
                                children:[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ), // 위쪽 모서리만 둥글게
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          'https://lh5.googleusercontent.com/proxy/NMMOm85Vx_vW_o834ShdXDy_JibTGd2OIwgOAEuH_wzhGzJXOT7mLbYnYfULqTNsN4R9oqmt_2BNKDBKdzGIlcr6rFSpX6olLZkp3qJpmyTopfsS5KlzoQ',
                                          width: 180,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          right: 5, // 오른쪽 여백
                                          top: 5,   // 위쪽 여백
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isFavorited = !isFavorited; // 상태 반전
                                              });
                                            },
                                            icon: Icon(
                                              isFavorited ? Icons.favorite : Icons.favorite_border_outlined,
                                              size: 23,
                                              color: isFavorited ? Colors.red : Colors.white, // 색상 변경
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: halfScreenWidth,
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0), // 왼쪽에 8.0의 여백을 추가합니다.
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
                                        children: [
                                          Text(
                                            '아르떼 뮤지엄',
                                            style: notoSansStyle.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '19,900원~',
                                            style: notoSansStyle,
                                          ),
                                          Container(child: Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.yellow,size: 15,),
                                                Text(
                                                  '4.9/5.0',
                                                  style: notoSansStyle.copyWith(fontSize: 12,),
                                                ),
                                              ]

                                          )

                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12), // 모서리 둥글게
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4.0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),

                            child: Column(
                                children:[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ), // 위쪽 모서리만 둥글게
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          'https://lh5.googleusercontent.com/proxy/NMMOm85Vx_vW_o834ShdXDy_JibTGd2OIwgOAEuH_wzhGzJXOT7mLbYnYfULqTNsN4R9oqmt_2BNKDBKdzGIlcr6rFSpX6olLZkp3qJpmyTopfsS5KlzoQ',
                                          width: 180,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          right: 5, // 오른쪽 여백
                                          top: 5,   // 위쪽 여백
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isFavorited = !isFavorited; // 상태 반전
                                              });
                                            },
                                            icon: Icon(
                                              isFavorited ? Icons.favorite : Icons.favorite_border_outlined,
                                              size: 23,
                                              color: isFavorited ? Colors.red : Colors.white, // 색상 변경
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: halfScreenWidth,
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0), // 왼쪽에 8.0의 여백을 추가합니다.
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
                                        children: [
                                          Text(
                                            '아르떼 뮤지엄',
                                            style: notoSansStyle.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '19,900원~',
                                            style: notoSansStyle,
                                          ),
                                          Container(child: Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.yellow,size: 15,),
                                                Text(
                                                  '4.9/5.0',
                                                  style: notoSansStyle.copyWith(fontSize: 12,),
                                                ),
                                              ]

                                          )

                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),


                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}




