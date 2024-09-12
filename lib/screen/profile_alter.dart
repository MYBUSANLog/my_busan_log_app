
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:daum_postcode_search/data_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../app_util/img_util.dart';
import '../model/user_model.dart';
import '../vo/user.dart';
import 'daumpostcodesearchexample.dart';

class ProfileAlterScreen extends StatefulWidget {

  ProfileAlterScreen({Key? key}) : super(key: key);

  @override
  _ProfileAlterScreenState createState() => _ProfileAlterScreenState();
}

class _ProfileAlterScreenState extends State<ProfileAlterScreen> {

  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController nicknameController;
  late TextEditingController birthdayController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  // Map<String, int> radioMap={'호캉스':1, '액티비티':2, '쇼핑':3, '상관없음':4};
  final storage = FirebaseStorage.instance;
  Uint8List? previewImgBytes;
  String? uploadedImageUrl;

  late int _selectedTripPreference;

  bool _isImageUpdated = false;
  bool _isFieldUpdated = false;
  bool updateProfile=false;
  Map<String, dynamic> userProfileMap = {};

  bool isLoading = false;

  DateTime? tempPickedDate;
  DateTime _selectedDate = DateTime.now();
  DataModel? _daumPostcodeSearchDataModel;

  @override
  void initState() {
    super.initState();
    User loginUser = Provider.of<UserModel>(context, listen: false).loggedInUser;
    print(loginUser.u_email);
    print(loginUser.trip_preference);
    emailController = TextEditingController(text: loginUser.u_email);
    nameController = TextEditingController(text: loginUser.u_name);
    nicknameController = TextEditingController(text: loginUser.u_nick);
    birthdayController = TextEditingController(text: loginUser.u_birth);
    phoneController = TextEditingController(text: loginUser.u_p_number);
    addressController = TextEditingController(text: loginUser.u_address);

    userProfileMap = {
      'u_email': loginUser.u_email,
      'u_name': loginUser.u_name,
      'u_nick': loginUser.u_nick,
      'u_birth': loginUser.u_birth,
      'u_p_number': loginUser.u_p_number,
      'u_address': loginUser.u_address,
      'u_img_url': loginUser.u_img_url,
    };
    _selectedTripPreference = loginUser.trip_preference;

    emailController.addListener(_onFieldChanged);
    nameController.addListener(_onFieldChanged);
    nicknameController.addListener(_onFieldChanged);
    birthdayController.addListener(_onFieldChanged);
    phoneController.addListener(_onFieldChanged);
    addressController.addListener(_onFieldChanged);
  }



  int getTripPreferenceFromLoginUser() {
    User loginUser = Provider.of<UserModel>(context, listen: false).loggedInUser;
    return loginUser.trip_preference;
  }


  void _onFieldChanged() {
    setState(() {
      _isFieldUpdated = userProfileMap['u_email'] != emailController.text ||
          userProfileMap['u_name'] != nameController.text ||
          userProfileMap['u_nick'] != nicknameController.text ||
          userProfileMap['u_birth'] != birthdayController.text ||
          userProfileMap['u_p_number'] != phoneController.text ||
          userProfileMap['u_address'] != addressController.text ||
          _selectedTripPreference != getTripPreferenceFromLoginUser;
      _isImageUpdated = previewImgBytes != null;
    });
  }

  void _onTripPreferenceChanged(int? value) {
    setState(() {
      if (value != null) {
        _selectedTripPreference = value;
        _isFieldUpdated = true;
      }
    });
  }

