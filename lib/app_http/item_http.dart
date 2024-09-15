import 'dart:convert';

import '../vo/item.dart';
import 'package:http/http.dart' as http;

class ItemHttp {
  static const String apiUrl = 'http://13.125.57.206:8080/my_busan_log/api/item';

  static Future<List<Item>> fetchAllSortBy(String sortBy) async {
    var url = await http.get(Uri.parse('${apiUrl}/findItems?sortBy=$sortBy&start=0&count=10'));
    var mapList = jsonDecode(utf8.decode(url.bodyBytes));

    List<Item> list = [];

    for(int i=0;i<mapList.length;i++){
      var map = mapList[i];
      Item item = Item.fromJson(map);
      list.add(item);
    }

    print(list);
    return list;
  }

  static Future<List<Item>> fetchAll() async {
    var url = await http.get(Uri.parse('${apiUrl}/all'));
    var mapList = jsonDecode(utf8.decode(url.bodyBytes));

    List<Item> list = [];

    for(int i=0;i<mapList.length;i++){
      var map = mapList[i];
      Item item = Item.fromJson(map);
      list.add(item);
    }

    print(list);
    return list;
  }

  static Future<List<Item>> fetch6HotItems() async {
    var url = await http.get(Uri.parse('${apiUrl}/findItems?sortBy=oldest&start=0&count=6'));
    var mapList = jsonDecode(utf8.decode(url.bodyBytes));

    List<Item> list = [];

    for(int i=0;i<mapList.length;i++){
      var map = mapList[i];
      Item item = Item.fromJson(map);
      list.add(item);
    }

    print(list);
    return list;
  }

  static Future<List<Item>> fetch6NewItems() async {
    var url = await http.get(Uri.parse('${apiUrl}/findItems?sortBy=latest&start=0&count=6'));
    var mapList = jsonDecode(utf8.decode(url.bodyBytes));

    List<Item> list = [];

    for(int i=0;i<mapList.length;i++){
      var map = mapList[i];
      Item item = Item.fromJson(map);
      list.add(item);
    }

    print(list);
    return list;
  }

  //c_type으로 데이터 받아오기
  static Future<List<Item>> fetchCtype( int c_type, String sortBy, int start, int count) async {
    var url = await http.get(Uri.parse('${apiUrl}/findByCtype?c_type=$c_type&sortBy=$sortBy&start=$start&count=$count'));
    var mapList = jsonDecode(utf8.decode(url.bodyBytes));

    List<Item> list = [];

    for(int i=0;i<mapList.length;i++){
      var map = mapList[i];
      Item item = Item.fromJson(map);
      list.add(item);
    }

    print(list);
    return list;
  }

  //무료 데이터 받아오기
  static Future<List<Item>> fetchFree( String sortBy, int start, int count) async {
    var url = await http.get(Uri.parse('${apiUrl}_free/findByFree?sortBy=$sortBy&start=$start&count=$count'));
    var mapList = jsonDecode(utf8.decode(url.bodyBytes));

    List<Item> list = [];

    for(int i=0;i<mapList.length;i++){
      var map = mapList[i];
      Item item = Item.fromJson(map);
      list.add(item);
    }

    print(list);
    return list;
  }

  // 아이템 개수를 받아오는 함수
  static Future<int> fetchNum(int c_type) async {
    try {
      // 리뷰 개수를 가져오는 API 엔드포인트로 요청
      var response = await http.get(Uri.parse('${apiUrl}/findCtypeCount?c_type=${c_type}'));

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