import 'dart:convert';

import 'package:busan_trip/vo/review.dart';
import 'package:http/http.dart' as http;

class ReviewHttp {
  static const String apiUrl = 'http://13.125.57.206:8080/my_busan_log/api/review';

  static Future<List<Review>> fetchAllReviews(int start, int count) async {
    var url = await http.get(Uri.parse('${apiUrl}/all?sortBy=oldest&start=$start&count=$count'));
    var mapList = jsonDecode(utf8.decode(url.bodyBytes));

    List<Review> list = [];

    for(int i=0;i<mapList.length;i++){
      var map = mapList[i];
      Review review = Review.fromJson(map);
      list.add(review);
    }

    print(list);
    return list;
  }

  // static Future<List<Review>> fetchAllReviews() async {
  //   var url = await http.get(Uri.parse('${apiUrl}/all?sortBy=latest'));
  //   var mapList = jsonDecode(utf8.decode(url.bodyBytes));
  //
  //   List<Review> list = [];
  //
  //   for(int i=0;i<mapList.length;i++){
  //     var map = mapList[i];
  //     Review review = Review.fromJson(map);
  //     list.add(review);
  //   }
  //
  //   print(list);
  //   return list;
  // }

  static Future<List<Review>> fetchMyReviewAll(int u_idx) async {
    try {
      var response = await http.get(Uri.parse('${apiUrl}/findByUIdx?u_idx=${u_idx}'));
      if (response.statusCode == 200) {
        var mapList = jsonDecode(utf8.decode(response.bodyBytes)) as List;
        List<Review> list = [];
        for (var map in mapList) {
          Review review = Review.fromJson(map);
          list.add(review);
        }
        print(list); // For debugging
        return list;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  static Future<Review> writeReview(Review review) async {
    print('1234');
    print({
      'u_idx': review.u_idx.toString(),
      'o_idx': review.o_idx.toString(),
      'i_idx': review.i_idx.toString(),
      's_idx': review.s_idx.toString(),
      'r_score': review.r_score.toString(),
      'r_title': review.r_title.toString(),
      'img_url': review.img_url,
      'r_content': review.r_content.toString(),
    });

    var uri = Uri.parse('$apiUrl/save').replace(queryParameters: {
      'u_idx': review.u_idx.toString(),
      'o_idx': review.o_idx.toString(),
      'i_idx': review.i_idx.toString(),
      's_idx': review.s_idx.toString(),
      'r_score': review.r_score.toString(),
      'r_title': review.r_title.toString(),
      'img_url': review.img_url,
      'r_content': review.r_content.toString(),
    });
    var response = await http.post(uri);

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return Review.fromJson(jsonDecode(response.body));
    } else {
      return Review();
    }

  }
}