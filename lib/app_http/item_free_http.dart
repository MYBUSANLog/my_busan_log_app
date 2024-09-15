import 'dart:convert';

import 'package:busan_trip/vo/item_free.dart';

import '../vo/item.dart';
import 'package:http/http.dart' as http;

class ItemFreeHttp {
  static const String apiUrl = 'http://13.125.57.206:8080/my_busan_log/api/item_free';

  //무료 데이터 받아오기
  static Future<List<Item_free>> fetchFree( String sortBy, int start, int count) async {
    var url = await http.get(Uri.parse('${apiUrl}/findByFree?sortBy=$sortBy&start=$start&count=$count'));
    var mapList = jsonDecode(utf8.decode(url.bodyBytes));

    List<Item_free> list = [];

    for(int i=0;i<mapList.length;i++){
      var map = mapList[i];
      Item_free item_free = Item_free.fromJson(map);
      list.add(item_free);
    }

    print(list);
    return list;
  }

  // 아이템 개수를 받아오는 함수
  static Future<int> fetchNum() async {
    try {
      // 리뷰 개수를 가져오는 API 엔드포인트로 요청
      var response = await http.get(Uri.parse('${apiUrl}/count'));

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

}

