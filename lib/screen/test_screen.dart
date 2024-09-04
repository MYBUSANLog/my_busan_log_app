import 'dart:io';
import 'dart:typed_data';

import 'package:busan_trip/app_util/img_util.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  final storage = FirebaseStorage.instance;
  List<Uint8List>? previewImgBytesList = null;  // null로 초기화
  List<String> uploadedImageUrls = [];  // 업로드된 이미지의 URL을 저장할 리스트

  @override
  Widget build(BuildContext context) {
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
          '테스트 화면',
          style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              previewImgBytesList == null
                  ? Text('이미지 선택')
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: previewImgBytesList!.map((bytes) => Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image.memory(bytes, width: 150),
                        )).toList(),
                      ),
                    ),
              ElevatedButton(
                  onPressed: () async {
                    final picker = ImagePicker();
                    List<XFile> imgFiles = await picker.pickMultiImage();
                    if(imgFiles != null) {
                      List<Uint8List>? imageBytesList = [];
                      for(var imgFile in imgFiles) {
                        Uint8List bytes = await ImgUtil.convertResizedUint8List(xFile: imgFile);
                        imageBytesList.add(bytes);
                      }
                      setState(() {
                        previewImgBytesList = imageBytesList;
                      });
                    }

                  },
                  child: Text('갤러리에서 이미지 선택'),
              ),
              ElevatedButton(
                  onPressed: () async{
                    // Firebase Storage 업로드

                    if(previewImgBytesList == null) {
                      print('이미지를 선택해주세요');
                      return;
                    }

                    for (var bytes in previewImgBytesList!) {
                      final storageRef = FirebaseStorage.instance.ref();
                      final ref = storageRef.child('/my_busan_log/review/img_${DateTime.now()}');

                      UploadTask task = ref.putData(bytes);
                      TaskSnapshot taskSnapshot = await task;

                      String downloadURL = await taskSnapshot.ref.getDownloadURL();
                      uploadedImageUrls.add(downloadURL);
                    }
                    print('업로드된 이미지 URLs: $uploadedImageUrls');
                  },
                  child: Text('사진 업로드(리뷰, 후기)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
