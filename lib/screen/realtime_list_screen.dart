import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RealtimeListScreen extends StatefulWidget {
  const RealtimeListScreen({super.key});

  @override
  State<RealtimeListScreen> createState() => _RealtimeListScreenState();
}

class _RealtimeListScreenState extends State<RealtimeListScreen> {

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0, // AppBar의 최대 높이 설정
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final scrollPosition = constraints.biggest.height;
                final appBarCollapsedHeight = kToolbarHeight;
                final appBarExpandedHeight = 200.0;
                final isCollapsed = scrollPosition <= appBarCollapsedHeight;

                return FlexibleSpaceBar(
                  title: Text(
                    '실시간 핫플레이스',
                    style: TextStyle(
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w500,
                      fontSize: 23,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 2.0,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                  titlePadding: EdgeInsets.only(left: 16.0, bottom: 16.0), // 제목 위치 설정
                  background: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      ClipRRect( //사진 자르는 것
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
                      // Container(
                      //   margin: EdgeInsets.only(top: 80),
                      //   width: MediaQuery.of(context).size.width,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       IconButton(
                      //         onPressed: () {},
                      //         icon: Icon(
                      //           Icons.search_rounded,
                      //           color: Colors.white,
                      //           size: 30,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                );
              },
            ),
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
    return SingleChildScrollView(
      child: IntrinsicHeight(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 20,),
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
                  SizedBox(width: 10,),
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
                                ), overflow: TextOverflow.ellipsis
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
                                            size: 20,
                                            color: Colors.yellow,
                                          ),
                                          Text(' 4.0'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      Icon(Icons.favorite_outline, size: 20, color: Colors.red,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
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
      ),
    );
  }
}

