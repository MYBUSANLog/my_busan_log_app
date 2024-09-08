import 'package:busan_trip/screen/receipt_detail_screen.dart';
import 'package:busan_trip/screen/review_writer_screen.dart';
import 'package:busan_trip/vo/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/order_model.dart';
import '../model/user_model.dart'; // 모델 파일을 임포트합니다.

class ReceiptScreen extends StatefulWidget {

  ReceiptScreen({Key? key}) : super(key: key);

  @override
  _ReceiptScreenState createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int u_idx = Provider.of<UserModel>(context, listen: false).loggedInUser!.u_idx;
    Provider.of<OrderModel>(context, listen: false).setItems(u_idx);
  }

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
            )
        ),
        elevation: 0,
        title: Text(
          '결제내역',
          style: TextStyle(
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
          child: Consumer<OrderModel>(
            builder: (context, orderModel, child) {
              return ListView.builder(
                itemCount: orderModel.orders.length,
                itemBuilder: (context, index) {
                  final order = orderModel.orders[index];
                  return ReceiptCard(order: order);
                },
              );
            },
          ),
        ),
      ),
    );
  }

}

class ReceiptCard extends StatelessWidget {
  final NumberFormat formatter = NumberFormat('#,###');
  final Order order;

  ReceiptCard({Key? key, required this.order}) : super(key: key);

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

  void navigateToReceiptDetailScreen(BuildContext context) {

    // ReceiptDetailScreen으로 화면 전환
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReceiptDetailScreen(order: order),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${order.status}',
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        '${order.i_image}',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_formatCreatedDate(order.created_date)} 결제',
                            style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.grey[500]
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${order.i_name}',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${NumberFormat('#,###').format(order.total_price)}원',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              navigateToReceiptDetailScreen(context);
                            },
                            child: Text(
                              '결제상세 >',
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color(0xff0e4194),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder:  (context) => ReviewWriterScreen(order: order)),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue[50],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 7),
                      child: Text(
                        '리뷰쓰기',
                        style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: Color(0xff0e4194)
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}