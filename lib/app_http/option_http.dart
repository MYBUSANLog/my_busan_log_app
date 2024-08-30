import 'dart:convert';

import '../vo/option.dart';
import 'package:http/http.dart' as http;

class OptionHttp {

  static const String apiUrl = 'http://13.125.57.206:8080/my_busan_log/api/option';

  static Future<List<Option>> fetchOptions(int i_idx) async {
    var url = await http.get(Uri.parse('${apiUrl}/findByIIdx?i_idx=$i_idx'));
    var mapList = jsonDecode(utf8.decode(url.bodyBytes));

    List<Option> list = [];

    for(int i = 0; i < mapList.length; i++) {
      var map = mapList[i];
      Option option = Option.fromJson(map);
      list.add(option);
    }

    print(list);
    return list;
  }
}