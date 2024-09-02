import 'package:flutter/material.dart';

class MyReviewListScreen extends StatefulWidget {
  const MyReviewListScreen({super.key});

  @override
  State<MyReviewListScreen> createState() => _MyReviewListScreenState();
}

class _MyReviewListScreenState extends State<MyReviewListScreen> {
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
                MyReviewListCard(),
              ],
            ),
          ),
        )
    );
  }
}

class MyReviewListCard extends StatelessWidget {

  const MyReviewListCard({super.key});

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
                        '[QR바로입장] 부산 롯데월드 어드벤처',
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
                      '2024-09-03',
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
                  '마이리얼트립 카톡계정으로 큐알 오는게 아니라 다른 계정으로 큐알 오니까 잘 보고 들어가세요!! 전 바보같이 10분동안 찾다가 문의해서 겨우 들어갔습니다..ㅠㅠ 재미 있었구 퍼레이드가 예뻤어요 최고최고 동화속에 들어간 것만 같았어요. 놀이기구 타려고 줄 꽤 기다린 것 같아요 결국 하나밖에 못 탔는데 그래도 괜찮았어용 사진찍을곳 엄청 많아요 퍼레이드 구경, 사진찍기 위주로 가시는 분은 오후권/놀이기구 탑승 위주는 종일권 추천드려요 :)) (퍼레이드는 역시 저녁이 최고였어요 대신 4시 반에 첫번째 퍼레이드 있으니 오후권 입장하실 따 스포 조심하시길..',
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
                            'https://dry7pvlp22cox.cloudfront.net/mrt-images-prod/2022/09/03/eSxb/2pyua0mpU5.jpg?width=760&height=760&operation=crop',
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://dry7pvlp22cox.cloudfront.net/mrt-images-prod/2022/11/07/aJmJ/MSzT3eUkGe.png?width=760&height=760&operation=crop',
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
