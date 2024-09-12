import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import '../app_http/user_http.dart';
import 'login_opening_screen.dart'; // 로그인 페이지로 이동할 때 사용

class DeleteUserScreen extends StatefulWidget {
  const DeleteUserScreen({super.key});

  @override
  State<DeleteUserScreen> createState() => _DeleteUserScreenState();
}

class _DeleteUserScreenState extends State<DeleteUserScreen> {
  TextEditingController passwordController = TextEditingController();
  bool _isPasswordEntered = false;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    passwordController.removeListener(_onFieldChanged);
    passwordController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    setState(() {
      _isPasswordEntered = passwordController.text.isNotEmpty;
    });
  }

  bool _isAllFieldsEntered() {
    return _isPasswordEntered;
  }

  Future<void> _validateAndNavigate() async {
    if (_isAllFieldsEntered()) {
      final userProvider = Provider.of<UserModel>(context, listen: false);
      final loggedInUser = userProvider.loggedInUser;

      if (loggedInUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('로그인 정보가 없습니다.'),
          ),
        );
        return;
      }

      bool success = await UserHttp.unjoin(
        loggedInUser.u_idx, // 로그인한 사용자 ID
        passwordController.text,
      );

      if (success) {
        // 탈퇴 후 로그아웃 처리
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // 로그인 상태 초기화
        await prefs.setInt("login_u_idx", 0);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('회원탈퇴가 완료되었습니다.'),
          ),
        );

        // 로그인 페이지로 이동
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginOpeningScreen()), // 로그인 페이지로 이동
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('비밀번호가 일치하지 않습니다.'),
          ),
        );
      }
    }
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
          ),
        ),
        elevation: 0,
        title: Text(
          '회원 탈퇴',
          style: TextStyle(
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '회원탈퇴를 위해\n비밀번호를 입력해주세요',
                style: TextStyle(
                  fontFamily: 'NotoSansKR',
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              buildProfileItem('비밀번호', passwordController, false),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _isAllFieldsEntered() ? _validateAndNavigate : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isAllFieldsEntered()
                      ? Colors.red
                      : Colors.grey,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  '회원탈퇴',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileItem(String hintText, TextEditingController controller, bool isEntered) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          onChanged: (text) {
            _onFieldChanged();
          },
          obscureText: true,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ),
          cursorColor: Color(0xff0e4194),
        ),
      ],
    );
  }
}