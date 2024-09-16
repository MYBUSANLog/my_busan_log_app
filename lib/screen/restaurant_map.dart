import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class RestaurantMap extends StatefulWidget {
  const RestaurantMap({super.key});

  @override
  State<RestaurantMap> createState() => _RestaurantMapState();
}

class _RestaurantMapState extends State<RestaurantMap> {

  double _minChildSize = 0.35;
  double _maxChildSize = 0.83;
  double _currentSize = 0.3;

  List<dynamic> places = [];
  dynamic randomPlace;
  List<String> favorites = [];
  bool isModalOpen = false;
  late NMarker marker;
  late NLatLng target;
  late NLatLng? currentPosition;
  final ScrollController _scrollController = ScrollController();// 기본 프로필 선택
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

  void _permission() async {
    var requestStatus = await Permission.location.request
      ();
    var status = await Permission.location.status;
    if (requestStatus.isPermanentlyDenied || status.isPermanentlyDenied) {
      openAppSettings();
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
    // TODO: implement initState
    super.initState();
    ResItemHttp.fetchAll();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ));

    target = NLatLng(35.17976459985454, 129.07506303273934); // 기본값
    marker = NMarker(id: "test", position: target);
    currentPosition = NLatLng(35.17976459985454, 129.07506303273934);
    _permission();
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
                    initialCameraPosition: _RestaurantMapState.initialPosition,
                    locale: Locale('ko'),
                    extent: NLatLngBounds(
                      southWest: NLatLng(31.43, 122.37),
                      northEast: NLatLng(44.35, 132.0),

                    ),
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
                    color: Colors.white
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
                              child: Consumer<ResItemModel>(
                                builder: (context, resItemModel, child) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: resItemModel.restaurants.map((t) {
                                        return _buildRestaurantItem(
                                          t.res_name,
                                          t.closed_days,
                                          t.res_address,
                                          t.res_images
                                        );
                                      }).toList(),
                                    ),
                                  );
                                }
                              )
                          )
                        ],
                      )
                    ],
                  ),
                );
              }
          )
        ],
      ),
    );
  }
  Widget _buildRestaurantItem(String name, String closed_days, String address, String imageUrl) {
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
                          name,
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
                      closed_days,
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
                        address,
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
