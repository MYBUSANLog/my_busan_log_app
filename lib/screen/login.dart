import 'package:busan_trip/screen/sign_up1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:busan_trip/screen/sign_up.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../vo/user.dart';

import '../model/user_model.dart'; // 회원가입 추가

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    // 화면이 나타날 때 자동으로 아이디 텍스트 필드에 포커스를 줍니다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_emailFocusNode);
    });
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/root_screen');
    }
  }


  Future<void> _login(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    User u = User(
      u_email: _emailController.text,
      u_pw: _pwController.text,
    );
    var result = await Provider.of<UserModel>(context,listen: false).loginUser(user: u);

    setState(() {
      _isLoading = false;
    });

    if(result) {
      int u_idx = Provider.of<UserModel>(context,listen: false).loggedInUser!.u_idx;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('login_u_idx', u_idx);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('로그인에 성공했습니다!'),
        ),
      );
      Navigator.pushReplacementNamed(context, '/root_screen');
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('이메일 또는 비밀번호가 잘못되었습니다'),
        ),
      );
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
      appBar: AppBar(
        title: Text(
          '이메일로 로그인',
          style: TextStyle(
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  TextField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,  // 포커스 노드를 연결합니다.
                    decoration: InputDecoration(
                      labelText: '이메일',
                      labelStyle: TextStyle(color: Color(0xff0e4194)),
                      border: OutlineInputBorder(),
                    ),
                    cursorColor: Color(0xff0e4194),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _pwController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      labelStyle: TextStyle(color: Color(0xff0e4194)),
                      border: OutlineInputBorder(),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(0xff0e4194),
                        ),
                      ),
                    ),
                    cursorColor: Color(0xff0e4194),
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [Color(0xff0e4194), Colors.blueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _login(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: _isLoading
                          ? SizedBox(
                        width: 17,
                        height: 17,
                        child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2,
                        ),
                      )
                          : Text(
                        '로그인',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpScreen()),
                          );
                        },
                        child: Text(
                          "비밀번호 재설정",
                          style: TextStyle(color: Color(0xff0e4194)),
                        ),
                      ),
                      Text(' | '),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp1()),
                          );
                        },
                        child: Text(
                          "이메일로 회원가입",
                          style: TextStyle(color: Color(0xff0e4194)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // if (_isLoading)
            //   Center(
            //     child: CircularProgressIndicator(),
            //   ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _emailFocusNode.dispose();  // FocusNode를 해제합니다.
    super.dispose();
  }
}
