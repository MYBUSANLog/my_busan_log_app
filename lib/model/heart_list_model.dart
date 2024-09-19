// lib/models/heart_list_model.dart
import 'package:busan_trip/app_http/heart_list_http.dart';
import 'package:flutter/material.dart';
import '../vo/heart_list.dart';

class HeartListModel extends ChangeNotifier {
  List<HeartList> heartLists = [];

  Future<void> setHeartLists(int u_idx) async {
    try {
      heartLists = await HeartListHttp.fetchAll(u_idx);
      print("HeartLists loaded: $heartLists");
    } catch (e) {
      print('Error loading heart lists: $e');
      heartLists = [];
    }
    notifyListeners();
  }

  //찜목록 추가
  Future<void> addHeart(int u_idx, int i_idx) async {
    try {
      await HeartListHttp.addWish(u_idx, i_idx);
      await setHeartLists(u_idx); // 찜 목록을 다시 로드
    } catch (e) {
      print('Error adding heart: $e');
    }
  }

  // 찜 목록에서 아이템 삭제 메서드 추가
  Future<void> deleteHeart(int wish_idx, int u_idx) async {
    try {
      await HeartListHttp.deleteWish(wish_idx);
      await setHeartLists(u_idx);
      notifyListeners();
    } catch (e) {
      print('Error deleting heart: $e');
    }
  }

}
