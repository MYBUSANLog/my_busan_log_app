class Store {
  int s_idx;
  int u_idx;
  String s_name;
  String s_address;
  String s_tel;
  String operation_house;
  String closed_days;
  String s_img;
  String s_content;
  int ui_rank;

  Store({
    this.s_idx=0,
    this.u_idx=0,
    this.s_name='',
    this.s_address='',
    this.s_tel='',
    this.operation_house='',
    this.closed_days='',
    this.s_img='',
    this.s_content='',
    required this.ui_rank
  });

  factory Store.fromJson(Map<String, dynamic> json){
    return Store(
      s_idx: json['s_idx'],
      u_idx: json['u_idx'],
      s_name: json['s_name'],
      s_address: json['s_address'],
      s_tel: json['s_tel'],
      operation_house: json['operation_house'],
      closed_days: json['closed_days'],
      s_img: json['s_img'],
      s_content: json['s_content'],
      ui_rank: 0,
    );
  }
}