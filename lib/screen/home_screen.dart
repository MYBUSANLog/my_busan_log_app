import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30),
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
          ],
        ),
      ),
    );
  }

  Widget sliderWidget() {
    List imgList = [
      "https://plus.unsplash.com/premium_photo-1661962660197-6c2430fb49a6?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "https://images.unsplash.com/photo-1551279076-6887dee32c7e?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "https://images.unsplash.com/photo-1552873547-b88e7b2760e2?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "https://images.unsplash.com/photo-1561555804-4b9e0848fdbe?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "https://images.unsplash.com/photo-1683041133704-1de1c55d050c?q=80&w=1075&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0), // 전체 슬라이더 모서리를 둥글게
      child: CarouselSlider(
        carouselController: _controller,
        items: imgList.map(
              (imgLink) {
            return Builder(
              builder: (context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // 이미지 컨테이너도 둥글게
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
              _current = index;
            });
          },
        ),
      ),
    );
  }

}

class HomeBox extends StatelessWidget {
  const HomeBox({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
