import 'package:busan_trip/screen/delete_user_screen.dart';
import 'package:busan_trip/screen/update_pw_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kko;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import 'login_opening_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    kko.KakaoSdk.init(nativeAppKey: '3cbc4103340e6be3c6247d5228d55534');
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



          // 카카오 로그아웃 처리
          await kko.UserApi.instance.logout();
          await prefs.setInt("login_u_idx", 0);
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

  void _showPasswordConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          title: Text(
            '로그아웃',
            style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w600,
                fontSize: 20),
          ),
          content: Text(
            '정말 로그아웃 하시겠습니까?',
            style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          actions: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _logout();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(0xff0e4194),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '로그아웃',
                        style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 15
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '취소',
                        style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 15
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          '환경 설정',
          style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _showPasswordConfirmationDialog();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '로그아웃',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_outlined,
                      color: Colors.black,
                      size: 20,
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => UpdatePwScreen()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '비밀번호 변경',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_outlined,
                      color: Colors.black,
                      size: 20,
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '고객센터',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_outlined,
                      color: Colors.black,
                      size: 20,
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => DeleteUserScreen()),
                  );
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey[500]!, width: 1.0))
                    ),
                    child: Text(
                      '회원탈퇴',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
