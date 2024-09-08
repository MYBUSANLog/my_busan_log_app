class OrderOption {
  int order_option_idx;
  int i_idx;
  int o_idx;
  int op_idx;
  int op_quantity;
  int op_price;
  String op_name;

  OrderOption({
    this.order_option_idx=0,
    this.i_idx=0,
    this.o_idx=0,
    this.op_idx=0,
    this.op_quantity=0,
    this.op_price=0,
    this.op_name='',
  });

  factory OrderOption.fromJson(Map<String, dynamic> json) {
    return OrderOption(
      order_option_idx: json['order_option_idx']??0,
      i_idx: json['i_idx']??0,
      o_idx: json['o_idx']??0,
      op_idx: json['op_idx']??0,
      op_quantity: json['op_quantity']??0,
      op_price: json['op_price']??0,
      op_name: json['op_name']??'',
    );
  }
}