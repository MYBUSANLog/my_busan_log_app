class ProfileAlterModel {
  String profileImage;
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

  void setProfileImage(String path) {
    profileImage = path;
  }
}
