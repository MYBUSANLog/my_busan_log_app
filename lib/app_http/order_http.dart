import 'dart:convert';

import 'package:busan_trip/vo/orderoption.dart';

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


  static Future<List<OrderOption>> fetchOrderOptionsByOrder(int o_idx) async {
    try {
      print('${apiUrl}/findOrderOption?o_idx=${o_idx}');
      var response = await http.get(Uri.parse('${apiUrl}/findOrderOption?o_idx=${o_idx}'));
      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes));
        List<OrderOption> list = [];
        for (var map in json['orderOptions']) {
          OrderOption orderOptions = OrderOption.fromJson(map);
          list.add(orderOptions);
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
      print('${apiUrl}/findOrderOption?o_idx=${o_idx}');
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

  static Future<String> generateOrderNumber() async {
    try {
      var response = await http.post(
        Uri.parse('$apiUrl/ordernumber'),
        headers: {'Content-Type': 'application/json'},
      );

      print(response.statusCode); // 응답 상태 코드 출력
      print(response.body); // 응답 본문 출력

      if (response.statusCode == 200) {
        return response.body; // 주문 번호 반환
      } else {
        throw Exception('주문 번호 생성 실패: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      return '주문 번호 생성 중 오류 발생';
    }
  }

    static Future<String> saveOrder(Order order, String orderNumber) async {
      print(orderNumber);
      print(jsonEncode(order.toJson()));
      var url = Uri.parse('$apiUrl/save?order_num=$orderNumber');
      print(jsonEncode(order.toJson()));
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

  // 주문 상태 업데이트 메서드
  static Future<String> updateOrderStatus(String orderNumber, String paymentMethod, String status) async {
    var url = Uri.parse('$apiUrl/updateStatus');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'order_num': orderNumber,
        'payment_method': paymentMethod,
        'status': status,
      }),
    );

    if (response.statusCode == 200) {
      return '주문 상태가 성공적으로 업데이트되었습니다.';
    } else {
      throw Exception('주문 상태 업데이트 실패: ${response.body}');
    }
  }
}