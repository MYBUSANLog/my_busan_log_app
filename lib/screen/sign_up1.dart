import 'package:flutter/material.dart';

class SignUp1 extends StatefulWidget {
  const SignUp1({super.key});

  @override
  State<SignUp1> createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  bool _isCodeFieldVisible = false;
  bool _isResendButton = false;
  String? _errorText1;
  String? _errorText2;
  bool _isEmailSent = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_emailFocusNode);
    });
  }

  Future<void> _emailCode() async {
    String email = _emailController.text;
    if (email.isEmpty) {
      setState(() {
        _errorText1 = '이메일을 입력해주십시오';
        _isEmailSent = false;
      });
    } else {
      setState(() {
        _isResendButton = true;
        _isCodeFieldVisible = true;
        _errorText1 = null;  // 에러 메시지 초기화
        _isEmailSent = true;  // 이메일 전송 성공
      });
    }
  }

  void _validateAndNavigate() {
    String code = _codeController.text;
    if (code.length == 6) {
      Navigator.pushNamed(context, '/sign_up2');
    } else {
      setState(() {
        _errorText2 = '인증번호가 올바르지 않습니다.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 키보드 높이와 화면의 패딩 정보를 얻습니다.
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    Color getLabelColor(String? errorText) {
      if (errorText != null) {
        return Colors.red; // 에러 메시지가 있을 때 빨간색
      }
      return _isEmailSent ? Colors.green : Color(0xff0e4194); // 에러 메시지가 없을 때
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '회원가입 (1/3)',
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              decoration: InputDecoration(
                labelText: '이메일',
                labelStyle: TextStyle(color: _isEmailSent ? Colors.green : Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isEmailSent ? Colors.green : Colors.grey,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isEmailSent ? Colors.green : Colors.grey,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isEmailSent ? Colors.green : Color(0xff0e4194),
                    width: 2.0,
                  ),
                ),
                errorText: _errorText1,
                suffixIcon: _isEmailSent
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : null,
              ),
              cursorColor: Color(0xff0e4194),
            ),
            SizedBox(height: 40),
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: _isResendButton
                      ? [Colors.white, Colors.white] // Resend Button 색상
                      : [Color(0xff0e4194), Colors.blueAccent], // Send Button 색상
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ElevatedButton(
                onPressed: _emailCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: _isResendButton
                      ? BorderSide(color: Color(0xff0e4194), width: 2.0)
                      : BorderSide.none, // Resend Button에 테두리 추가
                ),
                child: Text(
                  _isResendButton ? '인증번호 재전송' : '인증번호 전송',
                  style: TextStyle(
                    fontSize: 16,
                    color: _isResendButton ? Color(0xff0e4194) : Colors.white,
                  ),
                ),
              ),
            ),
            if (_isCodeFieldVisible) ...[
              SizedBox(height: 70),
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '인증번호 입력',
                  labelStyle: TextStyle(color: _isEmailSent ? Color(0xff0e4194) : Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isEmailSent ? Color(0xff0e4194) : Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isEmailSent ? Color(0xff0e4194) : Color(0xff0e4194),
                      width: 2.0,
                    ),
                  ),
                  errorText: _errorText2,
                ),
                cursorColor: Color(0xff0e4194),
              ),
              SizedBox(height: 20),
            ],
          ],
        ),
      ),
      bottomNavigationBar: _isCodeFieldVisible
          ? Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(0),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _validateAndNavigate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff0e4194),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // 각진 모서리
                ),
                padding: EdgeInsets.zero, // 패딩 제거
              ),
              child: Text(
                '다음',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      )
          : null,
    );
  }
}
