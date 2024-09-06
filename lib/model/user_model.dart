
import 'package:busan_trip/app_http/user_http.dart';
import '../vo/user.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier {
  User loggedInUser = User();
  User joinUser = User();
  User updateUser = User();


  //자동 로그인시 자기 자신 세팅
  void setLoginUser(User user){
    loggedInUser=user;
    notifyListeners();
  }

  void setEmail(String email) {
    loggedInUser.u_email=email;
    updateUser.u_email=email;
    notifyListeners();
  }

  void setPw(String pw) {
    loggedInUser.u_pw=pw;
    updateUser.u_pw=pw;
    notifyListeners();
  }

  void setName(String name) {
    updateUser.u_name=name;
    notifyListeners();
  }

  void setNickname(String nickname) {
    updateUser.u_nick=nickname;
    notifyListeners();
  }

  void setBirthday(String birthday) {
    updateUser.u_birth=birthday;
    notifyListeners();
  }

  void setPhone(String phone) {
    updateUser.u_p_number=phone;
    notifyListeners();
  }

  void setAddress(String address) {
    updateUser.u_address=address;
    notifyListeners();
  }

  void setTrippreference(int trip_preference) {
    updateUser.trip_preference=trip_preference;
    notifyListeners();
  }

  Future<void> updateSaveUser() async {
    try {
      User registeredUser = await UserHttp.updateUser(updateUser);
      updateUser = registeredUser;
      notifyListeners();
    } catch (e) {
      throw Exception('프로필 수정 중 오류 발생: $e');
    }
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