import 'package:busan_trip/screen/booking_calendar_screen.dart';
import 'package:busan_trip/screen/pay_screen.dart';
import 'package:busan_trip/screen/item_review_list_screen.dart';
import 'package:busan_trip/screen/root_screen.dart';
import 'package:busan_trip/screen/store_detail_screen.dart';
import 'package:busan_trip/screen/test1.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemDetailScreen2 extends StatefulWidget {
  const ItemDetailScreen2({super.key});

  @override
  State<ItemDetailScreen2> createState() => _ItemDetailScreen2State();
}

class _ItemDetailScreen2State extends State<ItemDetailScreen2> {

  late Future<void> _loadingFuture;

  @override
  void initState() {
    super.initState();
    _loadingFuture = _simulateLoading();
  }

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 6));
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                  padding: EdgeInsets.symmetric(vertical: 17,),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Icon(Icons.share_outlined, size: 18, color: Colors.grey[600],),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder:  (context) => RootScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff0e4194),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  '결제하기',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
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
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 180.0,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'assets/images/lotteworld.jfif',
              fit: BoxFit.cover,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              DetailContent()
            ],
          ),
        ),
      ],
    );
  }
}

class DetailContent extends StatefulWidget {
  @override
  _DetailContentState createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  bool isFavorited = false;

  void toggleFavorite() {
    setState(() {
      isFavorited = !isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,  // Use screen width
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '롯데월드 어드벤처 부산',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                    GestureDetector(
                      onTap: toggleFavorite,
                      child: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_outline,
                        size: 20,
                        color: isFavorited ? Colors.red : Colors.black,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 20,
                            color: Colors.yellow,
                          ),
                          SizedBox(width: 2),
                          Text(
                            '4.8',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            ' · ',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Colors.grey[400],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder:  (context) => ItemReviewListScreen()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.black,width: 1.0),
                                ),
                              ),
                              child: Text(
                                '후기 763개',
                                style: TextStyle(
                                  fontFamily: 'NotoSansKR',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '12,000원 ',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '~',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey[200], thickness: 1.0,),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder:  (context) => StoreDetailScreen()),
                    // );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder:  (context) => StoreDetailScreen()),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            'https://scontent-ssn1-1.xx.fbcdn.net/v/t39.30808-6/332953938_1879697915719235_6365380102897356357_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=hes9gGl4of4Q7kNvgEKagxf&_nc_ht=scontent-ssn1-1.xx&oh=00_AYCezD298ihgq6Pr_APxLWaALs16AHtZB15Fv8yV9lio2g&oe=66D508B1',
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '롯데월드 어드벤처 부산',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey[200], thickness: 7.0,),
          _buildInfoSection(),
          Divider(color: Colors.grey[200], thickness: 7.0,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '상품 설명',
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
                        'https://image6.yanolja.com/leisure/eSeHbg8cH0gPskLE',
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        'https://image6.yanolja.com/leisure/achV2D1nsKKi4KsP',
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        'https://image6.yanolja.com/leisure/jbq0y0E4SCCpBVeX',
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        'https://image6.yanolja.com/leisure/86ccgNX3RHA8sQ0l',
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        'https://image6.yanolja.com/leisure/PDnHAa15yO2f0NML',
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        'https://image6.yanolja.com/leisure/kLHpL4hlSYZCItxS',
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        'https://image6.yanolja.com/leisure/uGJuI9R0WQEPxL3H',
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        'https://image6.yanolja.com/leisure/ch2khfEECTJESUcg',
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        'https://image6.yanolja.com/leisure/sd8CHbgrG90YJLo7',
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        'https://image6.yanolja.com/leisure/CoYb4UJB7KJHMZ3O',
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        'https://image6.yanolja.com/leisure/fyjtVXwzPMJgBe7c',
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      color: Colors.white,
      child: Padding(
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
          ],
        ),
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
            ),
          ),
          SizedBox(height: 5),
          Text(
            content,
            style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}