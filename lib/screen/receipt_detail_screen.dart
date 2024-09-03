import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../vo/order.dart';

class ReceiptDetailScreen extends StatefulWidget {
  final Order order;

  ReceiptDetailScreen({required this.order, super.key});

  @override
  State<ReceiptDetailScreen> createState() => _ReceiptDetailScreenState();
}

class _ReceiptDetailScreenState extends State<ReceiptDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            )),
        elevation: 0,
        title: Text(
          '주문 상세보기',
          style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Center(
            child: TicketWidget(order: widget.order), // 단일 TicketWidget 사용
          ),
        ),
      ),
    );
  }
}

class TicketWidget extends StatelessWidget {
  final Order order;

  TicketWidget({required this.order, super.key});

  String _formatCreatedDate(String date) {
    final parts = date.split(' ');

    if (parts.length >= 2) {
      final timeParts = parts[1].split(':');
      if (timeParts.length >= 2) {
        return '${parts[0]} ${timeParts[0]}:${timeParts[1]}';
      }
      return '${parts[0]} ${parts[1]}';
    }

    return date;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Stack(
          children: [
            CustomPaint(
              size: Size(double.infinity, 1050.0), // 티켓의 높이 설정
              painter: TicketPainter(),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft, // 텍스트를 중앙에 배치합니다.
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '주문이 완료되었습니다', // 표시할 텍스트
                          style: TextStyle(
                            fontSize: 28, // 텍스트 크기
                            fontWeight: FontWeight.w700, // 텍스트 굵기
                            color: Colors.black, // 텍스트 색상
                          ),
                        ),
                      ]
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 14),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 50),
                              Text(
                                '구매 정보',
                                style: TextStyle(
                                  fontFamily: 'NotoSansKR',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  height: 2.0,
                                ),
                              ),
                              Divider(color: Colors.grey[500], thickness: 1.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '상품명',
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17,
                                            color: Colors.grey,
                                            height: 1.2,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end, // Aligns content to the right
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '[QR바로입장] 부산 롯데월드 어드벤처',
                                                  style: TextStyle(
                                                    fontFamily: 'NotoSansKR',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17,
                                                    height: 1.2,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 3, // Adjust the number of lines as needed
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    '선택 옵션',
                                    style: TextStyle(
                                      fontFamily: 'NotoSansKR',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17,
                                      color: Colors.grey,
                                      height: 1.2,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    width: double.infinity, // Ensures the container takes the full width
                                    child: Column(// Aligns content to the right
                                      children: [
                                        Container(
                                          color: Colors.grey[200],
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  '옵션이름 ',
                                                  style: TextStyle(
                                                    fontFamily: 'NotoSansKR',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    height: 1.0,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  'X 2',
                                                  style: TextStyle(
                                                    fontFamily: 'NotoSansKR',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                    height: 1.0,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '20,000원',
                                                  style: TextStyle(
                                                    fontFamily: 'NotoSansKR',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    height: 1.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    width: double.infinity, // Ensures the container takes the full width
                                    child: Column(// Aligns content to the right
                                      children: [
                                        Container(
                                          color: Colors.grey[200],
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  '옵션이름 ',
                                                  style: TextStyle(
                                                    fontFamily: 'NotoSansKR',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    height: 1.0,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  'X 2',
                                                  style: TextStyle(
                                                    fontFamily: 'NotoSansKR',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                    height: 1.0,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '20,000원',
                                                  style: TextStyle(
                                                    fontFamily: 'NotoSansKR',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    height: 1.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 25),
                              Text(
                                '결제 정보',
                                style: TextStyle(
                                  fontFamily: 'NotoSansKR',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  height: 2.0,
                                ),
                              ),
                              Divider(color: Colors.grey[500], thickness: 1.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '주문번호',
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17,
                                            color: Colors.grey,
                                            height: 1.2,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '116161561156',
                                                  style: TextStyle(
                                                    fontFamily: 'NotoSansKR',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17,
                                                    height: 1.2,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 3, // Adjust the number of lines as needed
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '결제 일시',
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17,
                                            color: Colors.grey,
                                            height: 1.2,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          width: 150, // Ensures the container takes the full width
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end, // Aligns content to the right
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '2024-09-25',
                                                  style: TextStyle(
                                                    fontFamily: 'NotoSansKR',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17,
                                                    height: 1.2,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 3, // Adjust the number of lines as needed
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '결제 수단',
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17,
                                            color: Colors.grey,
                                            height: 1.2,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '신용카드',
                                                  style: TextStyle(
                                                    fontFamily: 'NotoSansKR',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17,
                                                    height: 1.2,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 3, // Adjust the number of lines as needed
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '총 결제 금액',
                                          style: TextStyle(
                                            fontFamily: 'NotoSansKR',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17,
                                            color: Colors.grey,
                                            height: 1.2,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '25,000원',
                                                  style: TextStyle(
                                                    fontFamily: 'NotoSansKR',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17,
                                                    height: 1.2,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 3, // Adjust the number of lines as needed
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 35),
                              Align(
                                alignment: Alignment.topCenter, // QR 코드를 중앙에 배치합니다.
                                child: GestureDetector(
                                  onTap: () => _showQrCodeDialog(context),
                                  child: QrImageView(
                                    data: order.order_num, // QR 코드에 포함될 주문 ID
                                    version: QrVersions.auto,
                                    size: 200.0, // QR 코드의 크기 설정
                                    gapless: false, // QR 코드의 배경을 투명하게 설정
                                  ),
                                ),
                              ),
                            ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showQrCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: 300.0,
            height: 300.0,
            child: Stack(
              children: [
                QrImageView(
                  data: order.order_num, // QR 코드에 포함될 주문 ID
                  version: QrVersions.auto,
                  size: 300.0, // 확대된 QR 코드의 크기
                  gapless: false, // QR 코드의 배경을 투명하게 설정
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop(); // 다이얼로그 닫기
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TicketPainter extends CustomPainter {
  final _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1
    ..color = Colors.black;

  final _linePaint = Paint()
    ..strokeWidth = 1
    ..color = Colors.grey
    ..style = PaintingStyle.stroke;

  static const double _ticketRadius = 4;
  static const double _lineHeight = 0.2473;
  static const double _holeRadius = 8;
  static const dotWidth = 8;
  static const dotPadding = 4;

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final lineHeight = height * _lineHeight;

    Path path = Path()
      ..moveTo(0, _ticketRadius)
      ..arcTo(
        Rect.fromCircle(center: Offset(0, lineHeight), radius: _holeRadius),
        -pi / 2,
        pi,
        false,
      )
      ..lineTo(0, height - _ticketRadius)
      ..quadraticBezierTo(0, height, _ticketRadius, height)
      ..lineTo(width - _ticketRadius, height)
      ..quadraticBezierTo(width, height, width, height - _ticketRadius)
      ..arcTo(
        Rect.fromCircle(center: Offset(width, lineHeight), radius: _holeRadius),
        pi / 2,
        pi,
        false,
      )
      ..lineTo(width, _ticketRadius)
      ..quadraticBezierTo(width, 0, width - _ticketRadius, 0)
      ..lineTo(_ticketRadius, 0)
      ..quadraticBezierTo(0, 0, 0, _ticketRadius);

    canvas.drawPath(path, _paint);

    path = Path()
      ..moveTo(_holeRadius + 14, lineHeight)
      ..lineTo(_holeRadius + 14 + 4, lineHeight);

    double blank = _holeRadius + 14 + 4;

    final dotCount =
    ((width - ((blank) * 2)) / (dotPadding + dotWidth)).floor();

    for (var i = 0; i < dotCount; i++) {
      path.moveTo(blank + dotPadding, lineHeight);
      path.lineTo(blank + dotPadding + dotWidth, lineHeight);
      blank += dotPadding + dotWidth;
    }

    path.moveTo(blank + dotPadding, lineHeight);
    path.lineTo(blank + dotPadding + 4, lineHeight);

    canvas.drawPath(path, _linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
