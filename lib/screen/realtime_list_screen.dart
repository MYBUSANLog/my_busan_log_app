import 'dart:ui';

import 'package:busan_trip/screen/store_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/item_model.dart';
import '../model/store_model.dart';
import '../vo/item.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ItemModel>(context, listen: false).setItems();
    });

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
                Consumer<ItemModel>(builder: (context, itemModel, child) {
                  return Column(
                    children: itemModel.items.asMap().entries.map((entry) {
                      int index = entry.key;
                      Item item = entry.value;
                      return RealTimeList(item: item, rank: index + 1);
                    }).toList(),
                  );
                }),
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
  final formatter = NumberFormat('#,###');
  final Item item;
  final int rank;

  RealTimeList({required this.item, required this.rank, super.key});

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
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5), // Shadow color with opacity
                        offset: Offset(0, -2), // Offset the shadow upwards (top shadow effect)
                        blurRadius: 4.0, // Blur radius for the shadow
                        spreadRadius: 0, // Spread radius of the shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          '${item.i_image}',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Consumer<StoreModel>(
                            //   builder: (context, storeModel, child) {
                            //     final store = storeModel.getStoreById(item.s_idx);
                            //     if (store == null) {
                            //       // Fetch store data if not already fetched
                            //       storeModel.fetchStoreById(item.s_idx);
                            //       return Text(
                            //         'Loading...',  // Placeholder while loading
                            //         style: TextStyle(
                            //           fontFamily: 'NotoSansKR',
                            //           fontWeight: FontWeight.w400,
                            //           fontSize: 12,
                            //           color: Colors.grey,
                            //           height: 1.0,
                            //         ),
                            //       );
                            //     } else {
                            //       return GestureDetector(
                            //         onTap: () {
                            //           Navigator.push(
                            //             context,
                            //             MaterialPageRoute(builder:  (context) => StoreDetailScreen()),
                            //           );
                            //         },
                            //         child: Text(
                            //           '가게 이름 Store',
                            //           style: TextStyle(
                            //             fontFamily: 'NotoSansKR',
                            //             fontWeight: FontWeight.w400,
                            //             fontSize: 12,
                            //             color: Colors.grey,
                            //             height: 1.0,
                            //           ),
                            //         ),
                            //       );
                            //     }
                            //   },
                            // ),
                            // Text(
                            //   '가게 이름 Store',
                            //   style: TextStyle(
                            //     fontFamily: 'NotoSansKR',
                            //     fontWeight: FontWeight.w400,
                            //     fontSize: 12,
                            //     color: Colors.grey,
                            //     height: 1.0,
                            //   ),
                            // ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    '${item.i_name}',
                                    style: TextStyle(
                                      fontFamily: 'NotoSansKR',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      height: 1.0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  '${_formatAddress(item.i_address)} · ${_mapTypeToString(item.c_type)} · ',
                                  style: TextStyle(
                                    fontFamily: 'NotoSansKR',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey,
                                    height: 1.0,
                                  ),
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  size: 20,
                                  color: Colors.yellow,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  '${item.averageScore}',
                                  style: TextStyle(
                                    fontFamily: 'NotoSansKR',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey,
                                    height: 1.0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${formatter.format(item.i_price)}원 ~',
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


