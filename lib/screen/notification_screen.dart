import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Offset _fabOffset = Offset(340, 650); // 초기 위치 설정

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text(
              '알림',
              style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w500,
                fontSize: 35,
              ),
            ),
            SizedBox(height: 16),
            FeedCard(),
            SizedBox(height: 16),
            FeedCard(),
            SizedBox(height: 16),
            FeedCard(),
          ],
        ),
      ),
    );
  }
}

class FeedCard extends StatelessWidget {
  const FeedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications, size: 30, color: Colors.amber[700],),
                  ],
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '초특가로<롯데월드 어드벤처 부산>떠나기!!',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        '2024-07-22 15:55',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.grey
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // 상세보기 버튼 클릭 시 동작 추가
                },
                child: Text(
                  '상세보기',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xff0e4194),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}