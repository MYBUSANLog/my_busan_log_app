import 'package:busan_trip/app_http/review_http.dart';
import 'package:busan_trip/model/review_model.dart';
import 'package:busan_trip/vo/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MyReviewListScreen extends StatefulWidget {
  final int u_idx;
  const MyReviewListScreen({super.key, required this.u_idx});

  @override
  State<MyReviewListScreen> createState() => _MyReviewListScreenState();
}

class _MyReviewListScreenState extends State<MyReviewListScreen> {
  late Future<List<Review>> _reviews;
  late Future<int> _reviewsNum;

  @override
  void initState() {
    super.initState();
    _reviews = ReviewHttp.fetchMyReviewAll(widget.u_idx);
    _reviewsNum = ReviewHttp.fetchMyReviewNum(widget.u_idx);
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
        title: Text(
          '내가 쓴 리뷰',
          style: TextStyle(
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      // 리뷰 개수를 먼저 처리하는 FutureBuilder
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

          // 리뷰 리스트를 처리하는 FutureBuilder
          return FutureBuilder<List<Review>>(
            future: _reviews,
            builder: (context, reviewSnapshot) {
              if (reviewSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (reviewSnapshot.hasError) {
                return Center(child: Text('리뷰 데이터를 가져오는 중 오류가 발생했습니다.'));
              } else if (!reviewSnapshot.hasData || reviewSnapshot.data!.isEmpty) {
                return Center(child: Text('리뷰가 없습니다.'));
              }

              final reviews = reviewSnapshot.data!;

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
                            '최근 리뷰 ($reviewCount개)', // 리뷰 개수를 표시
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              height: 1.0,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey[200], thickness: 7.0),
                    // 리뷰 리스트를 반복하여 화면에 표시합니다.
                    ...reviews.map((review) => MyReviewListCard(review: review)).toList(),
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

class MyReviewListCard extends StatelessWidget {
  final Review review;

  MyReviewListCard({required this.review});

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
                          //유저
                          review.u_img_url.isNotEmpty ? review.u_img_url : 'https://cdn.pixabay.com/photo/2020/05/17/20/21/cat-5183427_1280.jpg',
                          //아이템
                          //review.i_image.isNotEmpty ? review.i_image : 'https://cdn.pixabay.com/photo/2020/05/17/20/21/cat-5183427_1280.jpg',
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
                              //review.i_name,
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
                              formattedDate,
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
