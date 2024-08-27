import 'package:bootpay/model/item.dart';

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
  String i_day;

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
    );
  }
}