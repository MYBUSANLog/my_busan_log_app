import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

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
  late NLatLng? currentPosition;
  final ScrollController _scrollController = ScrollController();
  double _currentSize = 0.3;

  void _permission() async {
    var requestStatus = await Permission.location.request();
    var status = await Permission.location.status;
    if (requestStatus.isPermanentlyDenied || status.isPermanentlyDenied) {
      bool isPermissioned = await openAppSettings();
      if(isPermissioned == true) {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        setState(() {
          currentPosition = NLatLng(position.latitude, position.longitude);
        });
      }
    } else if (status.isGranted) {
      // 위치 정보 획득
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentPosition = NLatLng(position.latitude, position.longitude);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    currentPosition = NLatLng(35.17976459985454, 129.07506303273934);
    target = NLatLng(35.17976459985454, 129.07506303273934);  // 기본값
    _permission();

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
    southWest: NLatLng(34.8799083, 128.7384361),
    northEast: NLatLng(35.3959361, 129.3728194),
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
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 60),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '내 주변 맛집',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 420,
                  child: NaverMap(
                    options: NaverMapViewOptions(
                      initialCameraPosition: NCameraPosition(
                          target: currentPosition ?? target,
                          zoom: 10,
                          bearing: 0,
                          tilt: 0
                      ),
                      extent: bounds,
                    ),
                    forceGesture: false,
                    onMapReady: (controller) {
                      // controller.addOverlay(marker);
                      final marker1 = NMarker(
                          id: '식당 1',
                          position: const NLatLng(35.177387, 128.95245)
                      );
                      final marker2 = NMarker(
                          id: '식당 2',
                          position: const NLatLng(35.16055, 129.07988)
                      );
                      controller.addOverlayAll({marker1, marker2});
                      controller.setLocationTrackingMode(NLocationTrackingMode.follow);

                      final onMarkerInfoWindow = NInfoWindow.onMarker(id: marker.info.id, text: "내위치");
                      marker.openInfoWindow(onMarkerInfoWindow);
                    },
                    onMapTapped: (point, latLng) {},
                    onSymbolTapped: (symbol) {},
                    onCameraChange: (position, reason) {},
                    onCameraIdle: () {},
                    onSelectedIndoorChanged: (indoor) {},
                  ),
                ),
              ],
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
