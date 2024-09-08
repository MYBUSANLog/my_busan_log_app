import 'package:busan_trip/screen/daumpostcodesearchexample.dart';
import 'package:busan_trip/screen/sign_up3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/join_model.dart';

class SignUp2 extends StatefulWidget {
  const SignUp2({super.key});

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pw1Controller = TextEditingController();
  final FocusNode _pwFocusNode = FocusNode();
  final FocusNode _pw1FocusNode = FocusNode();
  String? _errorText1;
  String? _errorText2;
  bool _isPwValid = false;
  bool _isPw1Valid = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_pwFocusNode);
    });

    _pwController.addListener(() {
      setState(() {
        if (_pwController.text.isEmpty) {
          _errorText1 = null;
        } else {
          _isPwValid = _validatePassword(_pwController.text);
          _errorText1 = _isPwValid ? null : '영문 + 숫자 + 특수문자 8~20자리';
        }
      });
    });

    _pw1Controller.addListener(() {
      setState(() {
        if (_pw1Controller.text.isNotEmpty && _pwController.text != _pw1Controller.text) {
          _isPw1Valid = false;
          _errorText2 = '비밀번호가 일치하지 않습니다';
        } else if (_pw1Controller.text.isNotEmpty && _pwController.text == _pw1Controller.text) {
          _isPw1Valid = true;
          _errorText2 = null;
        } else {
          _isPw1Valid = false;
          _errorText2 = null;
        }
      });
    });

    _pwController.addListener(() {
      setState(() {
        if (_pwController.text.isEmpty) {
          _errorText1 = null;
        } else {
          _isPwValid = _validatePassword(_pwController.text);
          _errorText1 = _isPwValid ? null : '공백을 제외한 영문 + 숫자 + 특수문자 8~20자리';
        }
      });
    });

    _pw1FocusNode.addListener(() {
      setState(() {
        if (!_pw1FocusNode.hasFocus && _pw1Controller.text.isNotEmpty && _pwController.text != _pw1Controller.text) {
          _errorText2 = '비밀번호가 일치하지 않습니다';
        } else {
          _errorText2 = null;
        }
      });
    });
  }

  bool _validatePassword(String password) {
    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$');
    // 비밀번호에 공백이 포함된 경우 false 반환
    if (password.contains(' ')) {
      return false;
    }
    // 비밀번호가 유효한 경우 true 반환
    return regex.hasMatch(password);
  }

  void _validateAndNavigate() {
    if (_isPwValid && _isPw1Valid) {
      Provider.of<JoinModel>(context, listen: false).setPw(_pwController.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder:  (context) => SignUp3())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '회원가입 (2/3)',
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              // Consumer<JoinModel>(builder: (context, joinUserModel, child) {
              //   return Text('이메일 : ${joinUserModel.joinUser.u_email}');
              // }),
              TextField(
                controller: _pwController,
                focusNode: _pwFocusNode,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  labelStyle: TextStyle(
                    color: _pwController.text.isEmpty
                        ? Colors.grey
                        : (_isPwValid ? Colors.green : Colors.red),  // 조건 만족 시 초록색, 그렇지 않으면 빨간색
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isPwValid ? Colors.green : Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isPwValid ? Colors.green : Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isPwValid ? Colors.green : Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  suffixIcon: _isPwValid
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  errorText: _errorText1,
                ),
                obscureText: true,
                cursorColor: const Color(0xff0e4194),
              ),
              const SizedBox(height: 30,),
              TextField(
                controller: _pw1Controller,
                focusNode: _pw1FocusNode,
                decoration: InputDecoration(
                  labelText: '비밀번호 확인',
                  labelStyle: TextStyle(
                    color: _pw1Controller.text.isEmpty
                        ? Colors.grey
                        : (_isPw1Valid ? Colors.green : Colors.red),  // 조건 만족 시 초록색, 그렇지 않으면 빨간색
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _pw1Controller.text.isEmpty
                          ? Colors.grey
                          : (_isPw1Valid
                          ? Colors.green
                          : Colors.grey),
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _pw1Controller.text.isEmpty
                          ? Colors.grey
                          : (_isPw1Valid
                          ? Colors.green
                          : Colors.grey),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isPw1Valid && _pw1Controller.text.isNotEmpty
                          ? Colors.green
                          : Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  suffixIcon: _isPw1Valid && _pw1Controller.text.isNotEmpty
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  errorText: _errorText2,
                ),
                obscureText: true,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(0),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _isPwValid && _isPw1Valid ? _validateAndNavigate : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isPwValid && _isPw1Valid
                    ? const Color(0xff0e4194)
                    : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: BorderSide.none,
                ),
                padding: EdgeInsets.zero,
              ),
              child: const Text(
                '다음',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
