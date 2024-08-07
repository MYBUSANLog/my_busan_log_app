import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    String id = _idController.text;
    String password = _passwordController.text;

    if (id == 'test' && password == '1234') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('로그인에 성공했습니다!'),
        ),
      );
      Navigator.pushReplacementNamed(context, '/root_screen');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ID 또는 비밀번호가 잘못되었습니다.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // statusBarColor: Colors.transparent,
      // statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff0e4194), Colors.blueAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/Untitled1.png',
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Color(0xff0e4194),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: _idController,
                    decoration: InputDecoration(
                      labelText: 'Id',
                      labelStyle: TextStyle(color: Color(0xff0e4194)),
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff0e4194)),
                      ),
                    ),
                    cursorColor: Color(0xff0e4194),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Color(0xff0e4194)),
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff0e4194)),
                      ),
                      suffixIcon: Icon(Icons.visibility_off, color: Color(0xff0e4194)),
                    ),
                    cursorColor: Color(0xff0e4194),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Add forgot password functionality
                      },
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(color: Color(0xff0e4194)),
                      ),
                    ),
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
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      // Add sign up functionality
                    },
                    child: Text(
                      "Don't have an account? Sign up",
                      style: TextStyle(color: Color(0xff0e4194)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
