import 'package:busan_trip/screen/booking_calendar_screen.dart';
import 'package:busan_trip/screen/item_detail_screen2.dart';
import 'package:busan_trip/screen/review_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'item_detail_screen.dart';

class StoreDetailScreen extends StatefulWidget {
  const StoreDetailScreen({super.key});

  @override
  State<StoreDetailScreen> createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> with SingleTickerProviderStateMixin {

  late Future<void> _loadingFuture;
  late ScrollController _scrollController;
  static const kHeaderHeight = 200.0;
  late TabController _tabController;

  final GlobalKey _detailKey = GlobalKey();
  final GlobalKey _itemKey = GlobalKey();
  final GlobalKey _infoKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadingFuture = _simulateLoading();
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        if (_tabController.indexIsChanging) {
          _scrollToTab(_tabController.index);
        }
      });
  }

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 3));
  }

  void _scrollToTab(int index) {
    // 각 탭에 대응하는 `GlobalKey`를 설정합니다.
    final GlobalKey? key = index == 0
        ? _detailKey
        : index == 1
        ? _itemKey
        : _infoKey;

    if (key != null && key.currentContext != null) {
      final RenderBox? renderBox = key.currentContext!.findRenderObject() as RenderBox?;
      final double? scrollPosition = renderBox?.localToGlobal(Offset.zero).dy;

      if (scrollPosition != null) {
        _scrollController.animateTo(
          scrollPosition,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
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
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 180.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                        height: 20,
                        width: 200,
                      ),
                    ),
                    SizedBox(height: 20),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                        height: 35,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 10),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                        height: 20,
                        width: 100,
                      ),
                    ),
                    SizedBox(height: 20),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                        height: 20,
                        width: 150,
                      ),
                    ),
                    SizedBox(height: 20),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                        height: 25,
                        width: 150,
                      ),
                    ),
                    SizedBox(height: 10),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                        height: 200,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 10),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                        height: 200,
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailContent() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: kHeaderHeight,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double percentage = (constraints.maxHeight - kToolbarHeight) /
                  (kHeaderHeight - kToolbarHeight);
              return FlexibleSpaceBar(
                background: Stack(
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.darken,
                      ),
                      child: Image.asset(
                        'assets/images/lotteworld.jfif',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: kHeaderHeight / 2,
                      left: 16,
                      child: Opacity(
                        opacity: percentage.clamp(0.0, 1.0),
                        child: Row(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'https://scontent-ssn1-1.xx.fbcdn.net/v/t39.30808-6/332953938_1879697915719235_6365380102897356357_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=hes9gGl4of4Q7kNvgEKagxf&_nc_ht=scontent-ssn1-1.xx&oh=00_AYCezD298ihgq6Pr_APxLWaALs16AHtZB15Fv8yV9lio2g&oe=66D508B1',
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '롯데월드 어드벤처 부산',
                              style: TextStyle(
                                fontFamily: 'Noto Sans KR',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          iconTheme: IconThemeData(
            color: _scrollController.hasClients &&
                _scrollController.offset >
                    kHeaderHeight - kToolbarHeight
                ? Colors.black
                : Colors.white,
          ),
          elevation: 0,
        ),
        SliverPersistentHeader(
          delegate: _SliverAppBarDelegate(
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: '상점 소개'),
                Tab(text: '판매 상품'),
                Tab(text: '이용 안내',)
              ],
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black,
              indicatorColor: Color(0xff0e4194),
            ),
          ),
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              DetailContent(
                key: _detailKey,
                scrollController: _scrollController,
              ),
              ItemSection(
                key: _itemKey,
                scrollController: _scrollController,
              ),
              InfoSection(
                key: _infoKey,
                scrollController: _scrollController,
              ),
            ],
          ),
        ),
      ],
    );
  }


}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class DetailContent extends StatelessWidget {
  final ScrollController scrollController;

  DetailContent({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '상점 소개',
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey[200], thickness: 1.0,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Image.network(
                        'https://adventurebusan.lotteworld.com/common/images/partnership-img1.jpg',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 15),
                      Text(
                        '마법과 환상의 세계! 롯데월드 어드벤처가 부산에서 개장했다. 숲 속의 청량함과 짜릿한 스릴감을 완벽하게 즐길 수 있도록 준비되어 있다. 놀이공원하면 떠오르는 언제나 즐겁고 신나는 공연 그리고 퍼레이드를 경험할 수 있다. 부산롯데월드는 대한민국 제2의 도시라고 불리는 부산에 세워진 데다 대중교통을 이용한 접근성도 편리해 개장 첫날부터 끊임없는 발길이 이어지고 있다. 롯데월드 부산은 6개의 테마존으로 꾸려져 있다. 요정 마을 팅커폴스 존 중심에 토킹트리가 있는데 이 나무는 애니매트로닉스 기술이 적용되어 파크 내 6개 테마에 관한 이야기를 들려준다. 롯데월드 내 가장 높은 곳에 위치한 로얄가든 존의 로리캐슬은 물에 떠 있는 듯한 모습으로 연출되어 있으며 부산의 전경과 함께 기장 앞바다를 한눈에 즐길 수 있다. 이외의 놀이 기구들 특히 자이언트 디거, 자이언트 스플래쉬 등 대표 어트랙션은 그 짜릿함이 벌써 입소문을 타고 있다. 이렇게 어른들을 위한 어트랙션뿐만 아니라 유아를 동반한 가족 이용객을 위한 놀이 기구도 준비되어 있다. 날씨와 관계없이 아이와 안전하게 즐길 수 있도록 실내에 배치되어 있다. 놀이공원의 하이라이트라고 할 수 있는 퍼레이드는 하루에 2번, 약 30분간 진행된다.',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey[200], thickness: 7.0,),
        ],
      )
    );
  }
}

