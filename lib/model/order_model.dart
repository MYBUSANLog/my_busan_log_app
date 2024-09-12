import 'package:busan_trip/vo/orderoption.dart';
import 'package:flutter/material.dart';
import '../app_http/order_http.dart';
import '../vo/order.dart';

class OrderModel extends ChangeNotifier {
  List<Order> orders = [];
  List<Order> orderdetails = [];
  List<OrderOption> myOrderOptions = [];


  
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


  void setMyOrderOptions(int orderIdx) async{
    myOrderOptions = await OrderHttp.fetchOrderOptionsByOrder(orderIdx);
    notifyListeners();
  }

  // 주문 정보를 업데이트하는 메소드
  Future<void> updateOrder(int o_idx, Order order) async {
    try {
      String result = await OrderHttp.updateOrder(o_idx, order);
      print(result); // 주문 업데이트 결과 출력
    } catch (e) {
      print('Error updating order: $e');
    }
    notifyListeners();
  }
}