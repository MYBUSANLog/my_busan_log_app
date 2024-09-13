import 'dart:convert';
import 'dart:io';
import 'package:daum_postcode_search/data_model.dart';
import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../app_util/img_util.dart';
import '../model/join_model.dart';
import '../model/user_model.dart';
import '../vo/user.dart';

class SignUp3 extends StatefulWidget {
  const SignUp3({super.key});

  @override
  State<SignUp3> createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  TextEditingController _codeController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController(text: '생년월일');
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  Map<String, int> radioMap={'호캉스':0, '엑티비티':1, '쇼핑':2, '상관없음':3};
  Uint8List? previewImgBytes;
  String? uploadedImageUrl;

  bool _isNameEntered = false;
  bool _isNicknameEntered = false;
  bool _isPhoneEntered = false;
  bool _isAddressEntered = false;
  bool _isBirthdayEntered = false;
  bool _isImageUpdated = false;

  DateTime? tempPickedDate;
  DateTime _selectedDate = DateTime.now();
  File? _profileImage;
  DataModel? _daumPostcodeSearchDataModel;

  final ImagePicker _picker = ImagePicker();

  String? _selectedTripPreference;

  bool isLoading = false;


  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  void _validateAndNavigate() async {
    String? uploadedImageUrl;

    if (_isAllFieldsEntered() || _isImageUpdated) {

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
        u_email: Provider.of<JoinModel>(context, listen: false).joinUser.u_email,
        u_pw: Provider.of<JoinModel>(context, listen: false).joinUser.u_pw,
        u_name: _nameController.text,
        u_nick: _nicknameController.text,
        u_birth: _birthdayController.text,
        u_p_number: _phoneController.text,
        u_address: _addressController.text,
        trip_preference: radioMap[_selectedTripPreference]!,
        login_provider: 'basic',
        u_img_url: uploadedImageUrl ?? 'https://firebasestorage.googleapis.com/v0/b/mybusanlog-b600f.appspot.com/o/my_busan_log%2Fprofile_images%2Fdefault_profile.jpg?alt=media&token=1b151b41-6368-4154-ab15-6d7ddf1735bf',
      );

      Provider.of<JoinModel>(context, listen: false).joinUser = user;
      Provider.of<JoinModel>(context,listen: false).saveUser();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('회원가입이 완료되었습니다'),
        ),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  bool _isAllFieldsEntered() {
    return _isNameEntered &&
        _isNicknameEntered &&
        _isPhoneEntered &&
        _isAddressEntered &&
        _isBirthdayEntered &&
        _selectedTripPreference != null;
  }

  void _onFieldChanged() {
    setState(() {
      _isNameEntered = _nameController.text.isNotEmpty;
      _isNicknameEntered = _nicknameController.text.isNotEmpty;
      _isPhoneEntered = _phoneController.text.isNotEmpty;
      _isAddressEntered = _addressController.text.isNotEmpty;
    });
  }

  void _formatPhoneNumber() {
    String text = _phoneController.text;
    String formattedText = _formatPhoneNumberString(text);

    if (_phoneController.text != formattedText) {
      _phoneController.value = _phoneController.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
        composing: TextRange.empty,
      );
    }

