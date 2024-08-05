import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';


class RestaurantMap extends StatefulWidget {
  const RestaurantMap({super.key});

  @override
  State<RestaurantMap> createState() => _RestaurantMapState();
}

class _RestaurantMapState extends State<RestaurantMap> {

  double _minChildSize = 0.35;
  double _maxChildSize = 0.83;
  late ScrollController _scrollController; // 기본 프로필 선택
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<NaverMapController> _controller = Completer();

  static const initialPosition = NCameraPosition(
      target: NLatLng(35.15243682224479, 129.0596301491128),
      zoom: 14
  );

  void _onMapCreated(NaverMapController controller) {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        // 체크하여 드래그 모션에 따라 최대, 최소 크기로 스크롤 위치를 조정
        if (_scrollController.hasClients) {
          final offset = _scrollController.offset;
          final maxExtent = _scrollController.position.maxScrollExtent;
          final minExtent = _scrollController.position.minScrollExtent;
          final size = (offset - minExtent) / (maxExtent - minExtent);
          if (size < _minChildSize) {
            _scrollController.jumpTo(minExtent);
          } else if (size > _maxChildSize) {
            _scrollController.jumpTo(maxExtent);
          }
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80),
                    Text(
                      '내 주변 맛집 찾기',
                      style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              Expanded(
                child: NaverMap(
                  options: const NaverMapViewOptions(
                      initialCameraPosition: initialPosition,
                  ),
                  onMapReady: _onMapCreated,
                ),
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: _minChildSize,
            minChildSize: _minChildSize,
            maxChildSize: _maxChildSize,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(0, -2),
                      blurRadius: 4.0,
                      spreadRadius: 0,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    IgnorePointer(
                      ignoring: false,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 50,
                            height: 6,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            controller: scrollController,
                            padding: EdgeInsets.all(16),
                            children: [
                              _buildRestaurantItem(
                                  '라마앤바바나',
                                  '부산 부산진구 · 인도음식',
                                  '361M',
                                  '16,000원 ~',
                                  'https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20150930_144%2F1443594464963pvo4n_JPEG%2F166875548337904_8.jpg'
                              ),
                              _buildRestaurantItem(
                                  '오십사 서면점',
                                  '부산 부산진구 · 육류,고기요리',
                                  '312M',
                                  '16,000원 ~',
                                  'https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240727_76%2F1722067391668Rm3yo_JPEG%2F1000006972.jpg'
                              ),
                              _buildRestaurantItem(
                                  '린선다이닝 서면본점',
                                  '부산 부산진구 · 중식당',
                                  '324M',
                                  '16,000원 ~',
                                  'https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240702_169%2F1719927154396InEcH_JPEG%2FIMG_9155.jpg'
                              ),
                              _buildRestaurantItem(
                                  '상록회관연탄구이 부산서면점',
                                  '부산 부산진구 · 육류,고기요리',
                                  '195M',
                                  '16,000원 ~',
                                  'https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240423_137%2F1713876164679b9wUm_JPEG%2F1713870744202.jpg'
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantItem(String name, String category, String distance, String price, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                width: 75,
                height: 75,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          height: 1.0,
                        ),
                      ),
                      Text(
                        distance,
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                  Text(
                    category,
                    style: TextStyle(
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.grey,
                      height: 1.0,
                    ),
                  ),
                  SizedBox(height: 7),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      price,
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
