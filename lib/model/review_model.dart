import 'package:busan_trip/app_http/review_http.dart';
import 'package:flutter/cupertino.dart';

import '../vo/review.dart';

class ReviewModel extends ChangeNotifier {
  List<Review> reviews = [];
  Review writeReview = Review();
  List<Review> myReviews = [];



  Future<void> setAllReviews({required int start, required int count}) async{
    try {
      List<Review> newReviews = await ReviewHttp.fetchAllReviews(start, count);
      reviews.addAll(newReviews);
      notifyListeners();
    } catch (e) {
      // 오류 처리
    }
  }


  // Future<void> setAllReviews() async{
  //   reviews = await ReviewHttp.fetchAllReviews();
  //
  //   notifyListeners();
  // }

  Future<void> setMyReviews(int u_idx) async {
    try {
      myReviews = await ReviewHttp.fetchMyReviewAll(u_idx);
      print("Orders loaded: $myReviews"); // Debugging
    } catch (e) {
      print('Error loading orders: $e');
      myReviews = []; // Handle error by setting empty list
    }
    notifyListeners();
  }

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