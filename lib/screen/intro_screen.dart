import 'dart:async';

import 'package:busan_trip/app_http/user_http.dart';
import 'package:busan_trip/screen/login_opening_screen.dart';
import 'package:busan_trip/screen/root_screen.dart';
import 'package:busan_trip/vo/user.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class IntroScreen extends StatefulWidget {

  IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with SingleTickerProviderStateMixin {

  late final AnimationController _lottieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lottieController = AnimationController(vsync: this);
    _checkLoginStatus();
  }

  @override
  void dispose() {  //컨트롤러 해제
    _lottieController.dispose();
    super.dispose();
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
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/animations/Flow_1.json',
          controller: _lottieController,
          onLoaded: (composition) {
            _lottieController.duration = composition.duration;
            _lottieController.forward(from: 0.5);
          },
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}