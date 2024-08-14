import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginOpeningScreen extends StatefulWidget {
  const LoginOpeningScreen({super.key});

  @override
  State<LoginOpeningScreen> createState() => _LoginOpeningScreenState();
}

class _LoginOpeningScreenState extends State<LoginOpeningScreen> {

  late Timer _timer;
  int _currentImageIndex = 0;

  final List<String> _backgroundImages = [
    'assets/images/haeundae_beach.png',
    'assets/images/haeundae1.png',
    'assets/images/haeundae2.png',
    'assets/images/haeundae3.png',
    'assets/images/haeundae4.png',
  ];

  @override
  void initState() {
    super.initState();
    KakaoSdk.init(nativeAppKey: '48839f306cca47459b904556fb94d0eb'); // 네이티브 앱 키 설정

    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _backgroundImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void signInWithKakao() async{
    // 카카오 로그인 구현 예제

    // 카카오톡 실행 가능 여부 확인
    // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if(await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  void signInWithNaver() async{
    NaverLoginResult res = await FlutterNaverLogin.logIn();

    print('accessToken = ${res.accessToken}');
    print('id = ${res.account.id}');
    print('email = ${res.account.email}');
    print('name = ${res.account.name}');

    NaverAccessToken accessToken = await FlutterNaverLogin.currentAccessToken;
    print(accessToken.accessToken);
  }

  void signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser;

    try {
      googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google 로그인에 실패했습니다.'),
          ),
        );
        print('Google 로그인에 실패했습니다.');
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google 로그인에 성공했습니다!'),
        ),
      );
      Navigator.pushReplacementNamed(context, '/root_screen');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google 로그인에 실패했습니다: ${e.message}'),
        ),
      );
      print('Google 로그인에 실패했습니다: ${e.message}');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google 로그인 중 오류가 발생했습니다.'),
        ),
      );
      print('Google 로그인 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(seconds: 1), // 애니메이션 지속 시간
            child: Container(
              key: ValueKey<int>(_currentImageIndex), // 현재 이미지 인덱스를 Key로 사용
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_backgroundImages[_currentImageIndex]),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.7), Colors.transparent, Colors.black.withOpacity(0.7)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.7, 1.0],
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/Untitled1.png',
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 170,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Text(
                              '나의 부산을\n여행하다.',
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w700,
                                fontSize: 40,
                                color: Color(0xffffffff),
                              ),
                            ),
                            SizedBox(height: 170,),
                            getKakaoLoginBtn(),
                            SizedBox(height: 10,),
                            getNaverLoginBtn(),
                            SizedBox(height: 10,),
                            getGoogleLoginBtn(),
                            SizedBox(height: 10,),
                            getEmailLoginBtn(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      )
    );
  }

  Widget getKakaoLoginBtn() {
    return InkWell(
      onTap: () {
        signInWithKakao();
      },
      splashColor: Colors.white.withOpacity(0.2),
      highlightColor: Colors.white.withOpacity(0.1),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 2,
        child: Container(
          height: 50,

          decoration: BoxDecoration(
            color: Color(0xffFEE500),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 15,),
              Image.asset('assets/images/kakaotalk_symbol.png', width: 25,),
              Expanded(
                  child: Center(
                    child: Text(
                      "카카오로 시작하기",
                      style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Color(0xff000000),
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget getNaverLoginBtn() {
    return InkWell(
      onTap: () {
        signInWithNaver();
      },
      splashColor: Colors.white.withOpacity(0.2),
      highlightColor: Colors.white.withOpacity(0.1),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 2,
        child: Container(
          height: 50,

          decoration: BoxDecoration(
            color: Color(0xff03c75a),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20,),
              Image.asset('assets/images/naver_symbol.png', width: 17,),
              Expanded(
                  child: Center(
                    child: Text(
                      "네이버로 시작하기",
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Color(0xffffffff),
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget getGoogleLoginBtn() {
    return InkWell(
      onTap: () {
        signInWithGoogle();
      },
      splashColor: Colors.white.withOpacity(0.2),
      highlightColor: Colors.white.withOpacity(0.1),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 2,
        child: Container(
          height: 50,

          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20,),
              Image.asset('assets/images/google_symbol.png', width: 20,),
              Expanded(
                  child: Center(
                    child: Text(
                      "Google로 시작하기",
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Color(0xff000000),
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget getEmailLoginBtn() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/login');
      },
      splashColor: Colors.white.withOpacity(0.2),
      highlightColor: Colors.white.withOpacity(0.1),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 2,
        child: Container(
          height: 50,

          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20,),
              Icon(Icons.mail_outline_sharp, color: Colors.grey, size: 20,),
              Expanded(
                  child: Center(
                    child: Text(
                      "이메일로 시작하기",
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Color(0xff000000),
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
