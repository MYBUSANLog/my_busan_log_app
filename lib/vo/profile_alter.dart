class ProfileAlterModel {
  String profileImage;  // 경로 문자열로 변경
  final int age;
  final String name;
  final String nickname;
  final String phoneNumber;
  final String address;
  final String email;
  final String birthdate;

  ProfileAlterModel({
    required this.profileImage,
    required this.age,
    required this.name,
    required this.nickname,
    required this.phoneNumber,
    required this.address,
    required this.email,
    required this.birthdate,
  });

  void setProfileImage(String imagePath) {
    profileImage = imagePath;
  }
}