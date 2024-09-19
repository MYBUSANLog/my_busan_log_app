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

class _IntroScreenState extends State<IntroScreen> with TickerProviderStateMixin {
  late final AnimationController _lottieController;

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
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
      // 이미 로그인됨 -> 다시 유저 정보 불러서 상태 관리 세팅
      User? me = await UserHttp.findUser(loginUserIdx);
      Provider.of<UserModel>(context, listen: false).setLoginUser(me!);

      // 로그인된 상태에서 바로 메인 페이지로 이동
      navigateToMainPage();
    } else {
      // 로그인 안됨 -> 로그인 스크린으로 이동
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginOpeningScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Lottie.network(
        'https://lottie.host/163da411-8b72-49f1-a61d-1fab21aeaec5/weTuVsncO6.json',
        controller: _lottieController,
        repeat: false, // 애니메이션 반복 없음
        onLoaded: (composition) {
          _lottieController.duration = composition.duration;

          // 마지막 50프레임 전에 멈추도록 설정
          double stopProgress = (composition.frameRate - 0.1) / composition.frameRate;

          _lottieController.forward().whenComplete(() {
            // 애니메이션을 stopProgress 위치에서 멈춤
            _lottieController.animateTo(stopProgress).whenComplete(() {
              // 애니메이션이 멈춘 후 _checkLoginStatus 호출
              _checkLoginStatus();
            });
          });
        },
        fit: BoxFit.cover,
      ),
    );
  }
}
