import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:busan_trip/model/receipt_model.dart'; // 모델 파일을 임포트합니다.
import 'package:busan_trip/screen/profile_screen.dart'; // ProfileScreen 파일을 임포트합니다.


class ReceiptScreen extends StatelessWidget {
  final List<ReceiptModel> receipts = [
    ReceiptModel(
      imageUrl: 'assets/images/trip1.webp', // 이미지 경로
      title: '해운대 여행',
      amount: 200000.0,
      date: DateTime.now(),
      paymentStatus: '결제 성공',
      paymentMethod: '신용카드',
      orderId: 'ORD12345678',
      travelSchedule: '2024-08-01 ~ 2024-08-05',
      travelLocation: '서울 -> 부산',
    ),
    ReceiptModel(
      imageUrl: 'assets/images/busan_trip2.jpg', // 이미지 경로
      title: '광안리 여행 패키지',
      amount: 250000.0,
      date: DateTime.now(),
      paymentStatus: '결제 성공',
      paymentMethod: '계좌이체',
      orderId: 'ORD87654321',
      travelSchedule: '2024-09-10 ~ 2024-09-15',
      travelLocation: '서울 -> 부산',
    ),
    ReceiptModel(
      imageUrl: 'assets/images/busan_trip3.jpg', // 이미지 경로
      title: '감천문화마을 투어',
      amount: 150000.0,
      date: DateTime.now(),
      paymentStatus: '결제 실패',
      paymentMethod: '신용카드',
      orderId: 'ORD56781234',
      travelSchedule: '2024-07-20 ~ 2024-07-22',
      travelLocation: '서울 -> 부산',
    ),
    ReceiptModel(
      imageUrl: 'assets/images/busan_trip4.jpg', // 이미지 경로
      title: '태종대 관광 패키지',
      amount: 180000.0,
      date: DateTime.now(),
      paymentStatus: '결제 성공',
      paymentMethod: '카카오페이',
      orderId: 'ORD13572468',
      travelSchedule: '2024-08-15 ~ 2024-08-18',
      travelLocation: '서울 -> 부산',
    ),
    ReceiptModel(
      imageUrl: 'assets/images/busan_trip5.jpg', // 이미지 경로
      title: '부산타워 투어',
      amount: 220000.0,
      date: DateTime.now(),
      paymentStatus: '결제 성공',
      paymentMethod: '네이버페이',
      orderId: 'ORD24681357',
      travelSchedule: '2024-10-01 ~ 2024-10-05',
      travelLocation: '서울 -> 부산',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white, // 상태바 색상 설정
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
          title: Text(
            '결제내역',
            style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w500,
              fontSize: 23,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0, // 스크롤 시 AppBar 색상 변경 방지
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              ); // 뒤로 가기 기능 추가
            },
          ),
        ),
        body: Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: receipts.length,
            itemBuilder: (context, index) {
              return ReceiptCard(receipt: receipts[index]);
            },
          ),
        ),
      ),
    );
  }
}

class ReceiptCard extends StatelessWidget {
  final ReceiptModel receipt;

  ReceiptCard({required this.receipt});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // 카드의 모서리를 둥글게 설정
      ),
      elevation: 5, // 그림자 효과 추가
      color: Colors.white, // 카드 배경을 흰색으로 설정
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '결제완료',
              style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${DateFormat('M. d. HH:mm').format(receipt.date)} 결제',
              style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10), // 이미지 모서리를 둥글게 설정
              child: Container(
                width: double.infinity,
                height: 150,
                color: Colors.white, // 이미지가 없는 경우 흰색 배경
                child: Image.asset(
                  receipt.imageUrl,
                  fit: BoxFit.cover, // 이미지가 박스를 꽉 채우도록 설정
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              receipt.title,
              style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Text(
              '금액: ${NumberFormat.currency(locale: 'ko_KR', symbol: '₩').format(receipt.amount)}',
              style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                // 결제상세로 이동하는 코드 추가
              },
              child: Text(
                '결제상세',
                style: TextStyle(
                  fontFamily: 'NotoSansKR',
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
