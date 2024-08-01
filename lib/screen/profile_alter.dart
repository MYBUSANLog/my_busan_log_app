import 'package:flutter/material.dart';
import 'package:busan_trip/model/profile_alter_model.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAlterScreen extends StatefulWidget {
  @override
  _ProfileAlterScreenState createState() => _ProfileAlterScreenState();
}

class _ProfileAlterScreenState extends State<ProfileAlterScreen> {
  final ProfileAlterModel profile = ProfileAlterModel(
    profileImage: 'https://example.com/your_profile_image.jpg',
    age: 25,
    name: 'John Doe',
    nickname: 'Johnny',
    phoneNumber: '010-1234-5678',
    address: '123 Main St, Seoul, Korea',
    email: 'john.doe@example.com',
    birthdate: '1995-05-15',
    gender: '남자',
    occupation: 'Software Developer',
    bio: 'Hello, I am John Doe.',
  );

  late TextEditingController nameController;
  late TextEditingController nicknameController;
  late TextEditingController ageController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressController;
  late TextEditingController emailController;
  late TextEditingController birthdateController;
  late TextEditingController occupationController;
  late TextEditingController bioController;

  String selectedGender = '남자';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: profile.name);
    nicknameController = TextEditingController(text: profile.nickname);
    ageController = TextEditingController(text: profile.age.toString());
    phoneNumberController = TextEditingController(text: profile.phoneNumber);
    addressController = TextEditingController(text: profile.address);
    emailController = TextEditingController(text: profile.email);
    birthdateController = TextEditingController(text: profile.birthdate);
    occupationController = TextEditingController(text: profile.occupation);
    bioController = TextEditingController(text: profile.bio);
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profile.setProfileImage(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 변경', style: TextStyle(
          fontFamily: 'NotoSansKR',
          fontWeight: FontWeight.w500,
          fontSize: 23,
          color: Colors.black,
        )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(profile.profileImage),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.edit, color: Colors.black, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            buildProfileItem('이름', nameController),
            buildProfileItem('닉네임', nicknameController),
            buildProfileItem('나이', ageController, TextInputType.number),
            buildProfileItem('전화번호', phoneNumberController, TextInputType.phone),
            buildProfileItem('주소', addressController),
            buildProfileItem('이메일', emailController, TextInputType.emailAddress),
            buildProfileItem('생년월일', birthdateController),
            buildDropdownField('성별', selectedGender, ['남자', '여자']),
            buildProfileItem('직업', occupationController),
            buildProfileItem('자기소개', bioController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 프로필 저장 로직
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,  // 파란색 배경
              ),
              child: Text('수정 하기', style: TextStyle(
                fontFamily: 'NotoSansKR',
                color: Colors.white,  // 글씨 색을 흰색으로
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileItem(String labelText, TextEditingController controller, [TextInputType keyboardType = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontFamily: 'NotoSansKR',
            fontSize: 14,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.chevron_right, color: Colors.grey),
        ),
        style: TextStyle(
          fontFamily: 'NotoSansKR',
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildDropdownField(String labelText, String value, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontFamily: 'NotoSansKR',
            fontSize: 14,
            color: Colors.grey,
          ),
          border: InputBorder.none,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isDense: true,
            onChanged: (newValue) {
              setState(() {
                selectedGender = newValue!;
              });
            },
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(fontFamily: 'NotoSansKR')),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
