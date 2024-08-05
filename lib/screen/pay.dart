import 'package:flutter/material.dart';

class PayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('결제', style: TextStyle(
          fontFamily: 'NotoSansKR',
          fontWeight: FontWeight.w500,
          fontSize: 23,
          color: Colors.black,
        )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text('결제 화면', style: TextStyle(
            fontFamily: 'NotoSansKR',
            fontSize: 16,
            color: Colors.black,
          )),
        ),
      ),
    );
  }
}
