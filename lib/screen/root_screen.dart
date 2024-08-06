import 'package:busan_trip/screen/ai_recommend_screen.dart';
import 'package:busan_trip/screen/home_screen.dart';
import 'package:busan_trip/screen/notification_screen.dart';
import 'package:busan_trip/screen/profile_screen.dart';
import 'package:busan_trip/screen/realtime_list_screen.dart';
import 'package:busan_trip/screen/realtime_list_screen1.dart';
import 'package:busan_trip/screen/restaurant_map.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {

  int _nowIndex = 2;


  List<Widget> screens = [
    RestaurantMap(),
    AiRecommendScreen(),
    HomeScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5), // Shadow color with opacity
                offset: Offset(0, -2), // Offset the shadow upwards (top shadow effect)
                blurRadius: 4.0, // Blur radius for the shadow
                spreadRadius: 0, // Spread radius of the shadow
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
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
                  icon: Icon(Icons.map),
                  label: 'AI추천',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '홈',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: '알림',
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
