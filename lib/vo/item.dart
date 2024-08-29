import 'package:bootpay/model/item.dart';

class Item {
  int i_idx; // 상품 idx
  int s_idx; // 상점 idx
  int c_type; // 상품 타입
  String i_name; // 상품 이름
  String i_image; // 상품 이미지
  int i_price; // 상품 가격
  String i_content; // 상품 설명
  String i_address; // 상품 주소
  String operation_house; // 상품 운영일자
  String closed_days; // 상품 휴무일
  int i_stock; // 상품 재고수량
  int i_sales_quantity; // 상품 판매수량
  String i_day; // 상품 이용일자
  int ui_rank;
  String s_img_url; // 상점 이미지
  String s_name; // 상점 이름
  int i_wishes; // 누적 상품 좋아요 수
  double averageScore; // 상품 평점
  int i_reviews; // 누적 리뷰 갯수

  Item({
    this.i_idx=0,
    this.s_idx=0,
    this.c_type=0,
    this.i_name='',
    this.i_image='',
    this.i_price=0,
    this.i_content='',
    this.i_address='',
    this.operation_house='',
    this.closed_days='',
    this.i_stock=0,
    this.i_sales_quantity=0,
    this.i_day='',
    required this.ui_rank,
    this.s_img_url='',
    this.s_name='',
    this.i_wishes=0,
    this.averageScore=0.0,
    this.i_reviews=0,
  });

  factory Item.fromJson(Map<String, dynamic> json){
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
      i_day: json['i_day'],
      ui_rank: 0,
      s_img_url: json['s_img_url']??'',
      s_name: json['s_name']??'',
      i_wishes: json['i_wishes']??0,
      averageScore: json['averageScore'],
      i_reviews: json['i_reviews']??0,
    );
  }
}