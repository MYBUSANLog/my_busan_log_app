import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  late Future<void> _loadingFuture;

  @override
  void initState() {
    super.initState();
    _loadingFuture = _simulateLoading();
  }

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 3));
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
                    SizedBox(height: 30),
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
          expandedHeight: 180.0, // AppBar의 최대 높이 설정
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              'https://s3-alpha-sig.figma.com/img/9ebf/4cf3/8476c113e0efa48c8be3c1b6c5f15345?Expires=1723420800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jj7ZExk6QTQDJeex1~E4k240s0f1vgjsHEZOrRoraziJRakcnMQRNwjV2WxudNYFkr7gDOrNi-gVWo3tBMIAWs9uFrCxelz1xBK4hm1Lq8VWR~ENC3E8P9g4O~DTo7infIxez52vIKBf5sdWViDNAH3NRQthTWx4WsqhMKxW08gEJHHFhAKUpwAUDRummQhBXz0w-v2v-HgksqZcqGfR~xLvb9Wy8a4yEzOFwEit9y1EPX3NBOAUWsM8uzF250MR-xJfdiNj-ZwVI6cfE56knTgH302P59w7uYOr82V8IsREGFP1APVeeriVqGa5xM1gfVhL~fEEZ36fSbye-hTOfw__',
              fit: BoxFit.cover, // 이미지를 AppBar에 맞추기
            ),

          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
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

class DetailContent extends StatelessWidget {
  TextStyle ts2 = TextStyle(fontFamily: 'NotoSansKR', fontWeight: FontWeight.w200, fontSize: 15);
  TextStyle ts1 = TextStyle(fontFamily: 'NotoSansKR', fontWeight: FontWeight.w100, fontSize: 15);
  TextStyle ts3 = TextStyle(fontFamily: 'NotoSansKR', fontWeight: FontWeight.w500, fontSize: 20);
  TextStyle ts4 = TextStyle(fontFamily: 'NotoSansKR', fontWeight: FontWeight.w500, fontSize: 8);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    children: [
                      Text('관광지', style: ts2,),
                      Text('>', style: ts2),
                      Text('테마파크', style: ts2)
                    ]
                ),
                Row(
                  children: [
                    IconButton(onPressed:() {},
                      icon: Icon(
                        Icons.favorite_border,
                        size: 20,
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Text(
            '롯데월드 어드벤쳐 부산',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    children: [
                      Text('부산시', style: ts2,),
                      Text('·', style: ts3),
                      Text('기장군', style: ts2)
                    ]
                ),
              ],
            ),
          ),
          SizedBox(height: 16,),
          Row(
            children: [
              Icon(
                Icons.star,
                size: 20,
                color: Colors.yellow,
              ),
              SizedBox(width: 5,),
              Text('4.8'),
              SizedBox(width: 5,),
              Text('·' ,style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(width: 5,),
              Text('후기763개')
            ],
          ),
          SizedBox(height: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('여행지 소개', style: ts3),
              SizedBox(height: 8,),
              Text('부산 오시리아 관광단지에 롯데월드가 있어요.날씨가 좋아서 이번에 다녀왔는데 올라가는 계단에서 제일 먼저 로티가 반갑게 맞이해주니 너무 설렜어요.롯데월드 어드벤처 부산은 서울에 있는 롯데월드와 조금 다르게 주황색톤으로 꾸며져 있어 따뜻한 느낌의 동화 속으로 빠져들어가는 느낌을 주었어요.매표소를 지나자마자 들리는 신나는 음악과 사람들의 환호 소리에 마치 동심으로 돌아간 듯 입가에 미소가 절로 지어졌어요.', style: ts2),
              SizedBox(height: 8,),
              Image.network(
                'https://adventurebusan.lotteworld.com/common/images/guest-map-m.jpg',
                fit: BoxFit.cover, // 이미지를 AppBar에 맞추기
              ),
            ],
          ),



          SizedBox(height: 20,),
          Text('가격 정보', style: ts3),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 120, vertical: 120),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/lo-pay.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 20,),
          Container(
            child: Text('이용 안내', style: ts3),
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('주소', style: ts4),
                  Text('홈페이지', style: ts4),
                  Text('운영요일 및 시간', style: ts4),
                  Text('', style: ts4),
                  Text('', style: ts4),
                  Text('전화번호', style: ts4),
                  Text('휴무일', style: ts4),
                  Text('교통정보', style: ts4),
                  Text('', style: ts4),
                ],
              ),
              SizedBox(width: 10,),
              Container(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('부산광역시 기장군 기장읍 동부산관광로 42', style: ts4),
                    Text('https://adventurebusan.lotteworld.com/kor/main/index.do', style: ts4),
                    Text('10:00 ~ 20:00 (월~금)\n10:00 ~ 21:00 (토~일)\n*자세한 운영시간은 홈페이지 참조', style: ts4),
                    Text('1661-2000 ', style: ts4),
                    Text('연중휴무', style: ts4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('동해선 오시리아역 1번 출구 도보 10분버스 139, 183, 185, 1001 오시리아역 정류장하차도보10분주차 롯데월드어드벤처부산주차장 ', style: ts4,
                        ),
                      ],
                    ),
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

