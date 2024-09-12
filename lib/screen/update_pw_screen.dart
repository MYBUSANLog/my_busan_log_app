import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Ensure this path is correct
import 'package:busan_trip/model/user_model.dart'; // Ensure this path is correct
import 'package:busan_trip/app_http/user_http.dart';

class UpdatePwScreen extends StatefulWidget {
  const UpdatePwScreen({super.key});

  @override
  State<UpdatePwScreen> createState() => _UpdatePwScreenState();
}

class _UpdatePwScreenState extends State<UpdatePwScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPwController = TextEditingController();
  final TextEditingController newPw1Controller = TextEditingController();

  bool _isPasswordEntered = false;
  bool _isNewPwEntered = false;
  bool _isNewPw1Entered = false;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(_onFieldChanged);
    newPwController.addListener(_onFieldChanged);
    newPw1Controller.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    passwordController.removeListener(_onFieldChanged);
    newPwController.removeListener(_onFieldChanged);
    newPw1Controller.removeListener(_onFieldChanged);
    passwordController.dispose();
    newPwController.dispose();
    newPw1Controller.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    setState(() {
      _isPasswordEntered = passwordController.text.isNotEmpty;
      _isNewPwEntered = newPwController.text.isNotEmpty;
      _isNewPw1Entered = newPw1Controller.text.isNotEmpty;
    });
  }

  bool _isAllFieldsEntered() {
    return _isPasswordEntered &&
        _isNewPwEntered &&
        _isNewPw1Entered;
  }

  bool _isPasswordValid(String password) {
    // Define the regex for password validation
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$',
    );
    return passwordRegex.hasMatch(password);
  }

  Future<void> _validateAndNavigate() async {
    if (newPwController.text != newPw1Controller.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('새 비밀번호와 비밀번호 확인이 일치하지 않습니다.'),
        ),
      );
      // Reset new password fields
      newPwController.clear();
      newPw1Controller.clear();
      return;
    }

    if (!_isPasswordValid(newPwController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('새 비밀번호는 공백을 제외한 영문, 숫자, 특수문자 8~20자리여야 합니다.'),
        ),
      );
      // Reset new password fields
      newPwController.clear();
      newPw1Controller.clear();
      return;
    }

    // UserProvider에서 로그인한 사용자 정보 가져오기
    final userProvider = Provider.of<UserModel>(context, listen: false);
    final loggedInUser = userProvider.loggedInUser;
    print(loggedInUser);
    if (loggedInUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('로그인 정보가 없습니다.'),
        ),
      );
      return;
    }

    // 비밀번호 변경 요청
    bool success = await UserHttp.updatePw(
        loggedInUser.u_idx, // 로그인한 사용자 ID
        passwordController.text,
        newPwController.text
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('비밀번호 변경이 완료되었습니다.'),
        ),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('현재 비밀번호가 일치하지 않습니다.'),
        ),
      );
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
            )
        ),
        elevation: 0,
        title: Text(
          '비밀번호 변경',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildProfileItem('현재 비밀번호', passwordController, _isPasswordEntered, obscureText: true),
              SizedBox(height: 10),
              buildProfileItem('새 비밀번호 ', newPwController, _isNewPwEntered, obscureText: true),
              SizedBox(height: 10),
              buildProfileItem('새 비밀번호 확인', newPw1Controller, _isNewPw1Entered, obscureText: true),
              SizedBox(height: 8),
              Text(
                '공백을 제외한 영문, 숫자, 특수문자 8~20자리',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              )
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
                      ? const Color(0xff0e4194)
                      : Colors.grey,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  '저장',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileItem(String hintText, TextEditingController controller, bool isEntered, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          onChanged: (text) {
            _onFieldChanged();
          },
          obscureText: obscureText,
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