  void _validateAndNavigate() async {
    if (_isFieldUpdated || _isImageUpdated) {
      // 비동기 작업으로 이미지 업로드를 처리
      if (_isImageUpdated && previewImgBytes != null) {
        // 이미지 URL을 가져오기 위해 Firebase에 업로드
        try {
          final storageRef = FirebaseStorage.instance.ref();
          final ref = storageRef.child('/my_busan_log/profile_images/img_${DateTime.now().toIso8601String()}');

          UploadTask uploadTask = ref.putData(previewImgBytes!);
          TaskSnapshot taskSnapshot = await uploadTask;
          uploadedImageUrl = await taskSnapshot.ref.getDownloadURL();
        } catch (e) {
          print("이미지 업로드 중 오류 발생: $e");
          // 이미지 업로드 오류 처리
        }
      }

      User user = User(
        u_idx: Provider.of<UserModel>(context, listen: false).loggedInUser.u_idx,
        u_email: emailController.text,
        u_name: nameController.text,
        u_nick: nicknameController.text,
        u_birth: birthdayController.text,
        u_p_number: phoneController.text,
        u_address: addressController.text,
        trip_preference: _selectedTripPreference,
        u_img_url: uploadedImageUrl ?? Provider.of<UserModel>(context, listen: false).loggedInUser.u_img_url,
      );

      Provider.of<UserModel>(context, listen: false).updateUser = user;
      await Provider.of<UserModel>(context, listen: false).updateSaveUser();

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('프로필 수정이 완료되었습니다'),
        ),
      );
    }
  }


  void _formatPhoneNumber() {
    String text = phoneController.text;
    String formattedText = _formatPhoneNumberString(text);

    if (phoneController.text != formattedText) {
      phoneController.value = phoneController.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
        composing: TextRange.empty,
      );
    }
  }

  String _formatPhoneNumberString(String phoneNumber) {
    phoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), ''); // Remove non-numeric characters

    if (phoneNumber.length >= 11) {
      phoneNumber = phoneNumber.substring(0, 11); // Limit to 11 digits
    }

    if (phoneNumber.length >= 8) {
      return '${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 7)}-${phoneNumber.substring(7)}';
    } else if (phoneNumber.length >= 4) {
      return '${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3)}';
    } else {
      return phoneNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            )),
        elevation: 0,
        title: Text(
          '프로필 수정',
          style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 14),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: previewImgBytes != null
                            ? MemoryImage(previewImgBytes!)
                            : userModel.loggedInUser.u_img_url != null
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
                                  _isImageUpdated = true;
                                  updateProfile = true;
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
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2), // Shadow color
                                  spreadRadius: 2, // Spread radius
                                  blurRadius: 5,   // Blur radius
                                  offset: Offset(0, 3), // Shadow position
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.edit, color: Color(0xff0e4194), size: 25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          '이메일',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            height: 1.0,
                          ),
                        ),
                        Text(
                          ' (변경불가)',
                          style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              height: 1.0,
                              color: Colors.grey[600]
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  buildProfileItem('이메일', emailController, _isFieldUpdated, null, false),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '이름',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  buildProfileItem('이름', nameController, _isFieldUpdated),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '닉네임',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  buildProfileItem('닉네임', nicknameController, _isFieldUpdated),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '생년월일',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  BirthdayText(false),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '전화번호',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  buildProfileItem('전화번호', phoneController, _isFieldUpdated, TextInputType.phone),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '주소',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildCustomTextFieldWithButton('주소', addressController, _isFieldUpdated),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '여행 선호도',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildTravelPreferenceSection(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 흐림 효과
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Color(0xff0e4194)),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),

      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: (_isFieldUpdated || _isImageUpdated) ? () {
                  _validateAndNavigate();
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: (_isFieldUpdated || _isImageUpdated) ? Color(0xff0e4194) : Colors.grey,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  '저장',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget BirthdayText(bool isEntered) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        _selectDate();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: AbsorbPointer(  // TextField 비활성화
              child: TextField(
                controller: birthdayController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _selectDate() async {
    DateTime? pickedDate = await showModalBottomSheet<DateTime>(
      backgroundColor: ThemeData.light().scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('취소'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    CupertinoButton(
                      child: Text('완료'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    backgroundColor: ThemeData.light().scaffoldBackgroundColor,
                    minimumYear: 1900,
                    maximumYear: DateTime.now().year,
                    initialDateTime: DateTime.now(),
                    maximumDate: DateTime.now(),
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        birthdayController.text = convertDateTimeDisplay(pickedDate);
        _isFieldUpdated = true;
      });
    }
  }

  String convertDateTimeDisplay(DateTime date) {
    final DateFormat serverFormatter = DateFormat('yyyy-MM-dd');
    return serverFormatter.format(date);
  }

  // buildProfileItem, _buildCustomTextFieldWithButton 는 잠시 주석처리

  Widget buildProfileItem(String labelText, TextEditingController controller, bool isEntered, [TextInputType? inputType, bool enabled = true]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          onChanged: (text) {
            _formatPhoneNumber();
          },
          keyboardType: inputType,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ),
          cursorColor: Color(0xff0e4194),
          enabled: enabled,
          readOnly: !enabled,
        ),
      ],
    );
  }

  Widget _buildCustomTextFieldWithButton(String labelText, TextEditingController controller, bool isEntered, [TextInputType keyboardType = TextInputType.text]) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: (text) {

            },
            keyboardType: keyboardType,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
            ),
            cursorColor: Color(0xff0e4194),
          ),
        ),
        SizedBox(width: 5), // Space between the text field and button
        ElevatedButton(
          onPressed: () async {
            try {
              DataModel model = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchingPage(),
                ),
              );

              setState(() {
                _daumPostcodeSearchDataModel = model;
                addressController.text = _daumPostcodeSearchDataModel!.address;

              });
            } catch (error) {
              print(error);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff0e4194), // Button background color
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12), // Button padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
            elevation: 3, // Button shadow elevation
          ),
          child: Row(
            children: [
              Text(
                "주소 검색",
                style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.white
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTravelPreferenceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              title: Text('호캉스'),
              leading: Radio<int>(
                value: 1,
                groupValue: _selectedTripPreference,
                onChanged: _onTripPreferenceChanged,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              title: Text('액티비티'),
              leading: Radio<int>(
                value: 2,
                groupValue: _selectedTripPreference,
                onChanged: _onTripPreferenceChanged,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              title: Text('쇼핑'),
              leading: Radio<int>(
                value: 3,
                groupValue: _selectedTripPreference,
                onChanged: _onTripPreferenceChanged,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              title: Text('상관없음'),
              leading: Radio<int>(
                value: 4,
                groupValue: _selectedTripPreference,
                onChanged: _onTripPreferenceChanged,
              ),
            ),
            // DropdownButton<int>(
            //   value: _selectedTripPreference,
            //   items: _tripPreferences,
            //   onChanged: (value) {
            //     setState(() {
            //       _selectedTripPreference = value!;
            //     });
            //   },
            // ),
          ],
        ),
      ],
    );
  }
}