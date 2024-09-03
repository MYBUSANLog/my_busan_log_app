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

    // var url = await http.get(Uri.parse('${apiUrl}/all'));
    // var mapList = jsonDecode(utf8.decode(url.bodyBytes));
    //
    // List<Order> list = [];
    //
    // for(int i=0;i<mapList.length;i++){
    //   var map = mapList[i];
    //   Order item = Order.fromJson(map);
    //   list.add(item);
    // }
    //
    // print(list);
    // return list;
  }
}