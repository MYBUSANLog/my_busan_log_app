// lib/http/heart_list_http.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../vo/heart_list.dart';

class HeartListHttp {
  static const String apiUrl = 'http://13.125.57.206:8080/my_busan_log/api/wish';

  static Future<List<HeartList>> fetchAll(int u_idx) async {
    final url = Uri.parse('$apiUrl/selectWishlistWithItem?u_idx=$u_idx');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var mapList = jsonDecode(utf8.decode(response.bodyBytes));

        List<HeartList> list = [];
        for (var map in mapList) {
          HeartList item = HeartList.fromJson(map);
          list.add(item);
        }

        print(list); // Debugging
        return list;
      } else {
        throw Exception('Failed to load heart list. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching heart list: $e');
      throw e;
    }
  }

  static Future<void> deleteWish(int wish_idx) async {
    final url = Uri.parse('$apiUrl/deleteWish?wish_idx=$wish_idx');

    try {
      final response = await http.delete(url);

      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Wish deleted successfully');
      } else {
        throw Exception('Failed to delete wish. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting wish: $e');
      throw e;
    }
  }

  // 찜목록 추가
  static Future<void> addWish(int u_idx, int i_idx) async {
    final url = Uri.parse('$apiUrl/addWish');
    final response = await http.post(
      url,
      body: {
        'u_idx': u_idx.toString(),
        'i_idx': i_idx.toString(),
      },
    );

    if (response.statusCode == 200) {
      print('Wish added successfully');
    } else {
      throw Exception('Failed to add wish. Status code: ${response.statusCode}');
    }
  }
}
