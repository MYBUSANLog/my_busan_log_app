import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(


        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text('알림',
              style: TextStyle(
                  fontFamily: 'NotoSansKR',
                  fontWeight: FontWeight.w500,
                  fontSize: 35),),
            FeedCard(),
            FeedCard(),
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
    return Container(
        child: Column(
          children: [
            Text(
              '초특가로<롯데월드 어드벤처 부산>떠나기!!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '2024-07-22 15:55',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            TextButton(
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
          ],
        )
    );
  }
}