import 'dart:convert';

import '../vo/order.dart';
import 'package:http/http.dart' as http;

class OrderHttp {
  static const String apiUrl = 'http://13.125.57.206:8080/my_busan_log/api/order';

  static Future<List<Order>> fetchAll(int u_idx) async {
    try {
      var response = await http.get(Uri.parse('${apiUrl}/findByUIdx?u_idx=${u_idx}'));
      if (response.statusCode == 200) {
        var mapList = jsonDecode(utf8.decode(response.bodyBytes)) as List;
        List<Order> list = [];
        for (var map in mapList) {
          Order item = Order.fromJson(map);
          list.add(item);
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

  static Future<List<Order>> fetchDetail(int o_idx) async {
    try {
      var response = await http.get(Uri.parse('${apiUrl}/findOrderOption?o_idx=${o_idx}'));
      if (response.statusCode == 200) {
        var mapList = jsonDecode(utf8.decode(response.bodyBytes)) as List;
        List<Order> list = [];
        for (var map in mapList) {
          Order item = Order.fromJson(map);
          list.add(item);
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

  static Future<String> saveOrder(Order order) async {
    // Order order = [
    //   's_idx': order.s_idx.toString(),
    //   'u_idx': order.u_idx.toString(),
    //   'i_idx': order.i_idx.toString(),
    //   'o_name': order.o_name.toString(),
    //   'o_email': order.o_email.toString(),
    //   'o_birth': order.o_birth.toString(),
    //   'o_p_number': order.o_p_number.toString(),
    //   'use_day': order.use_day.toString(),
    //   'payment_method': order.payment_method.toString(),
    //   'total_price': order.total_price.toString(),
    //   'status': '결제완료'.toString(),
    // ];
    var url = Uri.parse('$apiUrl/save');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(order.toJson()),
    );

    print(response.statusCode); // 응답 상태 코드 출력
    print(response.body); // 응답 본문 출력

    if (response.statusCode == 200) {
      return '주문이 성공적으로 저장되었습니다.';
    } else {
      throw Exception('주문 저장 실패: ${response.body}');
    }
  }
}