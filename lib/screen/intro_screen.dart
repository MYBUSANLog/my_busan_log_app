import 'dart:async';

import 'package:busan_trip/app_http/user_http.dart';
import 'package:busan_trip/screen/login_opening_screen.dart';
import 'package:busan_trip/screen/root_screen.dart';
import 'package:busan_trip/vo/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import '../vo/order.dart' as od;

class IntroScreen extends StatefulWidget {

  IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLoginStatus();
  }

  void navigateToMainPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => RootScreen(),
    ));
  }

  void _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final int loginUserIdx = prefs.getInt('login_u_idx') ?? 0;

    if (loginUserIdx > 0) {
      //이미 로그인됨 -> 다시 유저 정보 불어서 상태 관리 세팅
      User? me = await UserHttp.findUser(loginUserIdx);
      Provider.of<UserModel>(context, listen: false).setLoginUser(me!);

      // 로그인된 상태에서 바로 메인 페이지로 이동
      navigateToMainPage();
    } else {
      //로그인 안됨 -> 로그인 스크린으로 이동
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginOpeningScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {

    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xff0e4194),
    ));

    return Scaffold(
      backgroundColor: Color(0xff0e4194),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/Untitled1.png',
                width: MediaQuery.of(context).size.width / 2,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}