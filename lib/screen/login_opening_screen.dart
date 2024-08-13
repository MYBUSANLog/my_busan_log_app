import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginOpeningScreen extends StatefulWidget {
  const LoginOpeningScreen({super.key});

  @override
  State<LoginOpeningScreen> createState() => _LoginOpeningScreenState();
}

class _LoginOpeningScreenState extends State<LoginOpeningScreen> {

  @override
  void initState() {
    super.initState();
    KakaoSdk.init(nativeAppKey: 'YOUR_NATIVE_APP_KEY'); // 네이티브 앱 키 설정
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

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 150,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/006.png',
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 50,),
                  getKakaoLoginBtn(),
                  getNaverLoginBtn(),
                  getGoogleLoginBtn(),
                  getEmailLoginBtn(),
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  Widget getKakaoLoginBtn() {
    return InkWell(
      onTap: () {
        signInWithKakao();
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 2,
        child: Container(
          height: 50,

          decoration: BoxDecoration(
            color: Color(0xffFEE500),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 15,),
              Image.asset('assets/images/kakaotalk_symbol.png', width: 25,),
              Expanded(
                  child: Center(
                    child: Text(
                      "카카오톡으로 로그인",
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
        // signInWithNaver();
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 2,
        child: Container(
          height: 50,

          decoration: BoxDecoration(
            color: Color(0xff03c75a),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20,),
              Image.asset('assets/images/naver_symbol.png', width: 17,),
              Expanded(
                  child: Center(
                    child: Text(
                      "네이버로 로그인",
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
        // signInWithGoogle();
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 2,
        child: Container(
          height: 50,

          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20,),
              Image.asset('assets/images/google_symbol.png', width: 20,),
              Expanded(
                  child: Center(
                    child: Text(
                      "Google로 로그인",
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
        // signInWithGoogle();
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 2,
        child: Container(
          height: 50,

          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20,),
              Icon(Icons.mail_outline_sharp, color: Colors.grey, size: 20,),
              Expanded(
                  child: Center(
                    child: Text(
                      "이메일로 로그인",
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
