import 'package:busan_trip/vo/review.dart';
import 'package:flutter/material.dart';

import '../app_http/review_http.dart';
import 'package:intl/intl.dart';

class ItemReviewListScreen extends StatefulWidget {
  final int i_idx;  // i_idx를 받도록 선언

  // 생성자를 통해 i_idx를 전달받도록 설정
  const ItemReviewListScreen({super.key, required this.i_idx});

  @override
  State<ItemReviewListScreen> createState() => _ItemReviewListScreenState();
}

class _ItemReviewListScreenState extends State<ItemReviewListScreen> {
  // 상태 변수로 Future 타입의 리뷰 리스트를 선언합니다.
  late Future<List<Review>> _reviews;
  late Future<int> _reviewsNum;
  @override
  void initState() {
    super.initState();
    // initState에서 서버로부터 리뷰 데이터를 가져옵니다.
    // 전달받은 i_idx 값을 기반으로 데이터를 가져옵니다.
    _reviews = ReviewHttp.fetchItemReviewAll(widget.i_idx);
    _reviewsNum = ReviewHttp.fetchItemReviewNum(widget.i_idx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        // FutureBuilder를 사용하여 제목을 비동기적으로 설정
        title: FutureBuilder<List<Review>>(
          future: _reviews,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('로딩 중...'); // 데이터 로딩 중일 때
            } else if (snapshot.hasError) {
              return Text('오류 발생'); // 오류 발생 시
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('리뷰 없음'); // 데이터가 없을 때
            }

            // 첫 번째 리뷰의 i_name을 가져와서 AppBar에 표시
            final String iName = snapshot.data![0].i_name;
            return Text(
              '$iName 리뷰', // 아이템 이름 표시
              style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            );
          },
        ),
        centerTitle: true,
      ),
      // FutureBuilder를 사용하여 비동기 데이터를 처리합니다.
      body: FutureBuilder<int>(
        future: _reviewsNum, // 리뷰 개수를 가져오는 Future
        builder: (context, reviewNumSnapshot) {
          if (reviewNumSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (reviewNumSnapshot.hasError) {
            return Center(child: Text('리뷰 개수를 가져오는 중 오류가 발생했습니다.'));
          }

          // 리뷰 개수 가져오기 성공
          final reviewCount = reviewNumSnapshot.data ?? 0;

          return FutureBuilder<List<Review>>(
            future: _reviews,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('오류가 발생했습니다.'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('리뷰가 없습니다.'));
              }

              // 데이터가 있을 때 리스트로 리뷰들을 화면에 표시합니다.
              final reviews = snapshot.data!;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    // 리뷰 헤더 부분입니다.
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '최근 리뷰 ($reviewCount개)',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              height: 1.0,
                            ),
                          ),
                          Divider(color: Colors.grey[200], thickness: 7.0,),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey[200], thickness: 7.0),
                    // 리뷰 리스트를 반복하여 화면에 표시합니다.
                    ...reviews.map((review) => ItemReviewListCard(review: review)).toList(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

}

// 리뷰 카드를 나타내는 위젯입니다.
class ItemReviewListCard extends StatelessWidget {
  final Review review;

  // 생성자에서 Review 객체를 받아옵니다.
  ItemReviewListCard({required this.review});

  @override
  Widget build(BuildContext context) {
    // review.created_date를 DateTime으로 변환하고 포맷팅합니다.
    DateTime reviewDate = DateTime.parse(review.created_date);
    String formattedDate = DateFormat('yyyy-MM-dd').format(reviewDate);

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // 리뷰 내용이 표시되는 본문 부분입니다.
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 사용자 프로필 사진과 닉네임을 표시하는 부분입니다.
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 프로필 이미지를 원형으로 표시합니다.
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          review.u_img_url.isNotEmpty ? review.u_img_url : 'https://cdn.pixabay.com/photo/2020/05/17/20/21/cat-5183427_1280.jpg',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 닉네임과 리뷰 작성일을 표시합니다.
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.u_nick,
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                height: 1.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // 별점과 작성일을 표시하는 부분입니다.
                            StarPointCard(reviewScore: review.r_score),
                            SizedBox(width: 10),
                            Text(
                              formattedDate, // 포맷팅된 날짜를 사용합니다.
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                // 리뷰 내용을 표시합니다.
                Text(
                  review.r_content,
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    height: 1.2,
                  ),
                  softWrap: true,
                  maxLines: 20,
                  overflow: TextOverflow.visible,
                ),
                SizedBox(height: 15),
                // 리뷰에 포함된 이미지들을 표시합니다.
                buildImageRow(review.img_url),
              ],
            ),
          ),
          Divider(color: Colors.grey[200], thickness: 1.0,),
        ],
      ),
    );
  }
}

// 리뷰의 별점(점수)을 표시하는 위젯입니다.
class StarPointCard extends StatelessWidget {
  final double reviewScore;

  StarPointCard({super.key, required this.reviewScore});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          // 별 아이콘을 동적으로 생성하여 점수에 맞는 별 개수를 표시합니다.
          buildStarIcons(reviewScore),
        ],
      ),
    );
  }

  // 점수에 맞춰서 별 아이콘을 생성하는 함수입니다.
  Widget buildStarIcons(double score) {
    int fullStars = score.floor(); // 정수 부분의 별 개수
    bool hasHalfStar = (score - fullStars) >= 0.5; // 소수 부분이 0.5 이상이면 반쪽 별을 추가
    int totalStars = 5; // 최대 별 개수

    List<Widget> stars = [];

    // 정수 부분의 별을 생성합니다.
    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(
        Icons.star_rounded,
        size: 20,
        color: Colors.amber,
      ));
    }

    // 반쪽 별을 생성합니다.
    if (hasHalfStar) {
      stars.add(Icon(
        Icons.star_half_rounded,
        size: 20,
        color: Colors.amber,
      ));
    }

    // 남은 부분은 빈 별로 채웁니다.
    while (stars.length < totalStars) {
      stars.add(Icon(
        Icons.star_rounded,
        size: 20,
        color: Colors.grey[300],
      ));
    }

    return Row(children: stars);
  }
}

// 이미지 리스트를 가로로 스크롤할 수 있게 표시하는 함수입니다.
Widget buildImageRow(List<String> imgUrls) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,  // 수평 스크롤
    child: Row(
      // 이미지 리스트를 받아와서 각각의 이미지를 표시합니다.
      children: imgUrls.map((url) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              url,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    ),
  );
}
