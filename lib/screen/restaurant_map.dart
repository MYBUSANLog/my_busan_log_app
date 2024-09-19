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

import '../app_http/res_item_http.dart';
import '../model/res_item_model.dart';

class RestaurantMap extends StatefulWidget {
  const RestaurantMap({super.key});

  @override
  State<RestaurantMap> createState() => _RestaurantMapState();
}

class _RestaurantMapState extends State<RestaurantMap> {

  double _minChildSize = 0.3;
  double _maxChildSize = 0.83;
  double _currentSize = 0.3;

  List<dynamic> places = [];
  List<dynamic> displayedPlaces = [];
  dynamic randomPlace;
  List<String> favorites = [];
  bool isModalOpen = false;
  late NMarker marker;
  late NLatLng target;
  late NLatLng? currentPosition;
  final ScrollController _scrollController = ScrollController();
  final DraggableScrollableController _draggableController = DraggableScrollableController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<NaverMapController> _controller = Completer();
  int currentPage = 1;
  int itemsPerPage = 10;

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
    var requestStatus = await Permission.location.request();
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

  Future<List<NMarker>> loadMarkers() async {
    // JSON 파일 읽기
    final String response = await rootBundle.loadString('assets/markers.json');
    final List<dynamic> data = json.decode(response);

    // NMarker 객체 리스트로 변환
    return data.map((marker) {
      return NMarker(
        id: marker['MAIN_TITLE'],
        position: NLatLng(marker['LAT'], marker['LNG']),
      );
    }).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ResItemModel>(context,listen: false).fetchRestaurants();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ));

    target = NLatLng(35.17976459985454, 129.07506303273934); // 기본값
    marker = NMarker(id: "test", position: target);
    currentPosition = NLatLng(35.17976459985454, 129.07506303273934);
    _permission();
    fetchData();
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

  void loadMoreItems() {
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = min(startIndex + itemsPerPage, places.length);

    if (startIndex >= places.length) {
      print('No more items to load');
      return;
    }

    print('Loading items from index $startIndex to $endIndex');

    setState(() {
      displayedPlaces.addAll(places.sublist(startIndex, endIndex));
      currentPage++;
    });
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

  void _showRestaurantModal(BuildContext context, String name, String closedDays, String address, String image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    image,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '주소: ',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$address',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '휴무일: ',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$closedDays',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 모달 닫기
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xff0e4194),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('닫기',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
                  onMapReady: (controller) async {
                    // 마커 데이터 불러오기
                    List<NMarker> markers = await loadMarkers();

                    // 마커 지도에 추가
                    controller.addOverlayAll(markers.toSet());
                    controller.setLocationTrackingMode(NLocationTrackingMode.follow);

                    // final onMarkerInfoWindow = NInfoWindow.onMarker(id: markers[0].info.id, text: "내위치");
                    // markers[0].openInfoWindow(onMarkerInfoWindow);
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
              initialChildSize: _minChildSize,
              minChildSize: _minChildSize,
              maxChildSize: _maxChildSize,
              controller: _draggableController,
              builder: (BuildContext context, ScrollController sheetScrollController) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: double.infinity,
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
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification notification) {
                                if (notification is ScrollUpdateNotification) {
                                  // 내부 리스트가 스크롤 가능하고 DraggableScrollableSheet이 최상단에 있는지 확인
                                  if (sheetScrollController.position.pixels ==
                                      sheetScrollController.position.minScrollExtent &&
                                      notification.metrics.pixels > 0) {
                                    sheetScrollController.jumpTo(
                                      sheetScrollController.position.pixels +
                                          notification.scrollDelta!,
                                    );
                                    return true; // 스크롤 이벤트가 내부로 전파되지 않도록 막음
                                  }
                                }
                                return false;
                              },
                              child: SingleChildScrollView(
                                controller: sheetScrollController,
                                child: Column(
                                  children: [
                                    Consumer<ResItemModel>(
                                      builder: (context, resItemModel, child) {
                                        return Column(
                                          children: resItemModel.restaurants.map((t) {
                                            return _buildRestaurantItem(
                                              t.res_name,
                                              t.closed_days,
                                              t.res_address,
                                              t.res_image,
                                            );
                                          }).toList(),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () {
                                        print('Load more button tapped');
                                        loadMoreItems();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                          decoration: BoxDecoration(
                                            color: Color(0xff0e4194),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            '더보기',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
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
  Widget _buildRestaurantItem(String name, String closed_days, String res_address, String res_image) {
    return GestureDetector(
      onTap: () {
        _showRestaurantModal(context, name, closed_days, res_address, res_image);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    res_image,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
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
                          SizedBox(height: 5),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              res_address,
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.grey,
                                height: 1.0,
                              ),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 200,
                          child: Text(
                            closed_days,
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            maxLines: 1,
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
        ),
      ),
    );
  }
}