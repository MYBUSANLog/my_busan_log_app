import 'package:flutter/material.dart';
import '../app_http/order_http.dart';
import '../vo/order.dart';

class OrderModel extends ChangeNotifier {
  List<Order> orders = [];
  List<Order> orderdetails = [];

  Future<void> setItems(int u_idx) async {
    try {
      orders = await OrderHttp.fetchAll(u_idx);
      print("Orders loaded: $orders"); // Debugging
    } catch (e) {
      print('Error loading orders: $e');
      orders = []; // Handle error by setting empty list
    }
    notifyListeners();
  }

  Future<void> setOptions(int o_idx) async {
    try {
      orderdetails = await OrderHttp.fetchDetail(o_idx);
      print("Orders loaded: $orderdetails"); // Debugging
    } catch (e) {
      print('Error loading orders: $e');
      orderdetails = []; // Handle error by setting empty list
    }
    notifyListeners();
  }
}