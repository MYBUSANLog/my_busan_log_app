class User {
  int u_idx;
  String login_provider;
  String u_email;
  String u_pw;
  String u_name;
  String u_nick;
  String u_img_url;
  String u_birth;
  String u_p_number;
  String u_address;
  int trip_preference;
  String business_license;

  User({
    this.u_idx=0,
    this.login_provider='',
    this.u_email='',
    this.u_pw='',
    this.u_name='',
    this.u_nick='',
    this.u_img_url='',
    this.u_birth='',
    this.u_p_number='',
    this.u_address='',
    this.trip_preference=0,
    this.business_license=' ',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User (
      u_idx: json['u_idx'] ?? 0,
      login_provider: json['login_provider'],
      u_email: json['u_email'],
      u_pw: json['u_pw'],
      u_name: json['u_name'],
      u_nick: json['u_nick'],
      u_img_url: json['u_img_url'],
      u_birth: json['u_birth'],
      u_p_number: json['u_p_number'],
      u_address: json['u_address'],
      trip_preference: json['trip_preference']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'u_idx': u_idx,
      'login_provider': login_provider,
      'u_email': u_email,
      'u_pw': u_pw,
      'u_name': u_name,
      'u_nick': u_nick,
      'u_img_url': u_img_url,
      'u_birth': u_birth,
      'u_p_number': u_p_number,
      'u_address': u_address,
      'trip_preference': trip_preference,
    };
  }
}