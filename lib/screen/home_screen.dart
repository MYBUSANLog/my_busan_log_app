import 'package:busan_trip/screen/profile_screen.dart';
import 'package:busan_trip/screen/restaurant_map.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
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
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search_outlined,
                        size: 35,
                      ),
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
                Row(
                  children: [
                    Text(
                      '1',
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
                        'https://naverbooking-phinf.pstatic.net/20231115_165/1700025251077cwP9b_JPEG/%C0%FC%BD%C3_%BF%AC%C0%E5_%C6%F7%BD%BA%C5%CD_1%B4%EB1_%B0%ED%C8%AD%C1%FA.jpg?type=w1500',
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
                                  '상실의 징후들',
                                  style: TextStyle(
                                    fontFamily: 'NotoSansKR',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    height: 1.0,
                                  ), overflow: TextOverflow.ellipsis
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Icon(Icons.favorite_outline, size: 20),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 7,),
                          Text(
                            '부산 해운대구 · 전시회 · 후기 99+',
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
                              '16,000원~',
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
                SizedBox(height: 15,),
                Row(
                  children: [
                    Text(
                      '2',
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
                        'https://naverbooking-phinf.pstatic.net/20230125_49/1674627945913HU8OQ_JPEG/%B8%DE%C0%CE%B9%E8%B3%CA.jpg',
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
                                  '스카이라인루지 부산',
                                  style: TextStyle(
                                    fontFamily: 'NotoSansKR',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    height: 1.0,
                                  ), overflow: TextOverflow.ellipsis
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Icon(Icons.favorite_outline, size: 20),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 7,),
                          Text(
                            '부산 기장군 · 엑티비티 · 후기 99+',
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
                              '12,000원~',
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
                SizedBox(height: 15,),
                Row(
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
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Icon(Icons.favorite_outline, size: 20),
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
                SizedBox(height: 15,),
                Row(
                  children: [
                    Text(
                      '4',
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
                        'https://i.namu.wiki/i/epC9umUbZzxIJvrmlaCBo7CO2BwHfxyVbbYq7VnB2XFyj4mpu_uG0ZLg0F0XUFzGS9omLZ66SsZcp-n7x_YinScT8Azdc3bkcHZ67a40JIyr1fsq8HF3TKrNk8ZUMYB_HHosAmd_IZHqfyiBespbUw.webp',
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
                                  '신세계백화점 센텀시티점',
                                  style: TextStyle(
                                    fontFamily: 'NotoSansKR',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    height: 1.0,
                                  ), overflow: TextOverflow.ellipsis
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Icon(Icons.favorite_outline, size: 20),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 7,),
                          Text(
                            '부산 해운대구 · 복합쇼핑몰 · 후기 99+',
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
                              '0원',
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
                SizedBox(height: 15,),
                Row(
                  children: [
                    Text(
                      '5',
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
                        'https://i.namu.wiki/i/SfOtPBKLQsoKnp73v8bQ0llPsi9wuhM9HaIcf7TUjf5qNXjbjHPx4YKbJTsloZZiYCmEUnK8arhWXzaK-pQtIXKXi-HqZEk_QfQt0p0pmggqrYOOgOuIYGSDHEjI_LxiTJ1lH3AFaw6KAv7TznUbsw.webp',
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
                                  '해운대 해수욕장',
                                  style: TextStyle(
                                    fontFamily: 'NotoSansKR',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    height: 1.0,
                                  ), overflow: TextOverflow.ellipsis
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Icon(Icons.favorite_outline, size: 20),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 7,),
                          Text(
                            '부산 해운대구 · 휴양지 · 후기 99+',
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
                              '0원',
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
                SizedBox(height: 10,),
                Divider(color: Colors.grey, thickness: 1.0,),
                SizedBox(height: 30,),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/banner.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
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
            setState(() {

            });
          },
        ),
      ),
    );
  }
}

class FeedCard extends StatelessWidget {
  const FeedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 22),
      child: Column(
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

