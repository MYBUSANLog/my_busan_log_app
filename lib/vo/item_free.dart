class Item_free {
  int i_idx; // 상품 idx
  int s_idx; // 상점 idx
  String i_name; // 상품 이름
  String i_image; // 상품 이미지
  String i_content; // 상품 설명
  String i_address; // 상품 주소
  String operation_house; // 상품 운영일자
  String i_free; // 상점 이름

  Item_free({
    this.i_idx=0,
    this.s_idx=0,
    this.i_name='',
    this.i_image='',
    this.i_content='',
    this.i_address='',
    this.operation_house='',
    this.i_free='',
  });

  factory Item_free.fromJson(Map<String, dynamic> json){
    return Item_free(
      i_idx: json['i_idx'],
      s_idx: json['s_idx'],
      i_name: json['i_name'],
      i_image: json['i_image'],
      i_content: json['i_content'],
      i_address: json['i_address'],
      operation_house: json['operation_house'],
      i_free: json['i_free']??'',
    );
  }
}