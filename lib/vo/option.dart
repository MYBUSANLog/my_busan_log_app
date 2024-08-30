class Option {
  int op_idx;
  int i_idx;
  String op_name;
  int op_price;

  Option({
    this.op_idx=0,
    this.i_idx=0,
    this.op_name='',
    this.op_price=0,
  });

  factory Option.fromJson(Map<String, dynamic> json){
    return Option(
      op_idx: json['op_idx'],
      i_idx: json['i_idx'],
      op_name: json['op_name'],
      op_price: json['op_price'],
    );
  }
}