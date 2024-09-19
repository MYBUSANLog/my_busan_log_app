// lib/vo/heart_list.dart
import 'package:bootpay/model/item.dart';

class HeartList {
  int wish_idx;
  int u_idx;
  int i_idx;
  String modified_date;
  String created_date;
  String i_name;
  String i_image;
  int i_price;

  HeartList({
    this.wish_idx = 0,
    this.u_idx = 0,
    this.i_idx = 0,
    this.modified_date = '',
    this.created_date = '',
    this.i_name = '',
    this.i_image = '',
    this.i_price = 0
  });

  factory HeartList.fromJson(Map<String, dynamic> json) {
    return HeartList(
        wish_idx: json['wish_idx'],
        u_idx: json['u_idx'],
        i_idx: json['i_idx'],
        modified_date: json['modified_date'],
        created_date: json['created_date'],
        i_name: json['i_name'],
        i_image: json['i_image'],
        i_price: json['i_price']
    );
  }

  Item toItem() {
    return Item(
      i_idx: this.i_idx,
      s_idx: 0, // 상점 idx - 기본값 또는 실제 값을 설정
      c_type: 0, // 상품 타입 - 기본값 또는 실제 값을 설정
      i_name: this.i_name,
      i_image: this.i_image,
      i_price: this.i_price,
      i_content: '', // 상품 설명 - 기본값
      i_address: '', // 상품 주소 - 기본값
      operation_house: '', // 운영일자 - 기본값
      closed_days: '', // 휴무일 - 기본값
      i_stock: 0, // 재고수량 - 기본값
      i_sales_quantity: 0, // 판매수량 - 기본값
      ui_rank: 0, // 필수 필드
      s_img: '', // 상점 이미지 - 기본값
      s_name: '', // 상점 이름 - 기본값
      i_wishes: 0, // 누적 상품 좋아요 수 - 기본값
      averageScore: 0.0, // 평점 - 기본값
      review_count: 0, // 리뷰 갯수 - 기본값
    );
  }
}

class Item {
  int i_idx;
  int s_idx;
  int c_type;
  String i_name;
  String i_image;
  int i_price;
  String i_content;
  String i_address;
  String operation_house;
  String closed_days;
  int i_stock;
  int i_sales_quantity;
  int ui_rank;
  String s_img;
  String s_name;
  int i_wishes;
  double averageScore;
  int review_count;

  Item({
    this.i_idx = 0,
    this.s_idx = 0,
    this.c_type = 0,
    this.i_name = '',
    this.i_image = '',
    this.i_price = 0,
    this.i_content = '',
    this.i_address = '',
    this.operation_house = '',
    this.closed_days = '',
    this.i_stock = 0,
    this.i_sales_quantity = 0,
    required this.ui_rank,
    this.s_img = '',
    this.s_name = '',
    this.i_wishes = 0,
    this.averageScore = 0.0,
    this.review_count = 0,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      i_idx: json['i_idx'],
      s_idx: json['s_idx'],
      c_type: json['c_type'],
      i_name: json['i_name'],
      i_image: json['i_image'],
      i_price: json['i_price'],
      i_content: json['i_content'],
      i_address: json['i_address'],
      operation_house: json['operation_house'],
      closed_days: json['closed_days'],
      i_stock: json['i_stock'],
      i_sales_quantity: json['i_sales_quantity'],
      ui_rank: json['ui_rank'] ?? 0, // 기본값 처리
      s_img: json['s_img'] ?? '',
      s_name: json['s_name'] ?? '',
      i_wishes: json['i_wishes'] ?? 0,
      averageScore: json['average_score'] ?? 0.0,
      review_count: json['review_count'] ?? 0,
    );
  }
}
