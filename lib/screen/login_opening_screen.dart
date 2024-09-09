import 'dart:async';
import 'package:busan_trip/screen/root_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kko;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart' as kko_user;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../vo/user.dart' as u;
import '../model/user_model.dart';

import 'package:kakao_flutter_sdk_talk/kakao_flutter_sdk_talk.dart' as kakao_order;
import '../vo/order.dart' as od;

class LoginOpeningScreen extends StatefulWidget {
  const LoginOpeningScreen({Key? key}) : super(key: key);

  @override
  State<LoginOpeningScreen> createState() => _LoginOpeningScreenState();
}

class _LoginOpeningScreenState extends State<LoginOpeningScreen> {
  late Timer _timer;
  int _currentImageIndex = 0;
  bool _isLoadingKakao = false;
  bool _isLoadingNaver = false;
  bool _isLoadingGoogle = false;

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

    kko_user.KakaoSdk.init(nativeAppKey: '3cbc4103340e6be3c6247d5228d55534'); // 네이티브 앱 키 설정

    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _backgroundImages.length;
      });
    });

    _checkLoginStatus(); // 앱 시작 시 로그인 상태 확인
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/root_screen');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void navigateToMainPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => RootScreen(),
    ));
  }

  void signInWithKakao() async {
    setState(() {
      _isLoadingKakao = true; // 로딩 시작
    });

    try {
      // 카카오톡이 설치되어 있는지 확인 후, 카카오톡으로 로그인 시도
      if (await kko_user.isKakaoTalkInstalled()) {
        try {
          await kko_user.UserApi.instance.loginWithKakaoTalk();
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true); // 로그인 상태 저장
          await prefs.setString('loginMethod', 'kakao'); // 로그인 방법 저장
          print('카카오톡으로 로그인 성공');
        } catch (error) {
          print('카카오톡으로 로그인 실패 $error');
          // 카카오톡 로그인 실패 시, 카카오 계정으로 로그인 시도
          await kko_user.UserApi.instance.loginWithKakaoAccount();
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true); // 로그인 상태 저장
          await prefs.setString('loginMethod', 'kakao'); // 로그인 방법 저장
          print('카카오 계정으로 로그인 성공');
        }
      } else {
        // 카카오톡이 설치되어 있지 않은 경우, 카카오 계정으로 로그인 시도
        await kko_user.UserApi.instance.loginWithKakaoAccount();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true); // 로그인 상태 저장
        await prefs.setString('loginMethod', 'kakao'); // 로그인 방법 저장
        print('카카오 계정으로 로그인 성공');
      }

      // 로그인 후 사용자 정보 가져오기
      kko_user.User? kakaoUser = await kko_user.UserApi.instance.me();
      String? email = kakaoUser.kakaoAccount?.email ?? '';
      String? birthday = kakaoUser.kakaoAccount?.birthday;
      String formattedBirthday = birthday != null && birthday.length == 4
          ? "${birthday.substring(0, 2)}-${birthday.substring(2, 4)}"
          : '';

      String? phoneNumber = kakaoUser.kakaoAccount?.phoneNumber;
      String formattedNumber = phoneNumber != null && phoneNumber.length >= 4
          ? '0' + phoneNumber.substring(4, 16)
          : '';

      print(kakaoUser.kakaoAccount);

      // 유저 정보를 바탕으로 User 객체를 생성
      u.User user = u.User(
        u_email: email,
        u_name: kakaoUser.kakaoAccount?.name ?? '',
        u_img_url: kakaoUser.kakaoAccount?.profile?.profileImageUrl ?? '',
        u_nick: kakaoUser.kakaoAccount?.profile?.nickname ?? '',
        u_birth: "${kakaoUser.kakaoAccount?.birthyear ?? ''}-${formattedBirthday}",
        u_p_number: formattedNumber,
        u_address: '',
        trip_preference: 3,
        business_license: '',
        login_provider: 'kakao',
        // 기타 필드들 초기화
      );


      // UserModel 프로바이더를 사용하여 데이터베이스에 유저가 존재하는지 확인
      UserModel userModel = Provider.of<UserModel>(context, listen: false);
      bool userExists = await userModel.checkUserExists(email: email);

      if (userExists) {
        // 유저가 이미 존재하면 로그인 함수 호출
        await userModel.kakaoLoginUser(user: user);
      } else {
        // 유저가 존재하지 않으면 등록 함수 호출
        await userModel.kakaoRegisterUser(user);
      }

      // 로그인 성공 시, 팝업 닫기 및 메인 페이지로 이동
      // Navigator.of(context).pop();  // 팝업 닫기
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => RootScreen()),
      );

    } catch (error) {
      print('카카오 로그인 실패 $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('카카오 로그인에 실패했습니다.'),
        ),
      );
    } finally {
      setState(() {
        _isLoadingKakao = false; // 로딩 종료
      });
    }
  }



  void signInWithNaver() async {
    setState(() {
      _isLoadingNaver = true; // 로딩 시작
    });

    try {
      final NaverLoginResult res = await FlutterNaverLogin.logIn();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true); // 로그인 상태 저장
      await prefs.setString('loginMethod', 'naver'); // 로그인 방법 저장
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('네이버 로그인에 성공했습니다.'),
        ),
      );
      navigateToMainPage();
      print('accessToken = ${res.accessToken}');
      print('id = ${res.account.id}');
      print('email = ${res.account.email}');
      print('name = ${res.account.name}');
      print('nickname = ${res.account.nickname}');
      print('birth = ${res.account.birthyear}-${res.account.birthday}');
      print('p_number = ${res.account.mobile}');
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('네이버 로그인에 실패했습니다.'),
        ),
      );
      print(error);
    } finally {
      setState(() {
        _isLoadingNaver = false; // 로딩 종료
      });
    }
  }

  void signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser;

    setState(() {
      _isLoadingGoogle = true; // 로딩 시작
    });

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
      final fb.AuthCredential credential = fb.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final fb.UserCredential userCredential = await fb.FirebaseAuth.instance.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google 로그인에 성공했습니다!'),
        ),
      );
      navigateToMainPage();
    } on fb.FirebaseAuthException catch (e) {
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
    } finally {
      setState(() {
        _isLoadingGoogle = false; // 로딩 종료
      });
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

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: 40,),
                            Text(
                              '나의 부산을\n여행하다.',
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w700,
                                fontSize: 40,
                                color: Color(0xffffffff),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  getKakaoLoginBtn(),
                                  SizedBox(height: 10,),
                                  getNaverLoginBtn(),
                                  SizedBox(height: 10,),
                                  getGoogleLoginBtn(),
                                  SizedBox(height: 10,),
                                  getEmailLoginBtn(),
                                  SizedBox(height: 30,),
                                ],
                              ),
                            ),
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
      ),
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
                    child: _isLoadingKakao
                        ? SizedBox(
                      width: 17,
                      height: 17,
                      child: CircularProgressIndicator(
                        color: Color(0xff000000), strokeWidth: 2,
                      ),
                    )
                        : Text(
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
                    child: _isLoadingNaver
                        ? SizedBox(
                      width: 17,
                      height: 17,
                      child: CircularProgressIndicator(
                        color: Color(0xff000000), strokeWidth: 2,
                      ),
                    )
                        : Text(
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
                    child: _isLoadingGoogle
                        ? SizedBox(
                      width: 17,
                      height: 17,
                      child: CircularProgressIndicator(
                        color: Color(0xff000000), strokeWidth: 2,
                      ),
                    )
                        : Text(
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
