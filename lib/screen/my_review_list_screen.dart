import 'package:flutter/material.dart';

class MyReviewListScreen extends StatefulWidget {
  const MyReviewListScreen({super.key});

  @override
  State<MyReviewListScreen> createState() => _MyReviewListScreenState();
}

class _MyReviewListScreenState extends State<MyReviewListScreen> {
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
            '내가 쓴 리뷰',
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