    setState(() {
      _isPhoneEntered = formattedText.isNotEmpty;
    });
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
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final userModel = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '회원가입 (3/3)',
          style: TextStyle(
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 20),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: previewImgBytes != null
                        ? MemoryImage(previewImgBytes!)
                        : AssetImage('assets/images/default_profile.jpg'),
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
              // Consumer<JoinModel>(builder: (context, joinUserModel, child) {
              //   return Column(
              //     children: [
              //       Text('이메일 : ${joinUserModel.joinUser.u_email}'),
              //       Text('비밀번호 : ${joinUserModel.joinUser.u_pw}')
              //     ],
              //   );
              // }),
              // SizedBox(height: 30),
              _buildCustomTextField(
                  '이름', _nameController, _isNameEntered),
              SizedBox(height: 30),
              _buildCustomTextField(
                  '닉네임', _nicknameController, _isNicknameEntered),
              SizedBox(height: 30),
              BirthdayText(false),
              SizedBox(height: 30),
              _buildCustomPhoneField(
                  '전화번호', _phoneController, _isPhoneEntered),
              SizedBox(height: 30),
              _buildCustomTextFieldWithButton(
                  '주소', _addressController, _isAddressEntered),
              SizedBox(height: 30),
              _buildTravelPreferenceSection(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(0),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _isAllFieldsEntered() ? _validateAndNavigate : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isAllFieldsEntered()
                    ? const Color(0xff0e4194)
                    : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: BorderSide.none,
                ),
                padding: EdgeInsets.zero,
              ),
              child: const Text(
                '다음',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
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
              // border: Border(
              //   bottom: BorderSide(
              //     color: isEntered ? Colors.green : Colors.grey,
              //     width: 2.0,
              //   ),
              // ),
            ),
            child: AbsorbPointer(  // TextField 비활성화
              child: TextField(
                controller: _birthdayController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),  // 텍스트와 입력란의 간격 조정
                  border: InputBorder.none,  // 기본 border 제거
                  focusedBorder: UnderlineInputBorder (
                    borderSide: BorderSide(
                      color: isEntered ? Colors.green : Colors.grey,
                      width: 1.0,
                    ),
                  ),  // 포커스 시 border 제거
                  enabledBorder: UnderlineInputBorder (
                    borderSide: BorderSide(
                      color: isEntered ? Colors.green : Colors.grey,
                      width: 1.0,
                    ),
                  ),  // 활성화 시 border 제거
                  suffixIcon: _isBirthdayEntered
                      ? Icon(Icons.check_circle, color: Colors.green, size: 24,)
                      : null,
                ),
                style: TextStyle(fontSize: 16, color: _isBirthdayEntered ? Colors.black : Colors.grey),
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
        _birthdayController.text = convertDateTimeDisplay(pickedDate);
        _isBirthdayEntered = true;
      });
    }
  }

  String convertDateTimeDisplay(DateTime date) {
    final DateFormat serverFormatter = DateFormat('yyyy-MM-dd');
    return serverFormatter.format(date);
  }

  Widget _buildCustomTextField(String labelText, TextEditingController controller, bool isEntered) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          onChanged: (text) {
            _onFieldChanged();
          },
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: isEntered ? Colors.green : Colors.grey),
            border: InputBorder.none,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: isEntered ? Colors.green : Colors.grey,
                width: 1.0,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: isEntered ? Colors.green : Colors.grey,
                width: 1.0,
              ),
            ),
            suffixIcon: isEntered
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
          ),
          cursorColor: Color(0xff0e4194),
        ),
      ],
    );
  }

  Widget _buildCustomPhoneField(String labelText, TextEditingController controller, bool isEntered) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          onChanged: (text) {
            _formatPhoneNumber();
            _onFieldChanged();
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: isEntered ? Colors.green : Colors.grey),
            border: InputBorder.none,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: isEntered ? Colors.green : Colors.grey,
                width: 1.0,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: isEntered ? Colors.green : Colors.grey,
                width: 1.0,
              ),
            ),
            suffixIcon: isEntered
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
          ),
          cursorColor: Color(0xff0e4194),
        ),
      ],
    );
  }

  Widget _buildCustomTextFieldWithButton(String labelText, TextEditingController controller, bool isEntered) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: (text) {
              _onFieldChanged();
            },
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: isEntered ? Colors.green : Colors.grey),
              border: InputBorder.none,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: isEntered ? Colors.green : Colors.grey,
                  width: 1.0,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: isEntered ? Colors.green : Colors.grey,
                  width: 1.0,
                ),
              ),
              suffixIcon: isEntered
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : null,
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
                _addressController.text = _daumPostcodeSearchDataModel!.address;
                _onFieldChanged();
              });
            } catch (error) {
              print(error);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff0e4194), // Button background color
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16), // Button padding
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
        Text(
          '여행 선호도',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              title: Text('호캉스'),
              leading: Radio<String>(
                value: '호캉스',
                groupValue: _selectedTripPreference,
                onChanged: (value) {
                  setState(() {
                    _selectedTripPreference = value;
                  });
                },
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              title: Text('엑티비티'),
              leading: Radio<String>(
                value: '엑티비티',
                groupValue: _selectedTripPreference,
                onChanged: (value) {
                  setState(() {
                    _selectedTripPreference = value;
                  });
                },
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              title: Text('쇼핑'),
              leading: Radio<String>(
                value: '쇼핑',
                groupValue: _selectedTripPreference,
                onChanged: (value) {
                  setState(() {
                    _selectedTripPreference = value;
                  });
                },
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              title: Text('상관없음'),
              leading: Radio<String>(
                value: '상관없음',
                groupValue: _selectedTripPreference,
                onChanged: (value) {
                  setState(() {
                    _selectedTripPreference = value;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }


}

class SearchingPage extends StatefulWidget {
  @override
  _SearchingPageState createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  @override
  Widget build(BuildContext context) {
    DaumPostcodeSearch daumPostcodeSearch = DaumPostcodeSearch(
      onConsoleMessage: (InAppWebViewController controller, ConsoleMessage consoleMessage) {
        final String? address = extractAddressFromConsoleMessage(consoleMessage.message);
        if (address != null) {
          Navigator.of(context).pop(address);  // 주소 데이터를 반환
        }
      },
      onLoadError: (controller, uri, errorCode, message) {
        setState(() {
          // 로드 에러 처리
        });
      },
      onLoadHttpError: (controller, uri, errorCode, message) {
        setState(() {
          // HTTP 에러 처리
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: daumPostcodeSearch,
    );
  }

  String? extractAddressFromConsoleMessage(String message) {
    // 콘솔 메시지에서 주소 추출하는 로직 구현
    return message;  // 예시: 메시지가 주소라면 그대로 반환
  }
}