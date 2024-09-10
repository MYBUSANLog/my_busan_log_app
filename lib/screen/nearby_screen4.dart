import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:http/http.dart' as http;

class NearbyScreen4 extends StatefulWidget {
  const NearbyScreen4({super.key});

  @override
  State<NearbyScreen4> createState() => _NearbyScreen4State();
}

class _NearbyScreen4State extends State<NearbyScreen4> {
  List<dynamic> places = [];
  String guFilter = '';
  List<String> favorites = [];
  dynamic randomPlace;
  bool isModalOpen = false;
  int currentPage = 1;
  int totalPages = 1;
  int resultsPerPage = 20;

  late NMarker marker;
  late NLatLng target;
  final ScrollController _scrollController = ScrollController();
  double _currentSize = 0.3;

  @override
  void initState() {
    super.initState();
    target = NLatLng(37.5665, 126.9780);
    marker = NMarker(id: "test", position: target);

    _scrollController.addListener(() {
      setState(() {
        _currentSize = _scrollController.hasClients
            ? _scrollController.position.pixels / _scrollController.position.maxScrollExtent
            : _currentSize;
      });
    });
  }

  final bounds = NLatLngBounds(
    southWest: NLatLng(37.413294, 126.764166),
    northEast: NLatLng(37.701749, 127.181111),
  );

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://apis.data.go.kr/6260000/FoodService/getFoodKr?serviceKey=YOUR_API_KEY&numOfRows=1000&pageNo=1&resultType=json",
        ),
      );
      final data = json.decode(response.body);
      final allData = data['getFoodKr']['item'];
      setState(() {
        places = allData;
        totalPages = (allData.length / resultsPerPage).ceil();
        if (places.isNotEmpty) {
          final target = NLatLng(
            double.parse(places[0]['LAT']),
            double.parse(places[0]['LNG']),
          );
          // marker = NMarker(id: "test", position: target);
        }
      });
    } catch (error) {
      print("Failed to fetch places data: $error");
    }
  }

  void toggleFavorite(dynamic place) {
    setState(() {
      if (favorites.contains(place['UC_SEQ'])) {
        favorites.remove(place['UC_SEQ']);
      } else {
        favorites.add(place['UC_SEQ']);
      }
    });
  }

  void recommendRandomPlace() {
    final randomIndex = (places.length * (Random().nextDouble())).floor();
    setState(() {
      randomPlace = places[randomIndex];
      isModalOpen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '맛집 찾기',
            style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              )),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            NaverMap(
              options: NaverMapViewOptions(
                initialCameraPosition: NCameraPosition(
                    target: target,
                    zoom: 15,
                    bearing: 0,
                    tilt: 0
                ),
                extent: bounds,
              ),
              forceGesture: false,
              onMapReady: (controller) {
                controller.addOverlay(marker);
              },
              onMapTapped: (point, latLng) {},
              onSymbolTapped: (symbol) {},
              onCameraChange: (position, reason) {},
              onCameraIdle: () {},
              onSelectedIndoorChanged: (indoor) {},
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.3,
              maxChildSize: 1.0,
              builder: (context, scrollController) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Visibility(
                        visible: _currentSize < 1.0,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Container(
                              width: 80,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  color: Colors.red,
                                  child: SizedBox(
                                      height: 100, width: double.infinity),
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        )
    );
  }
}
