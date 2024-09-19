import 'dart:convert';

import 'package:busan_trip/vo/review.dart';
import 'package:http/http.dart' as http;

class ReviewHttp {
  static const String apiUrl = 'http://13.125.57.206:8080/my_busan_log/api/review';

  static Future<List<Review>> fetchAllReviews(int start, int count) async {
    var url = await http.get(Uri.parse('${apiUrl}/all?sortBy=latest&start=$start&count=$count'));
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

  //데이터 받아오기
  static Future<List<Review>> fetchMyReviewAll(int u_idx) async {
    try {
      var response = await http.get(Uri.parse('${apiUrl}/findUAll?u_idx=${u_idx}'));
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

  // 리뷰 개수를 받아오는 함수
  static Future<int> fetchMyReviewNum(int u_idx) async {
    try {
      // 리뷰 개수를 가져오는 API 엔드포인트로 요청
      var response = await http.get(Uri.parse('${apiUrl}/countByUIdx?u_idx=${u_idx}'));

      if (response.statusCode == 200) {
        // 서버가 단일 숫자로 리뷰 개수를 반환한다고 가정
        var reviewCount = jsonDecode(response.body); // 리뷰 개수를 파싱 (JSON으로 감싸져 있는 경우)
        return reviewCount as int; // int로 형변환
      } else {
        throw Exception('Failed to load review count');
      }
    } catch (e) {
      print('Error: $e');
      return 0; // 에러가 발생하면 기본값 0 반환
    }
  }

  //데이터 받아오기
  static Future<List<Review>> fetchItemReviewAll(int i_idx) async {
    try {
      var response = await http.get(Uri.parse('${apiUrl}/findIAll?i_idx=${i_idx}'));
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

  //데이터 받아오기
  static Future<int> fetchItemReviewNum(int i_idx) async {
    try {
      var response = await http.get(Uri.parse('${apiUrl}/countByIIdx?i_idx=${i_idx}'));
      if (response.statusCode == 200) {
        // 서버가 단일 숫자로 리뷰 개수를 반환한다고 가정
        var reviewCount = jsonDecode(response.body); // 리뷰 개수를 파싱 (JSON으로 감싸져 있는 경우)
        return reviewCount as int; // int로 형변환
      } else {
        throw Exception('Failed to load review count');
      }
    } catch (e) {
      print('Error: $e');
      return 0; // 에러가 발생하면 기본값 0 반환
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

  //u_idx  로 받아오기
  static Future<Review> userReview(Review review) async {
    print('1234');
    print({
      'u_idx': review.u_idx.toString(),
      'o_idx': review.o_idx.toString(),
      'i_idx': review.i_idx.toString(),
      's_idx': review.s_idx.toString(),
      'r_score': review.r_score.toString(),
      'r_title': review.r_title.toString(),
      'img_url': review.img_url.toString(),
      'r_content': review.r_content.toString(),
      'u_name': review.u_name.toString(),
      'u_nick': review.u_nick.toString(),
      'u_img_url': review.u_img_url.toString(),
    });

    var uri = Uri.parse('$apiUrl/findUAll').replace(queryParameters: {
      'u_idx': review.u_idx.toString(),
      'o_idx': review.o_idx.toString(),
      'i_idx': review.i_idx.toString(),
      's_idx': review.s_idx.toString(),
      'r_score': review.r_score.toString(),
      'r_title': review.r_title.toString(),
      'img_url': review.img_url.toString(),
      'r_content': review.r_content.toString(),
      'u_name': review.u_name.toString(),
      'u_nick': review.u_nick.toString(),
      'u_img_url': review.u_img_url.toString(),
    });
    var response = await http.get(uri);

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return Review.fromJson(jsonDecode(response.body));
    } else {
      return Review();
    }

  }


  // 아이템 리뷰를 받아오는 메서드
  static Future<Review> itemReview(Review review) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/findIAll').replace(queryParameters: {
          'u_idx': review.u_idx.toString(),
          'o_idx': review.o_idx.toString(),
          'i_idx': review.i_idx.toString(),
          's_idx': review.s_idx.toString(),
          'r_score': review.r_score.toString(),
          'r_title': review.r_title.toString(),
          'img_url': review.img_url.toString(),
          'r_content': review.r_content.toString(),
          'u_name': review.u_name.toString(),
          'u_nick': review.u_nick.toString(),
          'u_img_url': review.u_img_url.toString(),
        }),
      );
      if (response.statusCode == 200) {
        return Review.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load item review');
      }
    } catch (e) {
      print('Error: $e');
      return Review(); // 실패 시 빈 Review 객체 반환
    }
  }
}