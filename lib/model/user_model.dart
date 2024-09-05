
import 'package:busan_trip/app_http/user_http.dart';
import '../vo/user.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier {
  User loggedInUser = User();
  User joinUser = User();


  //자동 로그인시 자기 자신 세팅
  void setLoginUser(User user){
    loggedInUser=user;
    notifyListeners();
  }

  void setEmail(String email) {
    loggedInUser.u_email=email;
    notifyListeners();
  }

  void setPw(String pw) {
    loggedInUser.u_pw=pw;
    notifyListeners();
  }

  // 이메일 로그인 처리 메서드
  Future<bool> loginUser({required User user}) async {
    loggedInUser = await UserHttp.loginUser(user);

    notifyListeners();

    if(loggedInUser.u_idx==0){
      return false;
    }else{
      return true;
    }
  }

  // Kakao 회원가입 처리 메서드
  Future<void> kakaoRegisterUser(User user) async {
    try {
      User kakaoRegisteredUser = await UserHttp.kakaoRegisterUser(user: user);
      joinUser = kakaoRegisteredUser;
      notifyListeners();
    } catch (e) {
      throw Exception('회원가입 중 오류 발생: $e');
    }
  }

  // Kakao 로그인 처리 메서드
  Future<bool> kakaoLoginUser({required User user}) async {
    loggedInUser = await UserHttp.kakaoLoginUser(user);

    notifyListeners();

    if(loggedInUser.u_idx==0){
      return false;
    }else{
      return true;
    }
  }

  Future<bool> checkUserExists({required String email}) async {
    // 이메일로 사용자 존재 여부 확인
    User? user = await UserHttp.kakaoLoginUser(User(
      u_email: email,
      login_provider: 'kakao',
    ));

    // 사용자 정보가 있으면 true, 없으면 false 반환
    return user.u_email.isNotEmpty;
  }


}