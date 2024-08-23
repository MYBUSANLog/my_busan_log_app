import 'package:busan_trip/enums/enum_sort_by.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sortFilterProvider = StateProvider<EnumSortBy>((ref)=> EnumSortBy.recommended);