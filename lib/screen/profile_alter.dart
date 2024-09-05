import 'package:flutter/material.dart';
import 'package:busan_trip/model/profile_alter_model.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../app_util/img_util.dart';
import '../model/user_model.dart';
import '../vo/user.dart';

class ProfileAlterScreen extends StatefulWidget {
  User user;

  ProfileAlterScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileAlterScreenState createState() => _ProfileAlterScreenState();
}

class _ProfileAlterScreenState extends State<ProfileAlterScreen> {

  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController nicknameController;
  late TextEditingController birthdateController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressController;
  Uint8List? previewImgBytes;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.user.u_email);
    nameController = TextEditingController(text: widget.user.u_name);
    nicknameController = TextEditingController(text: widget.user.u_nick);
    birthdateController = TextEditingController(text: widget.user.u_birth);
    phoneNumberController = TextEditingController(text: widget.user.u_p_number);
    addressController = TextEditingController(text: widget.user.u_address);
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);

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
                    backgroundImage: userModel.loggedInUser.u_img_url != null
                        ? NetworkImage(userModel.loggedInUser.u_img_url!)
                        : AssetImage('assets/images/default_profile.jpg') as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true; // 로딩 시작
                        });

                        final picker = ImagePicker();
                        XFile? imgFile = await picker.pickImage(source: ImageSource.gallery);
                        if(imgFile != null) {
                          try {
                            Uint8List bytes =
                            await ImgUtil.convertResizedUint8List(
                                xFile: imgFile);
                            print("선택한 이미지의 데이터 크기: ${bytes.lengthInBytes} bytes");
                            setState(() {
                              previewImgBytes = bytes;
                              isLoading = false; // 로딩 끝
                            });
                          } catch (e) {
                            print("이미지 데이터 크기 오류 발생! 선택한 이미지의 데이터 크기: ${await imgFile.length()} bytes");
                            print("오류: $e");
                            setState(() {
                              isLoading = false; // 오류 발생 시 로딩 끝
                            });
                          }
                        } else {
                          setState(() {
                            isLoading = false; // 사진 선택 안 했을 때 로딩 끝
                          });
                        }
                      },
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
            buildProfileItem('이메일', emailController, TextInputType.emailAddress),
            buildProfileItem('이름', nameController),
            buildProfileItem('닉네임', nicknameController),
            buildProfileItem('생년월일', birthdateController),
            buildProfileItem('전화번호', phoneNumberController, TextInputType.phone),
            buildProfileItem('주소', addressController),
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
}
