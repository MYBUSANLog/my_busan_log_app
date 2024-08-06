import 'package:busan_trip/screen/profile_screen.dart';
import 'package:busan_trip/screen/restaurant_map.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _loadingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildSkeletonLoader();
          } else {
            return _buildDetailContent();
          }
        },
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery
              .of(context)
              .size
              .height, // 최소 높이를 화면 높이로 설정
        ),
        child: IntrinsicHeight(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Untitled',
                      style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w500,
                          fontSize: 35),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          Icon(Icons.search_outlined, size: 35),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.grey[300],
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.grey[300],
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.grey[300],
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.grey[300],
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.grey[300],
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.grey[300],
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                        height: 30,
                        width: 200,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                        height: 20,
                        width: 30,
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.grey, thickness: 1.0,),
                SizedBox(height: 10,),
                RealTimeListSkeleton(),
                SizedBox(height: 15,),
                RealTimeListSkeleton(),
                SizedBox(height: 15,),
                RealTimeListSkeleton(),
                SizedBox(height: 15,),
                RealTimeListSkeleton(),
                SizedBox(height: 15,),
                RealTimeListSkeleton(),
                SizedBox(height: 10,),
                Divider(color: Colors.grey, thickness: 1.0,),
                SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailContent() {
    final SearchController controller = SearchController();

    String? _currentQuery;

    // The most recent suggestions received from the API.
    late Iterable<Widget> _lastOptions = <Widget>[];

    late final _Debounceable<Iterable<String>?, String> _debouncedSearch;

    // Calls the "remote" API to search with the given query. Returns null when
    // the call has been made obsolete.
    Future<Iterable<String>?> _search(String query) async {
      _currentQuery = query;

      // In a real application, there should be some error handling here.
      final Iterable<String> options = await _FakeAPI.search(_currentQuery!);

      // If another search happened after this one, throw away these options.
      if (_currentQuery != query) {
        return null;
      }
      _currentQuery = null;

      return options;
    }

    @override
    void initState() {
      super.initState();
      _debouncedSearch = _debounce<Iterable<String>?, String>(_search);
    }

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery
              .of(context)
              .size
              .height, // 최소 높이를 화면 높이로 설정
        ),
        child: IntrinsicHeight(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Untitled',
                      style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w500,
                          fontSize: 35),
                    ),
                    SearchAnchor(
                      builder: (BuildContext context, SearchController controller) {
                        return IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            controller.openView();
                          },
                        );
                      },
                      suggestionsBuilder:
                          (BuildContext context, SearchController controller) async {
                        final List<String>? options =
                        (await _debouncedSearch(controller.text))?.toList();
                        if (options == null) {
                          return _lastOptions;
                        }
                        _lastOptions = List<ListTile>.generate(options.length, (int index) {
                          final String item = options[index];
                          return ListTile(
                            title: Text(item),
                            onTap: () {
                              debugPrint('You just selected $item');
                            },
                          );
                        });

                        return _lastOptions;
                      },
                    ),

                  ],
                ),
                SizedBox(height: 20,),
                sliderWidget(),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Icon(Icons.hotel, size: 35),
                            Text('호텔', style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Icon(Icons.attractions_outlined, size: 35),
                            Text('테마파크', style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Icon(Icons.vrpano_outlined, size: 35),
                            Text('전시회', style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Icon(Icons.beach_access_outlined, size: 35),
                            Text('휴양지', style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Icon(Icons.local_mall_outlined, size: 35),
                            Text('복합쇼핑몰', style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('실시간 핫플레이스',
                      style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w500,
                          fontSize: 23
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/realtime_list_screen');
                      },
                      child: Column(
                        children: [
                          Text('더보기 >',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.grey, thickness: 1.0,),
                SizedBox(height: 10,),
                FavoriteCard(),
                SizedBox(height: 15,),
                FavoriteCard(),
                SizedBox(height: 15,),
                FavoriteCard(),
                SizedBox(height: 15,),
                FavoriteCard(),
                SizedBox(height: 15,),
                FavoriteCard(),
                SizedBox(height: 10,),
                Divider(color: Colors.grey, thickness: 1.0,),
                SizedBox(height: 30,),
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
                    SizedBox(height: 5,),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text('ⓘ 광고 ',
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
                SizedBox(height: 35,),
                Column(
                  children: [
                    FeedCard(),
                    FeedCard(),
                    FeedCard(),
                    FeedCard(),
                    FeedCard(),
                    FeedCard(),
                    FeedCard(),
                    FeedCard(),
                    FeedCard(),
                    FeedCard(),
                    SizedBox(height: 20,),
                  ],
                )
              ],
            ),
          ),
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
          height: 240,
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
}

class RealTimeListSkeleton extends StatefulWidget {
  const RealTimeListSkeleton({super.key});

  @override
  State<RealTimeListSkeleton> createState() => _RealTimeListSkeletonState();
}

class _RealTimeListSkeletonState extends State<RealTimeListSkeleton> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Row(
          //   children: [
          //     Text(
          //       '1',
          //       style: TextStyle(
          //         fontFamily: 'NotoSansKR',
          //         fontWeight: FontWeight.w500,
          //         fontSize: 15,
          //       ),
          //     ),
          //     SizedBox(width: 13,),
          //     ClipRRect(
          //       borderRadius: BorderRadius.circular(10),
          //       child: Image.network(
          //         'https://naverbooking-phinf.pstatic.net/20231115_165/1700025251077cwP9b_JPEG/%C0%FC%BD%C3_%BF%AC%C0%E5_%C6%F7%BD%BA%C5%CD_1%B4%EB1_%B0%ED%C8%AD%C1%FA.jpg?type=w1500',
          //         width: 75,
          //         height: 75,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //     SizedBox(width: 10,),
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                   '상실의 징후들',
          //                   style: TextStyle(
          //                     fontFamily: 'NotoSansKR',
          //                     fontWeight: FontWeight.w500,
          //                     fontSize: 17,
          //                     height: 1.0,
          //                   ), overflow: TextOverflow.ellipsis
          //               ),
          //               GestureDetector(
          //                 onTap: toggleFavorite,
          //                 child: Column(
          //                   children: [
          //                     Icon(
          //                       isFavorited ? Icons.favorite : Icons.favorite_outline,
          //                       size: 25,
          //                       color: Colors.red,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //           SizedBox(height: 7,),
          //           Text(
          //             '부산 해운대구 · 전시회 · 후기 99+',
          //             style: TextStyle(
          //               fontFamily: 'NotoSansKR',
          //               fontWeight: FontWeight.w400,
          //               fontSize: 12,
          //               color: Colors.grey,
          //               height: 1.0,
          //             ),
          //           ),
          //           SizedBox(height: 15),
          //           Align(
          //             alignment: Alignment.centerRight,
          //             child: Text(
          //               '16,000원~',
          //               style: TextStyle(
          //                 fontFamily: 'NotoSansKR',
          //                 fontWeight: FontWeight.w500,
          //                 fontSize: 17,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 15,),
          // Row(
          //   children: [
          //     Text(
          //       '2',
          //       style: TextStyle(
          //         fontFamily: 'NotoSansKR',
          //         fontWeight: FontWeight.w500,
          //         fontSize: 15,
          //       ),
          //     ),
          //     SizedBox(width: 13,),
          //     ClipRRect(
          //       borderRadius: BorderRadius.circular(10),
          //       child: Image.network(
          //         'https://naverbooking-phinf.pstatic.net/20230125_49/1674627945913HU8OQ_JPEG/%B8%DE%C0%CE%B9%E8%B3%CA.jpg',
          //         width: 75,
          //         height: 75,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //     SizedBox(width: 10,),
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                   '스카이라인루지 부산',
          //                   style: TextStyle(
          //                     fontFamily: 'NotoSansKR',
          //                     fontWeight: FontWeight.w500,
          //                     fontSize: 17,
          //                     height: 1.0,
          //                   ), overflow: TextOverflow.ellipsis
          //               ),
          //               GestureDetector(
          //                 onTap: toggleFavorite,
          //                 child: Column(
          //                   children: [
          //                     Icon(
          //                       isFavorited ? Icons.favorite : Icons.favorite_outline,
          //                       size: 25,
          //                       color: Colors.red,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //           SizedBox(height: 7,),
          //           Text(
          //             '부산 기장군 · 엑티비티 · 후기 99+',
          //             style: TextStyle(
          //               fontFamily: 'NotoSansKR',
          //               fontWeight: FontWeight.w400,
          //               fontSize: 12,
          //               color: Colors.grey,
          //               height: 1.0,
          //             ),
          //           ),
          //           SizedBox(height: 15),
          //           Align(
          //             alignment: Alignment.centerRight,
          //             child: Text(
          //               '12,000원~',
          //               style: TextStyle(
          //                 fontFamily: 'NotoSansKR',
          //                 fontWeight: FontWeight.w500,
          //                 fontSize: 17,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 15,),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detail_screen');
            },
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.grey[300],
                    height: 10,
                    width: 10,
                  ),
                ),
                SizedBox(width: 13,),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.grey[300],
                    height: 75,
                    width: 75,
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
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              color: Colors.grey[300],
                              height: 25,
                              width: 200,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Column(
                              children: [
                                Icon(
                                  Icons.favorite_outline,
                                  size: 25,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7,),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.grey[300],
                          height: 15,
                          width: 250,
                        ),
                      ),
                      SizedBox(height: 15),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.grey[300],
                          height: 17,
                          width: 100,
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

class FavoriteCard extends StatefulWidget {
  const FavoriteCard({super.key});

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  bool isFavorited = false;

  void toggleFavorite() {
    setState(() {
      isFavorited = !isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Row(
          //   children: [
          //     Text(
          //       '1',
          //       style: TextStyle(
          //         fontFamily: 'NotoSansKR',
          //         fontWeight: FontWeight.w500,
          //         fontSize: 15,
          //       ),
          //     ),
          //     SizedBox(width: 13,),
          //     ClipRRect(
          //       borderRadius: BorderRadius.circular(10),
          //       child: Image.network(
          //         'https://naverbooking-phinf.pstatic.net/20231115_165/1700025251077cwP9b_JPEG/%C0%FC%BD%C3_%BF%AC%C0%E5_%C6%F7%BD%BA%C5%CD_1%B4%EB1_%B0%ED%C8%AD%C1%FA.jpg?type=w1500',
          //         width: 75,
          //         height: 75,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //     SizedBox(width: 10,),
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                   '상실의 징후들',
          //                   style: TextStyle(
          //                     fontFamily: 'NotoSansKR',
          //                     fontWeight: FontWeight.w500,
          //                     fontSize: 17,
          //                     height: 1.0,
          //                   ), overflow: TextOverflow.ellipsis
          //               ),
          //               GestureDetector(
          //                 onTap: toggleFavorite,
          //                 child: Column(
          //                   children: [
          //                     Icon(
          //                       isFavorited ? Icons.favorite : Icons.favorite_outline,
          //                       size: 25,
          //                       color: Colors.red,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //           SizedBox(height: 7,),
          //           Text(
          //             '부산 해운대구 · 전시회 · 후기 99+',
          //             style: TextStyle(
          //               fontFamily: 'NotoSansKR',
          //               fontWeight: FontWeight.w400,
          //               fontSize: 12,
          //               color: Colors.grey,
          //               height: 1.0,
          //             ),
          //           ),
          //           SizedBox(height: 15),
          //           Align(
          //             alignment: Alignment.centerRight,
          //             child: Text(
          //               '16,000원~',
          //               style: TextStyle(
          //                 fontFamily: 'NotoSansKR',
          //                 fontWeight: FontWeight.w500,
          //                 fontSize: 17,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 15,),
          // Row(
          //   children: [
          //     Text(
          //       '2',
          //       style: TextStyle(
          //         fontFamily: 'NotoSansKR',
          //         fontWeight: FontWeight.w500,
          //         fontSize: 15,
          //       ),
          //     ),
          //     SizedBox(width: 13,),
          //     ClipRRect(
          //       borderRadius: BorderRadius.circular(10),
          //       child: Image.network(
          //         'https://naverbooking-phinf.pstatic.net/20230125_49/1674627945913HU8OQ_JPEG/%B8%DE%C0%CE%B9%E8%B3%CA.jpg',
          //         width: 75,
          //         height: 75,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //     SizedBox(width: 10,),
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                   '스카이라인루지 부산',
          //                   style: TextStyle(
          //                     fontFamily: 'NotoSansKR',
          //                     fontWeight: FontWeight.w500,
          //                     fontSize: 17,
          //                     height: 1.0,
          //                   ), overflow: TextOverflow.ellipsis
          //               ),
          //               GestureDetector(
          //                 onTap: toggleFavorite,
          //                 child: Column(
          //                   children: [
          //                     Icon(
          //                       isFavorited ? Icons.favorite : Icons.favorite_outline,
          //                       size: 25,
          //                       color: Colors.red,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //           SizedBox(height: 7,),
          //           Text(
          //             '부산 기장군 · 엑티비티 · 후기 99+',
          //             style: TextStyle(
          //               fontFamily: 'NotoSansKR',
          //               fontWeight: FontWeight.w400,
          //               fontSize: 12,
          //               color: Colors.grey,
          //               height: 1.0,
          //             ),
          //           ),
          //           SizedBox(height: 15),
          //           Align(
          //             alignment: Alignment.centerRight,
          //             child: Text(
          //               '12,000원~',
          //               style: TextStyle(
          //                 fontFamily: 'NotoSansKR',
          //                 fontWeight: FontWeight.w500,
          //                 fontSize: 17,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 15,),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detail_screen');
            },
            child: Row(
              children: [
                Text(
                  '3',
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                SizedBox(width: 13,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240327_99%2F1711515295127evmbz_JPEG%2F%25B7%25CE%25B8%25AE%25BF%25A9%25BF%25D5.jpg',
                    width: 75,
                    height: 75,
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
                              '롯데월드 어드벤처 부산',
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                height: 1.0,
                              ), overflow: TextOverflow.ellipsis
                          ),
                          GestureDetector(
                            onTap: toggleFavorite,
                            child: Column(
                              children: [
                                Icon(
                                  isFavorited ? Icons.favorite : Icons.favorite_outline,
                                  size: 25,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7,),
                      Text(
                        '부산 기장군 · 테마파크 · 후기 99+',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey,
                          height: 1.0,
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
          ),
          // SizedBox(height: 15,),
          // Row(
          //   children: [
          //     Text(
          //       '4',
          //       style: TextStyle(
          //         fontFamily: 'NotoSansKR',
          //         fontWeight: FontWeight.w500,
          //         fontSize: 15,
          //       ),
          //     ),
          //     SizedBox(width: 13,),
          //     ClipRRect(
          //       borderRadius: BorderRadius.circular(10),
          //       child: Image.network(
          //         'https://i.namu.wiki/i/epC9umUbZzxIJvrmlaCBo7CO2BwHfxyVbbYq7VnB2XFyj4mpu_uG0ZLg0F0XUFzGS9omLZ66SsZcp-n7x_YinScT8Azdc3bkcHZ67a40JIyr1fsq8HF3TKrNk8ZUMYB_HHosAmd_IZHqfyiBespbUw.webp',
          //         width: 75,
          //         height: 75,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //     SizedBox(width: 10,),
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                   '신세계백화점 센텀시티점',
          //                   style: TextStyle(
          //                     fontFamily: 'NotoSansKR',
          //                     fontWeight: FontWeight.w500,
          //                     fontSize: 17,
          //                     height: 1.0,
          //                   ), overflow: TextOverflow.ellipsis
          //               ),
          //               GestureDetector(
          //                 onTap: toggleFavorite,
          //                 child: Column(
          //                   children: [
          //                     Icon(
          //                       isFavorited ? Icons.favorite : Icons.favorite_outline,
          //                       size: 25,
          //                       color: Colors.red,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //           SizedBox(height: 7,),
          //           Text(
          //             '부산 해운대구 · 복합쇼핑몰 · 후기 99+',
          //             style: TextStyle(
          //               fontFamily: 'NotoSansKR',
          //               fontWeight: FontWeight.w400,
          //               fontSize: 12,
          //               color: Colors.grey,
          //               height: 1.0,
          //             ),
          //           ),
          //           SizedBox(height: 15),
          //           Align(
          //             alignment: Alignment.centerRight,
          //             child: Text(
          //               '0원',
          //               style: TextStyle(
          //                 fontFamily: 'NotoSansKR',
          //                 fontWeight: FontWeight.w500,
          //                 fontSize: 17,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 15,),
          // Row(
          //   children: [
          //     Text(
          //       '5',
          //       style: TextStyle(
          //         fontFamily: 'NotoSansKR',
          //         fontWeight: FontWeight.w500,
          //         fontSize: 15,
          //       ),
          //     ),
          //     SizedBox(width: 13,),
          //     ClipRRect(
          //       borderRadius: BorderRadius.circular(10),
          //       child: Image.network(
          //         'https://i.namu.wiki/i/SfOtPBKLQsoKnp73v8bQ0llPsi9wuhM9HaIcf7TUjf5qNXjbjHPx4YKbJTsloZZiYCmEUnK8arhWXzaK-pQtIXKXi-HqZEk_QfQt0p0pmggqrYOOgOuIYGSDHEjI_LxiTJ1lH3AFaw6KAv7TznUbsw.webp',
          //         width: 75,
          //         height: 75,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //     SizedBox(width: 10,),
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                   '해운대 해수욕장',
          //                   style: TextStyle(
          //                     fontFamily: 'NotoSansKR',
          //                     fontWeight: FontWeight.w500,
          //                     fontSize: 17,
          //                     height: 1.0,
          //                   ), overflow: TextOverflow.ellipsis
          //               ),
          //               GestureDetector(
          //                 onTap: toggleFavorite,
          //                 child: Column(
          //                   children: [
          //                     Icon(
          //                       isFavorited ? Icons.favorite : Icons.favorite_outline,
          //                       size: 25,
          //                       color: Colors.red,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //           SizedBox(height: 7,),
          //           Text(
          //             '부산 해운대구 · 휴양지 · 후기 99+',
          //             style: TextStyle(
          //               fontFamily: 'NotoSansKR',
          //               fontWeight: FontWeight.w400,
          //               fontSize: 12,
          //               color: Colors.grey,
          //               height: 1.0,
          //             ),
          //           ),
          //           SizedBox(height: 15),
          //           Align(
          //             alignment: Alignment.centerRight,
          //             child: Text(
          //               '0원',
          //               style: TextStyle(
          //                 fontFamily: 'NotoSansKR',
          //                 fontWeight: FontWeight.w500,
          //                 fontSize: 17,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
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
                              Icons.remove_red_eye,
                              size: 20,
                              color: Colors.grey,
                            ),
                            Text(
                              ' 1576',
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.grey,
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

