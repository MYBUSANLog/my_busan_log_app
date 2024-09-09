import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class UpdatePwScreen extends StatefulWidget {
  const UpdatePwScreen({super.key});

  @override
  State<UpdatePwScreen> createState() => _UpdatePwScreenState();
}

class _UpdatePwScreenState extends State<UpdatePwScreen> {

  TextEditingController passwordController = TextEditingController();
  TextEditingController newPwController = TextEditingController();
  TextEditingController newPw1Controller = TextEditingController();

  bool _isPasswordEntered = false;
  bool _isnewPwEntered = false;
  bool _isnewPw1Entered = false;


  bool _isAllFieldsEntered() {
    return _isPasswordEntered &&
        _isnewPwEntered &&
        _isnewPw1Entered != null;
  }

  void _onFieldChanged() {
    setState(() {
      _isPasswordEntered = passwordController.text.isNotEmpty;
      _isnewPwEntered = newPwController.text.isNotEmpty;
      _isnewPw1Entered = newPw1Controller.text.isNotEmpty;
    });
  }

  void _validateAndNavigate() async {
    if (_isAllFieldsEntered()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Provider.of<UserModel>(context, listen: false).loggedInUser = passwordController;
      Provider.of<UserModel>(context,listen: false).updatePw();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('비밀번호 변경이 완료되었습니다'),
        ),
      );
      await prefs.setInt("login_u_idx", 0);
      Navigator.of(context).popUntil((route) => route.isFirst);
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
              buildProfileItem('현재 비밀번호', passwordController, false),
              SizedBox(height: 10),
              buildProfileItem('새 비밀번호', newPwController, false),
              SizedBox(height: 10),
              buildProfileItem('새 비밀번호 확인', newPwController, false),
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
  Widget buildProfileItem(String HintText, TextEditingController controller, bool isEntered) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          onChanged: (text) {
            _onFieldChanged();
          },
          decoration: InputDecoration(
            isDense: true,
            hintText: HintText,
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
