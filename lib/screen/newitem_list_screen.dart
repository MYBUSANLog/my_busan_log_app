import 'package:busan_trip/screen/store_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../model/item_model.dart';
import '../model/store_model.dart';
import '../vo/item.dart';
import 'item_detail_screen.dart';



class NewitemListScreen extends StatefulWidget {
  const NewitemListScreen({super.key});

  @override
  State<NewitemListScreen> createState() => _NewitemListScreenState();
}

class _NewitemListScreenState extends State<NewitemListScreen> {
  final ScrollController _listScrollController = ScrollController();
  final ScrollController _buttonScrollController = ScrollController();
  int currentPage = 0;
  bool isLoading = false;
  bool _showScrollToTopButton = false;
  late Future<void> _loadingFuture;

  @override
  void initState() {
    super.initState();
    _loadingFuture = _simulateLoading();

    Provider.of<ItemModel>(context, listen: false).setAllItems(sortBy: 'latest');
    Provider.of<ItemModel>(context, listen: false).clearItems();
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
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      await Provider.of<ItemModel>(context, listen: false).setAllItems(sortBy: 'latest');

      setState(() {
        currentPage++;
      });
    } catch (e) {
      // 오류 처리
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    _buttonScrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _listScrollController.animateTo(
      0, // 맨 위로 이동
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 6));
  }

  Future<void> _refresh() async {
    // 새로고침할 때 실행할 로직 (API 호출 등)
    await Future.delayed(Duration(seconds: 1)); // 예시로 1초 딜레이
    // 데이터 갱신 로직 추가
    setState(() {
      Provider.of<ItemModel>(context, listen: false).setAllItems(sortBy: 'latest');
      Provider.of<ItemModel>(context, listen: false).clearItems();
    });
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ));

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            )
        ),
        elevation: 0,
        title: Text(
          '신규상품 모음.zip',
          style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<void>(
          future: _loadingFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildSkeletonLoader();
            } else {
              return _buildNewItemContent();
            }
          },
        ),
      ),
      floatingActionButton: _showScrollToTopButton
          ? FloatingActionButton(
        onPressed: _scrollToTop,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: Colors.grey[300]!,),
        ),
        child: Icon(
          Icons.keyboard_arrow_up,
          color: Colors.black,
          size: 30,
        ),
      )
          : null,
    );
  }

  Widget _buildSkeletonLoader() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.grey[300],
                height: 300,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.grey[300],
                    height: 300,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.grey[300],
                    height: 300,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildNewItemContent() {

    final AppBar appBar = AppBar(
      titleSpacing: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: Border(
        bottom: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      elevation: 0,
      title: Text(
        '신규상품 모음.zip',
        style: TextStyle(
          fontFamily: 'NotoSansKR',
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
    );

    final double availableHeight = MediaQuery.of(context).size.height - appBar.preferredSize.height;

    return Scaffold(
        body: SingleChildScrollView(
          controller: _listScrollController,
          child: Column(
            children: [
              Container(
                color: Colors.green,
                width: MediaQuery.of(context).size.width,
                height: availableHeight * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 20),
                      child: Text(
                        '새로 등록된',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          color: Colors.white,
                          height: 1.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20, bottom: 20),
                      child: Text(
                        '따끈따끈 신상상품 모음집',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w800,
                          fontSize: 28,
                          color: Colors.white,
                          height: 1.0,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Image.asset(
                          'assets/images/busan_map.png',
                          width: MediaQuery.of(context).size.width - 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // Image.network(
              //   'https://firebasestorage.googleapis.com/v0/b/mybusanlog-b600f.appspot.com/o/my_busan_log%2Fbanner%2Frealtime_list_banner.jpg?alt=media&token=0a91827b-8578-46da-8bce-5b6adc11143e',
              //   width: MediaQuery.of(context).size.width,
              // ),
              Consumer<ItemModel>(builder: (context, itemModel, child) {
                return Column(
                  children: [
                    ...itemModel.items.asMap().entries.map((entry) {
                      int index = entry.key;
                      Item item = entry.value;
                      return NewItemList(item: item, rank: index + 1);
                    }).toList(),
                    if (isLoading)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                  ],
                );
              }),
            ],
          ),
        )
    );
  }
}

class NewItemList extends StatelessWidget {
  final formatter = NumberFormat('#,###');
  final Item item;
  final int rank;

  NewItemList({required this.item, required this.rank, super.key});

  String _formatAddress(String address) {
    final parts = address.split(' ');

    if (parts.length >= 3) {
      return '${parts[0]} ${parts[1]}';
    }

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
        return '기타';
    }
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber[600]!; // 첫 번째 아이템은 노란색 배경
      case 2:
        return Colors.grey[600]!;   // 두 번째 아이템은 회색 배경
      case 3:
        return Colors.brown;  // 세 번째 아이템은 갈색 배경
      default:
        return Colors.black;  // 나머지는 검은색 배경
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ItemDetailScreen(item: item)),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // 그림자 색상
                spreadRadius: 2, // 그림자 퍼짐 정도
                blurRadius: 6, // 그림자 흐림 정도
                offset: Offset(0, 2), // 그림자의 위치
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Row(
                    children: [
                      // 첫 번째 이미지
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                          child: Image.network(
                            '${item.i_image}',
                            width: double.infinity,
                            height: 162,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 2), // 간격
                      Expanded(
                        child: Column(
                          children: [
                            // 두 번째 이미지
                            ClipRRect(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
                              child: Image.network(
                                '${item.i_image}',
                                width: double.infinity,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 2),
                            // 세 번째 이미지
                            ClipRRect(
                              child: Image.network(
                                '${item.i_image}',
                                width: double.infinity,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: _getRankColor(rank),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        '$rank',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Expanded를 사용하기 전에 높이 제약을 가진 위젯으로 감싸기
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Consumer<StoreModel>(
                    //   builder: (context, storeModel, child) {
                    //     final store = storeModel.getStoreById(item.s_idx);
                    //     if (store == null) {
                    //       storeModel.fetchStoreById(item.s_idx);
                    //       return Text(
                    //         'Loading...',
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
                    //             MaterialPageRoute(
                    //                 builder: (context) => StoreDetailScreen()),
                    //           );
                    //         },
                    //         child: Text(
                    //           '${store.s_name}',
                    //           style: TextStyle(
                    //             fontFamily: 'NotoSansKR',
                    //             fontWeight: FontWeight.w400,
                    //             fontSize: 14,
                    //             color: Colors.grey,
                    //             height: 1.0,
                    //           ),
                    //         ),
                    //       );
                    //     }
                    //   },
                    // ),
                    // SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${item.i_name}',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              height: 1.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 20,
                              color: Colors.amber,
                            ),
                            Text(
                              '${item.averageScore}',
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              ' (${item.review_count})',
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.grey[500],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    Row(
                      children: [
                        Text(
                          '${_formatAddress(item.i_address)}',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 1.0,
                          ),
                        ),
                        Text(
                          ' · ',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: Colors.grey[400],
                            height: 1.0,
                          ),
                        ),
                        Text(
                          '${_mapTypeToString(item.c_type)}',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
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
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
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
    );
  }
}