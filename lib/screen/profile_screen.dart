import 'package:busan_trip/model/user_model.dart';
import 'package:busan_trip/screen/heart_list_screen.dart';
import 'package:busan_trip/screen/login_opening_screen.dart';
import 'package:busan_trip/screen/my_review_list_screen.dart';
import 'package:busan_trip/screen/profile_alter.dart';
import 'package:busan_trip/screen/receipt_screen.dart';
import 'package:busan_trip/screen/review_writer_screen.dart';
import 'package:busan_trip/screen/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart' as kko;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Offset _fabOffset = Offset(340, 740); // 초기 위치 설정
  String _loginProvider = ''; // 현재 로그인 제공자

  @override
  void initState() {
    super.initState();

    KakaoSdk.init(nativeAppKey: '3cbc4103340e6be3c6247d5228d55534');

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ));

    _determineLoginProvider(); // 로그인 제공자 확인
  }

  void _determineLoginProvider() async {
    // 로그인 제공자 확인
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final providerData = user.providerData;

      for (var profile in providerData) {
        switch (profile.providerId) {
          case 'google.com':
            setState(() {
              _loginProvider = 'google';
            });
            break;
          case 'naver.com':
            setState(() {
              _loginProvider = 'naver';
            });
            break;
          case 'kakao.com':
            setState(() {
              _loginProvider = 'kakao';
            });
            break;
          default:
            setState(() {
              _loginProvider = 'email';
            });
            break;
        }
      }
    }
  }

  // void _logoutGoogle() async {
  //   try {
  //     await GoogleSignIn().signOut();
  //     print('구글 로그아웃 성공');
  //   } catch (error) {
  //     print('구글 로그아웃 실패 $error');
  //   }
  // }

  void _logoutNaver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // 로그인 상태 해제
    try {
      await FlutterNaverLogin.logOut();
      print('Naver logout successful');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginOpeningScreen(),
      ));
    } catch (error) {
      print('Naver logout failed: $error');
      // You might want to handle the error here, like showing a message to the user
    }
  }


  void _logout() async {
    try {
      // SharedPreferences 인스턴스 가져오기
      SharedPreferences prefs = await SharedPreferences.getInstance();

      //로그인 정보 불러오기
      String loginProvider = Provider.of<UserModel>(context,listen: false).loggedInUser.login_provider;

      //sns 로그아웃 처리
      if(loginProvider=='google'){

        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', false); // 로그인 상태 해제

          await GoogleSignIn().signOut();
          print('구글 로그아웃 성공');
        } catch (error) {
          print('구글 로그아웃 실패 $error');
        }

      }else if(loginProvider=='kakao'){

        try {
          // SharedPreferences에서 로그인 상태 해제
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // await prefs.setBool('isLoggedIn', false); // 로그인 상태 해제

          await prefs.setInt("login_u_idx", 0);

          // 카카오 로그아웃 처리
          await kko.UserApi.instance.logout();
          print('카카오 로그아웃 성공, SDK에서 토큰 삭제');

          // // Firebase 로그아웃 처리
          // await FirebaseAuth.instance.signOut();
          // print('Firebase 로그아웃 성공');

          // 로그아웃 후 로그인 화면으로 이동
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginOpeningScreen(),
            ),
          );
        } catch (error) {
          print('로그아웃 실패 $error');
          // 에러 처리: 필요시 추가적인 에러 핸들링 로직을 추가할 수 있습니다.
        }

      }else if(loginProvider=='naver'){

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', false); // 로그인 상태 해제

        try {
          await FlutterNaverLogin.logOut();
          print('Naver logout successful');
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginOpeningScreen(),
          ));
        } catch (error) {
          print('Naver logout failed: $error');
          // You might want to handle the error here, like showing a message to the user
        }

      }


      // 로그인 상태와 로그인 기록 삭제
      await prefs.setInt("login_u_idx", 0);


      // 로그아웃 후 로그인 화면으로 이동
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginOpeningScreen()),
      );
    } catch (error) {
      print('이메일 로그아웃 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView( // SingleChildScrollView 설정(나현)
            child: ConstrainedBox(
              constraints: BoxConstraints( // SingleChildScrollView 설정(나현)
                minHeight: MediaQuery.of(context).size.height, // 최소 높이 설정(나현)
              ),
              child: IntrinsicHeight(
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: 60),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '프로필',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: userModel.loggedInUser.u_img_url != null
                                ? NetworkImage(userModel.loggedInUser.u_img_url!)
                                : AssetImage('assets/images/default_profile.jpg') as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder:  (context) => ProfileAlterScreen()),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2), // Shadow color
                                      spreadRadius: 2, // Spread radius
                                      blurRadius: 5,   // Blur radius
                                      offset: Offset(0, 3), // Shadow position
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.edit, color: Color(0xff0e4194), size: 25),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.receipt, color: Color(0xff0e4194)),
                        title: Text(
                          '결제내역',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder:  (context) => ReceiptScreen()),
                          );
                        },
                      ),
                      Divider(color: Colors.grey, thickness: 1.0),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.rate_review, color: Color(0xff0e4194)),
                        title: Text(
                          '내가 쓴 리뷰',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder:  (context) => MyReviewListScreen(u_idx: userModel.loggedInUser.u_idx)),
                          );
                        },
                      ),
                      Divider(color: Colors.grey, thickness: 1.0),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.favorite, color: Color(0xff0e4194)),
                        title: Text(
                          '마음함',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder:  (context) => HeartListScreen(userId: userModel.loggedInUser.u_idx)),
                          );
                        },
                      ),
                      Divider(color: Colors.grey, thickness: 1.0),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.announcement, color: Color(0xff0e4194)),
                        title: Text(
                          '공지사항',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          // 공지사항 화면으로 이동
                        },
                      ),
                      Divider(color: Colors.grey, thickness: 1.0),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.settings, color: Color(0xff0e4194)),
                        title: Text(
                          '환경 설정',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder:  (context) => SettingsScreen()),
                          );
                        },
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}