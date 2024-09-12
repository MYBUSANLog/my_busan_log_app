import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class MyMap extends ChangeNotifier {
  final TAG = "MYBUSANLOG";
  final NCameraPosition _mapPosition = const NCameraPosition(
    target: NLatLng(37.5666805, 126.9784147),
    zoom: 15,
  );

  NCameraPosition get mapPosition => _mapPosition;

  NaverMapController? _controller;

  final List<NMarker> _markers = [];
  List<NMarker> get markers => _markers;

  // NaverMapController 초기화
  void setController(NaverMapController controller) {
    _controller = controller;
  }

  Future<void> addMarker() async {
    log("$TAG : addMarker");

    if (_controller != null) {
      NCameraPosition currentCameraPosition = await _controller!.getCameraPosition();
      log("$TAG : Pos $currentCameraPosition");

      final marker = NMarker(
        id: _markers.length.toString(),
        position: currentCameraPosition.target,
      );

      _markers.add(marker);
    }

    notifyListeners();
  }

}