import 'dart:io';

class Review {
  int r_idx;
  int u_idx;
  int o_idx;
  int i_idx;
  int s_idx;
  String i_name;
  String i_image;
  String s_name;
  double r_score;
  String r_title;
  String r_img_url;
  String r_content;
  String created_date;
  List<String> img_url;
  String u_name;
  String u_nick;
  String u_img_url;

  Review({
    this.r_idx=0,
    this.u_idx=0,
    this.o_idx=0,
    this.i_idx=0,
    this.i_name='',
    this.i_image='',
    this.s_idx=0,
    this.s_name='',
    this.r_score=0.0,
    this.r_title='',
    this.r_img_url='',
    this.r_content='',
    this.created_date='',
    this.img_url = const [],
    this.u_name='',
    this.u_nick='',
    this.u_img_url='',
  });

  factory Review.fromJson(Map<String, dynamic> json) {

    // 이미지 객체 리스트에서 img_url 값만 추출하여 리스트로 저장
    List<String> images = [];
    if (json['images'] != null) {
      // 'images' 필드가 있을 경우 각 이미지 객체에서 'img_url'만 추출
      images = List<String>.from(json['images'].map((img) => img['img_url'].toString()));
    }

    return Review(
      r_idx: json['r_idx']??0,
      u_idx: json['u_idx']??0,
      o_idx: json['o_idx']??0,
      i_idx: json['i_idx']??0,
      s_idx: json['s_idx']??0,
      i_name: json['i_name']??'',
      i_image: json['i_image']??'',
      s_name: json['s_name']??'',
      r_score: json['r_score']??0.0,
      r_title: json['r_title']??'',
      r_img_url: json['r_img_url']??'',
      r_content: json['r_content']??'',
      created_date: json['created_date']??'',
      u_name: json['u_name']??'',
      u_nick: json['u_nick']??'',
      u_img_url: json['u_img_url']??'',
      img_url: images,  // 추출한 이미지 URL 리스트를 할당
      //todo img_url: json['img_url'] != null ? List<String>.from(json['img_url']) : [],
    );
  }
}