import 'package:busan_trip/model/user_model.dart';
import 'package:busan_trip/screen/login_opening_screen.dart';
import 'package:busan_trip/screen/my_review_list_screen.dart';
import 'package:busan_trip/screen/profile_alter.dart';
import 'package:busan_trip/screen/receipt_screen.dart';
import 'package:busan_trip/screen/review_writer_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart' as kko;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:busan_trip/vo/order.dart' as od;

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Offset _fabOffset = Offset(330, 650); // 초기 위치 설정
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


  void _logoutKakao() async {
    try {
      // SharedPreferences에서 로그인 상태 해제
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false); // 로그인 상태 해제

      // 카카오 로그아웃 처리
      await kko.UserApi.instance.logout();
      print('카카오 로그아웃 성공, SDK에서 토큰 삭제');

      // Firebase 로그아웃 처리
      await FirebaseAuth.instance.signOut();
      print('Firebase 로그아웃 성공');

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
  }


  void _logoutEmail() async {
    try {
      // SharedPreferences 인스턴스 가져오기
      SharedPreferences prefs = await SharedPreferences.getInstance();

      //로그인 정보 불러오기
      String loginProvider = Provider.of<UserModel>(context,listen: false).loggedInUser.login_provider;

      //sns 로그아웃 처리
      if(loginProvider=='google'){
        // Firebase 로그아웃
        await FirebaseAuth.instance.signOut();
        print('이메일 로그아웃 성공');

      }else if(loginProvider=='kakao'){


      }else if(loginProvider=='naver'){

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


  // void logout() async {
  //   // 각 로그인 제공자에 맞는 로그아웃 호출
  //   switch (_loginProvider) {
  //     // case 'google':
  //     //   await _logoutGoogle();
  //     //   break;
  //     case 'naver':
  //       await _logoutNaver();
  //       break;
  //     case 'kakao':
  //       await _logoutKakao();
  //       break;
  //     case 'basic':
  //       await _logoutEmail();
  //       break;
  //     default:
  //     // 알 수 없는 로그인 제공자
  //       break;
  //   }
  //
  //   // Firebase Auth 로그아웃
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //     print('Firebase 로그아웃 성공');
  //   } catch (error) {
  //     print('Firebase 로그아웃 실패 $error');
  //   }
  //
  //   Navigator.of(context).pushReplacement(MaterialPageRoute(
  //     builder: (context) => LoginOpeningScreen(),
  //   ));
  // }

  // void _showLogoutDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('로그아웃'),
  //         content: Text('로그아웃 하시겠습니까?'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context); // 다이얼로그 닫기
  //             },
  //             child: Text('취소'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context); // 다이얼로그 닫기
  //               Navigator.pushReplacement(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => LoginOpeningScreen()), // 화면 이동
  //               );
  //             },
  //             child: Text('예'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        title: Text(
          '프로필',
          style: TextStyle(
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.w500,
            fontSize: 23,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0, // 스크롤 시 AppBar 색상 변경 방지
      ),
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
                      SizedBox(height: 20),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: userModel.loggedInUser.u_img_url != null
                            ? NetworkImage(userModel.loggedInUser.u_img_url!)
                            : AssetImage('assets/images/default_profile.jpg') as ImageProvider,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder:  (context) => ProfileAlterScreen(user: user)),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '설정',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 13), // 아래로 패딩 추가
                      // if (_loginProvider == 'kakao')
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.logout, color: Color(0xff0e4194)),
                        title: Text(
                          '카카오 로그아웃',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: _logoutKakao,
                      ),
                      // if (_loginProvider == 'google')
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.logout, color: Color(0xff0e4194)),
                        title: Text(
                          '구글 로그아웃',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        // onTap: logout,
                      ),
                      // if (_loginProvider == 'naver')
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.logout, color: Color(0xff0e4194)),
                        title: Text(
                          '네이버 로그아웃',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        // onTap: logout,
                      ),
                      // if (_loginProvider == 'basic')
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.logout, color: Color(0xff0e4194)),
                        title: Text(
                          '이메일 로그아웃',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: _logoutEmail,
                      ),
                      Divider(color: Colors.grey, thickness: 1.0),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.payment, color: Color(0xff0e4194)),
                        title: Text(
                          '결제',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/pay');
                        },
                      ),
                      Divider(color: Colors.grey, thickness: 1.0),
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
                        leading: Icon(Icons.favorite, color: Color(0xff0e4194)),
                        title: Text(
                          '찜목록',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          // 찜목록 화면으로 이동
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
                            MaterialPageRoute(builder:  (context) => MyReviewListScreen()),
                          );
                        },
                      ),
                      Divider(color: Colors.grey, thickness: 1.0),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.bookmark, color: Color(0xff0e4194)),
                        title: Text(
                          '북마크 목록',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          // 북마크 목록 화면으로 이동
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
                        leading: Icon(Icons.support_agent, color: Color(0xff0e4194)),
                        title: Text(
                          '고객센터',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          // 고객센터 화면으로 이동
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
                          // 환경 설정 화면으로 이동
                        },
                      ),
                      Divider(color: Colors.grey, thickness: 1.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: _fabOffset.dx,
            top: _fabOffset.dy,
            child: Draggable(
              feedback: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/chatbot');
                },
                child: Icon(Icons.chat, color: Colors.white),
                backgroundColor: Color(0xff0e4194),
              ),
              childWhenDragging: Container(),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/chatbot');
                },
                child: Icon(Icons.chat, color: Colors.white),
                backgroundColor: Color(0xff0e4194),
              ),
              onDragEnd: (details) {
                setState(() {
                  _fabOffset = details.offset;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
