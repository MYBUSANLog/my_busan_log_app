import 'package:busan_trip/screen/ai_chatbot_screen.dart';
import 'package:busan_trip/screen/ai_recommend_screen.dart';
import 'package:busan_trip/screen/home_screen.dart';
import 'package:busan_trip/screen/nearby_screen4.dart';
import 'package:busan_trip/screen/notification_screen.dart';
import 'package:busan_trip/screen/profile_screen.dart';
import 'package:busan_trip/screen/restaurant_map.dart';
import 'package:flutter/material.dart';

import 'package:kakao_flutter_sdk_talk/kakao_flutter_sdk_talk.dart' as kakao_order;
import '../vo/order.dart' as od;

class RootScreen extends StatefulWidget {

  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {

  int _nowIndex = 2;
  late List<Widget> screens;


  @override
  void initState() {
    super.initState();
    screens = [
      NearbyScreen4(),
      AiRecommendScreen(),
      HomeScreen(),
      NotificationScreen(),
      ProfileScreen(), // widget.order를 사용
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _nowIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            border: Border(top: BorderSide(color: Colors.grey[100]!, width: 1.0))
          ),
          child: ClipRRect(
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Color(0xff0e4194),
              unselectedItemColor: Colors.grey,
              selectedLabelStyle: TextStyle(fontSize: 10),
              unselectedLabelStyle: TextStyle(fontSize: 10),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on),
                  label: '맛집',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'AI추천',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '홈',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: '마음함',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '프로필',
                ),
              ],
              currentIndex: _nowIndex,
              onTap: (index){
                setState(() {
                  _nowIndex=index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
