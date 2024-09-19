class ResItem {
  String res_name; // 상품 이름
  String res_image; // 상품 이미지
  String res_address; // 상품 주소
  String closed_days; // 상품 휴무일


  ResItem({
    this.res_name='',
    this.res_image='',
    this.res_address='',
    this.closed_days='',
  });

  factory ResItem.fromJson(Map<String, dynamic> json) {
    return ResItem(
      res_name: json['res_name'] ?? '',
      res_image: json['res_image'] ?? '',
      res_address: json['res_address'] ?? '',
      closed_days: json['closed_days'] ?? '',
    );
  }
}