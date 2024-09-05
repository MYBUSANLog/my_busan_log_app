class Order {
  int o_idx;
  int s_idx;
  int u_idx;
  int i_idx;
  String i_name;
  String i_image;
  String order_num;
  String o_name;
  String o_email;
  String o_birth;
  String o_p_number;
  String use_day;
  String payment_method;
  int total_price;
  String status;
  String created_date;

  Order({
    this.o_idx=0,
    this.s_idx=0,
    this.u_idx=0,
    this.i_idx=0,
    this.i_name='',
    this.i_image='',
    this.order_num='',
    this.o_name='',
    this.o_email='',
    this.o_birth='',
    this.o_p_number='',
    this.use_day='',
    this.payment_method='',
    this.total_price=0,
    this.status='',
    this.created_date='',
  });

  factory Order.fromJson(Map<String, dynamic> json){
    return Order(
      o_idx: json['o_idx']??0,
      s_idx: json['s_idx']??0,
      u_idx: json['u_idx']??0,
      i_idx: json['i_idx']??0,
      i_name: json['i_name']??'',
      order_num: json['order_num']??'',
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
}