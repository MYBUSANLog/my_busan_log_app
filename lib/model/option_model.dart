import 'package:flutter/material.dart';

import '../app_http/option_http.dart';
import '../vo/option.dart';

class OptionModel extends ChangeNotifier {
  List<Option> options = [];

  Future<void> setOptions(int i_idx) async {
    options = await OptionHttp.fetchOptions(i_idx);
    notifyListeners();
  }
}