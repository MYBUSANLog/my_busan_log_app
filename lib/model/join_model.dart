import 'package:flutter/cupertino.dart';

import '../app_http/user_http.dart';
import '../vo/user.dart';

class JoinModel extends ChangeNotifier {
  User joinUser = User();

  void setEmail(String email) {
    joinUser.u_email=email;
    notifyListeners();
  }

  void setPw(String pw) {
    joinUser.u_pw=pw;
    notifyListeners();
  }

  void setName(String name) {
    joinUser.u_name=name;
    notifyListeners();
  }

  void setNickname(String nickname) {
    joinUser.u_nick=nickname;
    notifyListeners();
  }

  void setBirthday(String birthday) {
    joinUser.u_birth=birthday;
    notifyListeners();
  }

  void setPhone(String phone) {
    joinUser.u_p_number=phone;
    notifyListeners();
  }

  void setAddress(String address) {
    joinUser.u_address=address;
    notifyListeners();
  }

  void setTrippreference(int trip_preference) {
    joinUser.trip_preference=trip_preference;
    notifyListeners();
  }

  Future<void> saveUser() async {
    try {
      User registeredUser = await UserHttp.registerUser(joinUser);
      joinUser = registeredUser;
      notifyListeners();
    } catch (e) {
      throw Exception('회원가입 중 오류 발생: $e');
    }
  }

  // 이메일 중복 확인 메서드
  Future<bool> checkEmailExists(String email) async {
    try {
      // 이메일로 사용자 정보 검색
      User? existingUser = await UserHttp.findUserByEmail(email);
      if (existingUser != null && existingUser.u_email.isNotEmpty) {
        // 이메일이 존재하는 경우 true 반환
        return true;
      } else {
        // 이메일이 존재하지 않는 경우 false 반환
        return false;
      }
    } catch (e) {
      throw Exception('이메일 중복 확인 중 오류 발생: $e');
    }
  }
}