class ItemSection extends StatelessWidget {
  final ScrollController scrollController;

  ItemSection({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '판매 상품',
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey[200], thickness: 1.0,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FavoriteCard(),
                      SizedBox(height: 10),
                      FavoriteCard(),
                      SizedBox(height: 10),
                      FavoriteCard(),
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
  Widget _buildInfoRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: Colors.grey[600]
            ),
          ),
          SizedBox(height: 5),
          Text(
            content,
            style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class InfoSection extends StatelessWidget {
  final ScrollController scrollController;

  InfoSection({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '이용 안내',
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey[200], thickness: 1.0,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow('주소', '부산광역시 기장군 기장읍 동부산관광로 42'),
                          _buildInfoRow('홈페이지', 'https://adventurebusan.lotteworld.com/kor/main/index.do'),
                          _buildInfoRow('운영요일 및 시간', '매일 10:00 ~ 20:00 (* 자세한 운영시간은 홈페이지 참조)'),
                          _buildInfoRow('전화번호', '1661-2000'),
                          _buildInfoRow('휴무일', '연중휴무 (* 기상상황에 따른 운휴)'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildInfoRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: Colors.grey[600]
            ),
          ),
          SizedBox(height: 5),
          Text(
            content,
            style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w400,
              fontSize: 16,
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
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemDetailScreen2()),
                  );
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240327_99%2F1711515295127evmbz_JPEG%2F%25B7%25CE%25B8%25AE%25BF%25A9%25BF%25D5.jpg',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '롯데월드 어드벤처 부산',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.grey[600],
                              height: 1.0,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  '[QR바로입장] 부산 롯데월드 어드벤처',
                                  style: TextStyle(
                                    fontFamily: 'NotoSansKR',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    height: 1.0,
                                  ), overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Visibility(
                                visible: false,
                                child: GestureDetector(
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
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Text(
                            '부산광역시 기장군 · 테마파크',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.grey[600],
                              height: 1.0,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '12,000원 ~',
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
            ),
          ),
        ],
      ),
    );
  }
}