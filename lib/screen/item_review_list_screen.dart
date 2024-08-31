import 'package:flutter/material.dart';

class ItemReviewListScreen extends StatefulWidget {
  const ItemReviewListScreen({super.key});

  @override
  State<ItemReviewListScreen> createState() => _ItemReviewListScreenState();
}

class _ItemReviewListScreenState extends State<ItemReviewListScreen> {
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
          '리뷰',
          style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(

        ),
      )
    );
  }
}
