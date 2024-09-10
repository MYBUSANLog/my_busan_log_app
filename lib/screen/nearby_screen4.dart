import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
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

  double? latitude;
  double? longitude;

  late NMarker currentLocationMarker;
  late NLatLng target;

  @override
  void initState() {
    super.initState();
    getGeoData();
    target = NLatLng(37.5665, 126.9780);
    currentLocationMarker = NMarker(id: "currentLocation", position: target);
  }

  Future<void> getGeoData() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permissions are denied');
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      target = NLatLng(latitude!, longitude!);
      currentLocationMarker = NMarker(id: "currentLocation", position: target);
    });
  }

  // final bounds = NLatLngBounds(
  //   southWest: NLatLng(37.413294, 126.764166),
  //   northEast: NLatLng(37.701749, 127.181111),
  // );

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
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 400,
              child: NaverMap(
                options: NaverMapViewOptions(
                  initialCameraPosition: NCameraPosition(
                      target: target,
                      zoom: 15,
                      bearing: 0,
                      tilt: 0
                  ),
                ),
                forceGesture: false,
                onMapReady: (controller) {
                  controller.addOverlay(currentLocationMarker);
                },
                onMapTapped: (point, latLng) {},
                onSymbolTapped: (symbol) {},
                onCameraChange: (position, reason) {},
                onCameraIdle: () {},
                onSelectedIndoorChanged: (indoor) {},
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff0e4194), width: 2.0),
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: guFilter,
                        onChanged: (String? newValue) {
                          setState(() {
                            guFilter = newValue ?? "";
                          });
                          // displayPlaces();
                        },
                        dropdownColor: Colors.white,
                        items: <String>[
                          '',
                          '강서구',
                          '금정구',
                          '남구',
                          '동구',
                          '동래구',
                          '부산진구',
                          '북구',
                          '사상구',
                          '사하구',
                          '서구',
                          '수영구',
                          '연제구',
                          '영도구',
                          '중구',
                          '해운대구'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14.0),
                              child: Text(value.isEmpty ? '전체' : value),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: recommendRandomPlace,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff0e4194),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 7),
                      child: Text(
                        '랜덤 맛집 추천',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: places.length,
                itemBuilder: (context, index) {
                  final place = places[index];
                  return ListTile(
                    title: Text(place['MAIN_TITLE']),
                    subtitle: Text(
                        '${place['ADDR1']}\n${place['RPRSNTV_MENU']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            favorites.contains(place['UC_SEQ']) ? Icons
                                .favorite : Icons.favorite_border,
                          ),
                          onPressed: () => toggleFavorite(place),
                        ),
                        IconButton(
                          icon: Icon(Icons.info),
                          onPressed: () {
                            // Navigate to detail page
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
