import 'package:busan_trip/vo/orderoption.dart';

class Order {
  int o_idx;
  int s_idx;
  int u_idx;
  int i_idx;
  String s_name;
  String i_name;
  String i_image;
  String order_num;
  List<OrderOption> orderOptions;
  String o_name;
  String o_email;
  String o_birth;
  String o_p_number;
  String use_day;
  String payment_method;
  int total_price;
  String status;
  String created_date;

  dynamic orderOptionsMapList;

  Order({
    this.o_idx=0,
    this.s_idx=0,
    this.u_idx=0,
    this.i_idx=0,
    this.s_name='',
    this.i_name='',
    this.i_image='',
    this.order_num='',
    List<OrderOption>? orderOptions,
    this.o_name='',
    this.o_email='',
    this.o_birth='',
    this.o_p_number='',
    this.use_day='',
    this.payment_method='',
    this.total_price=0,
    this.status='',
    this.created_date='',
    this.orderOptionsMapList=null
  }) : orderOptions = orderOptions ?? [];

  factory Order.fromJson(Map<String, dynamic> json){
    return Order(
      o_idx: json['o_idx']??0,
      s_idx: json['s_idx']??0,
      u_idx: json['u_idx']??0,
      i_idx: json['i_idx']??0,
      s_name: json['s_name']??'',
      i_name: json['i_name']??'',
      i_image: json['i_image']??'',
      order_num: json['order_num']??'',
      orderOptions: (json['orderOptions'] as List<dynamic>?)
          ?.map((item) => OrderOption.fromJson(item))
          .toList() ?? [],
      o_name: json['o_name']??'',
      o_email: json['o_email']??'',
      o_birth: json['o_birth']??'',
      o_p_number: json['o_p_number']??'',
      use_day: json['use_day']??'',
      payment_method: json['payment_method']??'',
      total_price: json['total_price']??0,
      status: json['status']??'',
      created_date: json['created_date']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      's_idx': s_idx,
      'u_idx': u_idx,
      'i_idx': i_idx,
      'o_name': o_name,
      'o_email': o_email,
      'o_birth': o_birth,
      'o_p_number': o_p_number,
      'use_day': use_day,
      'payment_method': payment_method,
      'total_price': total_price,
      'status': status,
      'orderOptions':orderOptionsMapList
    };
  }
}
