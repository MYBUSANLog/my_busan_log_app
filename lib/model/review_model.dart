import 'package:busan_trip/app_http/review_http.dart';
import 'package:flutter/cupertino.dart';

import '../vo/review.dart';

class ReviewModel extends ChangeNotifier {
  Review writeReview = Review();

  Future<void> saveReview() async {
    try {
      Review registeredUser = await ReviewHttp.writeReview(writeReview);
      writeReview = registeredUser;
      notifyListeners();
    } catch (e) {
      throw Exception('회원가입 중 오류 발생: $e');
    }
  }
}