import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class DeleteUserScreen extends StatefulWidget {
  const DeleteUserScreen({super.key});

  @override
  State<DeleteUserScreen> createState() => _DeleteUserScreenState();
}

class _DeleteUserScreenState extends State<DeleteUserScreen> {

  TextEditingController passwordController = TextEditingController();

  bool _isPasswordEntered = false;

  bool _isAllFieldsEntered() {
    return _isPasswordEntered != null;
  }

  void _onFieldChanged() {
    setState(() {
      _isPasswordEntered = passwordController.text.isNotEmpty;
    });
  }

  void _validateAndNavigate() async {
    if (_isAllFieldsEntered()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Provider.of<UserModel>(context, listen: false).loggedInUser = passwordController;
      Provider.of<UserModel>(context,listen: false).unjoinUser();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('회원탈퇴가 완료되었습니다'),
        ),
      );
      await prefs.setInt("login_u_idx", 0);
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  void initState() {
    super.initState();

    KakaoSdk.init(nativeAppKey: '3cbc4103340e6be3c6247d5228d55534');

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ));
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
          '회원 탈퇴',
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
