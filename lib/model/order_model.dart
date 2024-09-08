import 'package:busan_trip/vo/orderoption.dart';
import 'package:flutter/material.dart';
import '../app_http/order_http.dart';
import '../vo/order.dart';

class OrderModel extends ChangeNotifier {
  List<Order> orders = [];
  List<OrderOption> _orderDetails = [];

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

  List<OrderOption> get orderDetails => _orderDetails;

  Future<void> fetchOrderDetails(int o_idx) async {
    try {
      Order order = await OrderHttp.fetchOrderOptions(o_idx);
      _orderDetails = order.orderOptions;
      notifyListeners();
    } catch (e) {
      print('Error fetching order details: $e');
    }
  }

  // Future<void> setOptions(int o_idx) async {
  //   try {
  //     orderdetails = await OrderHttp.fetchDetail(o_idx);
  //     print("Orders loaded: $orderdetails"); // Debugging
  //   } catch (e) {
  //     print('Error loading orders: $e');
  //     orderdetails = []; // Handle error by setting empty list
  //   }
  //   notifyListeners();
  // }
}