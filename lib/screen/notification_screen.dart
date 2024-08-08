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
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      // child: Padding(
      //   padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.add_alert), // 예약 아이콘 추가
              // 아이콘과 텍스트 사이에 간격 추가
              Expanded(
                child: Text(
                  '초특가로<롯데월드 어드벤처 부산>떠나기!!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          Text(
            '2024-07-22 15:55',
            style: TextStyle(
              fontSize: 18,
            ),
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
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}