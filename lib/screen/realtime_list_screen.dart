import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RealtimeListScreen extends StatefulWidget {
  const RealtimeListScreen({super.key});

  @override
  State<RealtimeListScreen> createState() => _RealtimeListScreenState();
}

class _RealtimeListScreenState extends State<RealtimeListScreen> {
  final ScrollController _scrollController = ScrollController();
  double _appBarHeight = 200.0; // AppBar의 최대 높이
  double _titlePadding = 16.0;  // 제목의 패딩
  // Color _titleColor = Colors.white;
  Shadow _titleShadow = Shadow(offset: Offset(1.0, 1.0), blurRadius: 2.0, color: Colors.black.withOpacity(0.5),);
  // Color _iconColor = Colors.white;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
    ));

    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        double offset = _scrollController.offset;
        setState(() {
          _titlePadding = offset > (_appBarHeight - kToolbarHeight) ? 64.0 : 16.0;
          // _titleColor = offset > (_appBarHeight - kToolbarHeight) ? Colors.black : Colors.white;
          _titleShadow = offset > (_appBarHeight - kToolbarHeight)
              ? Shadow(offset: Offset(0.0, 0.0), blurRadius: 0.0, color: Colors.black.withOpacity(0.0),)
              : Shadow(offset: Offset(1.0, 1.0), blurRadius: 2.0, color: Colors.black.withOpacity(0.5),);
          // _iconColor = offset > (_appBarHeight - kToolbarHeight) ? Colors.black : Colors.white;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0, // AppBar의 최대 높이 설정
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: EdgeInsets.only(left:  _titlePadding, bottom: 0.0),
                child: Text(
                  '실시간 핫플레이스',
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w500,
                    fontSize: 23,
                    color: Colors.white,
                    shadows: [
                      _titleShadow,
                    ],
                  ),
                ),
              ),
              titlePadding: EdgeInsets.only(left: 0.0, bottom: 14.0), // 제목 위치 설정
              background: ClipRRect( //사진 자르는 것
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                child: Image.network(
                  'https://newsroom-prd-data.s3.ap-northeast-2.amazonaws.com/wp-content/uploads/2024/02/%EC%A7%80%EB%82%9C%ED%95%B4%EC%97%90-%EA%B0%80%EC%9E%A5-%EC%9D%B8%EA%B8%B0-%EC%9E%88%EB%8D%98-%EC%97%AC%ED%96%89%EC%A7%80%EB%8A%94-%EC%9D%BC%EB%B3%B8-%EB%9C%A8%EB%8A%94-%EC%97%AC%ED%96%89%EC%A7%80%EB%8A%94-%EC%96%B4%EB%94%94_02.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: Color(0xff0e4194),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                RealTimeList(),
                RealTimeList(),
                RealTimeList(),
                RealTimeList(),
                RealTimeList(),
                RealTimeList(),
                RealTimeList(),
                RealTimeList(),
                RealTimeList(),
                RealTimeList(),
                Container(color: Colors.white, child: SizedBox(height: 20,)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RealTimeList extends StatelessWidget {
  const RealTimeList({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail_screen'); // 항목 클릭 시 DetailScreen으로 이동
      },
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://newsroom-prd-data.s3.ap-northeast-2.amazonaws.com/wp-content/uploads/2024/02/%EC%A7%80%EB%82%9C%ED%95%B4%EC%97%90-%EA%B0%80%EC%9E%A5-%EC%9D%B8%EA%B8%B0-%EC%9E%88%EB%8D%98-%EC%97%AC%ED%96%89%EC%A7%80%EB%8A%94-%EC%9D%BC%EB%B3%B8-%EB%9C%A8%EB%8A%94-%EC%97%AC%ED%96%89%EC%A7%80%EB%8A%94-%EC%96%B4%EB%94%94_02.png',
                    width: 120,
                    height: 120,
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
                            '장소 1',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              height: 1.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 22,
                                          color: Colors.yellow,
                                        ),
                                        Text(
                                          ' 4.0',
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            color: Colors.grey,
                                            height: 1.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Icon(Icons.favorite_outline, size: 22, color: Colors.red),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        '부산 사상구 · 맛집',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.grey,
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: 40),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '410,000원~',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
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
      ),
    );
  }
}


