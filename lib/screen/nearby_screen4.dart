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

  late NMarker marker;
  late NLatLng target;

  @override
  void initState() {
    super.initState();
    target = NLatLng(37.5665, 126.9780);
    marker = NMarker(id: "test", position: target);
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 20, bottom: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xff0e4194),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                    Icons.gps_fixed,
                    size: 30,
                    color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5), // Shadow color
                      spreadRadius: 3, // Spread radius
                      blurRadius: 5,   // Blur radius
                      offset: Offset(0, 3), // Shadow position
                    ),
                  ],
                ),
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
                    SizedBox(height: 30),
                    Text('Text1'),
                    SizedBox(height: 10),
                    Text('Text2'),
                    SizedBox(height: 30),
                  ],
                ),
              )
            ],
          )
        ],
      )
    );
  }
}
