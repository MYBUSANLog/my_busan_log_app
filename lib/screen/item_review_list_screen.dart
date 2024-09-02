import 'package:flutter/material.dart';

class ItemReviewListScreen extends StatefulWidget {
  const ItemReviewListScreen({super.key});

  @override
  State<ItemReviewListScreen> createState() => _ItemReviewListScreenState();
}

class _ItemReviewListScreenState extends State<ItemReviewListScreen> {
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
          '리뷰',
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
                ItemReviewListCard(),
              ],
            ),
          ),
        )
    );
  }
}

class ItemReviewListCard extends StatelessWidget {

  const ItemReviewListCard({super.key});

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
                  '최근 리뷰 2개',
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
              crossAxisAlignment: CrossAxisAlignment.start, // Align column items to the start
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align row items to the start
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          'https://cdn.pixabay.com/photo/2020/05/17/20/21/cat-5183427_1280.jpg',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Add spacing between image and text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align column items to the start
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start, // Align row items to the start
                          children: [
                            Text(
                              '달나라 초능력자',
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                height: 1.0,
                              ),
                              overflow: TextOverflow.ellipsis,
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
                        SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center, // Align row items to the start
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
                  overflow: TextOverflow.visible,
                ),
                SizedBox(height: 15),
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
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey[200], thickness: 1.0,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align column items to the start
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align row items to the start
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          'https://media.bunjang.co.kr/product/255681781_%7Bcnt%7D_1720937364_w%7Bres%7D.jpg',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Add spacing between image and text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align column items to the start
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start, // Align row items to the start
                          children: [
                            Text(
                              '불주먹 세레나데',
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                height: 1.0,
                              ),
                              overflow: TextOverflow.ellipsis,
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
                        SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center, // Align row items to the start
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
                              '2024-07-24',
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.0,
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
                Text(
                  '파크가 엄청 작지만 그만큼 매력있는것 같아요! 아기자기하기도 하고 공연의 퀄리티가 높다고 생각해요 스릴있는 놀이기구 몇개만 탄다고 해도 가성비 있긴하지만 이것때문에 부산으로 올정도는 아닙니다 잠깐 들르는 일정으로는 괜찮은거같아요😉',
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
                Container(
                  height: 200,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://dry7pvlp22cox.cloudfront.net/mrt-images-prod/2024/03/21/wcc0/uotRTGbcXL.jpg?width=760&height=760&operation=crop',
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
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
}
