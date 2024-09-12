import 'dart:io';

class Review {
  int r_idx;
  int u_idx;
  int o_idx;
  int i_idx;
  int s_idx;
  String i_name;
  String s_name;
  double r_score;
  String r_title;
  String r_img_url;
  String r_content;
  String created_date;
  List<String> img_url;
  String u_img_url;
  String u_nick;

  Review({
    this.r_idx=0,
    this.u_idx=0,
    this.o_idx=0,
    this.i_idx=0,
    this.i_name='',
    this.s_idx=0,
    this.s_name='',
    this.r_score=0.0,
    this.r_title='',
    this.r_img_url='',
    this.r_content='',
    this.created_date='',
    this.img_url = const [],
    this.u_img_url='',
    this.u_nick=''
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      r_idx: json['r_idx']??0,
      u_idx: json['u_idx']??0,
      o_idx: json['o_idx']??0,
      i_idx: json['i_idx']??0,
      s_idx: json['s_idx']??0,
      i_name: json['i_name']??'',
      s_name: json['s_name']??'',
      r_score: json['r_score']??0.0,
      r_title: json['r_title']??'',
      r_img_url: json['r_img_url']??'',
      r_content: json['r_content']??'',
      created_date: json['created_date']??'',
      img_url: json['img_url'] != null ? List<String>.from(json['img_url']) : [],
      u_img_url: json['u_img_url']??'',
      u_nick: json['u_nick']??''
    );
  }
}