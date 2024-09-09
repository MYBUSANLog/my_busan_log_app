import 'package:busan_trip/model/review_model.dart';
import 'package:busan_trip/vo/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MyReviewListScreen extends StatefulWidget {
  const MyReviewListScreen({super.key});

  @override
  State<MyReviewListScreen> createState() => _MyReviewListScreenState();
}

class _MyReviewListScreenState extends State<MyReviewListScreen> {

  List<Uint8List> previewImgBytesList = [];

  @override
  Widget build(BuildContext context) {
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
            '내가 쓴 리뷰',
            style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Consumer<ReviewModel>(builder: (context, reviewModel, child) {
                  return Column(
                    children: reviewModel.myReviews.asMap().entries.map((entry) {
                      Review review = entry.value;
                      return MyReviewListCard(review: review);
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
        )
    );
  }
}

class MyReviewListCard extends StatelessWidget {
  Review review;

  MyReviewListCard({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '내가 쓴 리뷰 1개',
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey[200], thickness: 7.0,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 14),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 250,
                      child: Text(
                        '${review.i_name}',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 1.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      ' >',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        height: 1.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 20,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star_rounded,
                      size: 20,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star_rounded,
                      size: 20,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star_rounded,
                      size: 20,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star_rounded,
                      size: 20,
                      color: Colors.grey[300],
                    ),
                    SizedBox(width: 10),
                    Text(
                      '${review.created_date}',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.0,
                        color: Colors.grey[500]
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  '${review.r_content}',
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    height: 1.2,
                  ),
                  softWrap: true,
                  maxLines: 20,
                  overflow: TextOverflow.visible
                ),
                SizedBox(height: 12),
                Container(
                  height: 200,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            '${review.img_url}',
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(color: Colors.grey[200], thickness: 1.0,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 14),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 250,
                      child: Text(
                        '[부산 해운대] 블루라인파크 (~12/31)',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 1.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      ' >',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        height: 1.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 20,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star_rounded,
                      size: 20,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star_rounded,
                      size: 20,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star_rounded,
                      size: 20,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star_rounded,
                      size: 20,
                      color: Colors.amber,
                    ),
                    SizedBox(width: 10),
                    Text(
                      '2024-08-17',
                      style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 1.0,
                          color: Colors.grey[500]
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
                Text(
                    '부산 여행 계획세울때부터 블루라인파크는 꼭 가봐야겟다 해서 몇달전부터 존버해가지구 예약성공해서 다녀왔습니당! 처음타봤는데 너무 좋더라구요 ㅎㅎ 옆으로 펼쳐지는 바다풍경에 힐링 제대루 하고왔네용!!\n다음에 부산오면 또 타야겟습니당ㅎㅎ 저렴하게 잘탔어용!',
                    style: TextStyle(
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      height: 1.2,
                    ),
                    softWrap: true,
                    maxLines: 20,
                    overflow: TextOverflow.visible
                ),
                SizedBox(height: 12),
                Container(
                  height: 200,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://search.pstatic.net/common/?src=https%3A%2F%2Fpup-review-phinf.pstatic.net%2FMjAyNDA3MThfMTc0%2FMDAxNzIxMzExNjg1NjY3.kjTcat4P3PRe-qyFik_HSk40vY52o02rN9miYxC9s-kg.pbMpszfi9BHmmL1uqfGC7NOM9lH0NIybvipIqoSSxX8g.JPEG%2F20240716_144636.jpg.jpg%3Ftype%3Dw1500_60_sharpen',
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://search.pstatic.net/common/?src=https%3A%2F%2Fpup-review-phinf.pstatic.net%2FMjAyNDA4MjBfOTgg%2FMDAxNzI0MTYyMjU5Nzgw.xljY7JFmsK6th8udWio4KhHY3flDf_syUhmbNCgO5vAg.mGX7kB4CyhfffxZcgIArn1I7uBZnH3GbFgRAbqa6-OEg.JPEG%2FD87D355F-21B2-485B-8E09-8EC5F7C3318A.jpeg%3Ftype%3Dw1500_60_sharpen',
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
