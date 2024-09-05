import 'dart:convert';

import 'package:busan_trip/vo/review.dart';
import 'package:http/http.dart' as http;

class ReviewHttp {
  static const String apiUrl = 'http://13.125.57.206:8080/my_busan_log/api/review';

  static Future<Review> writeReview(Review review) async {
    print('1234');
    print({
      'u_idx': review.u_idx.toString(),
      'o_idx': review.o_idx.toString(),
      'i_idx': review.i_idx.toString(),
      'r_score': review.r_score.toString(),
      'r_title': review.r_title.toString(),
      'r_img_url': review.r_img_url.toString(),
      'r_content': review.r_content.toString(),
    });

    var uri = Uri.parse('$apiUrl/save').replace(queryParameters: {
      'u_idx': review.u_idx.toString(),
      'o_idx': review.o_idx.toString(),
      'i_idx': review.i_idx.toString(),
      'r_score': review.r_score.toString(),
      'r_title': review.r_title.toString(),
      'r_img_url': review.r_img_url.toString(),
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