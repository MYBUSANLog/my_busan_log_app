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
  List<Uint8List> previewImgBytesList = [];  // null로 초기화
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
              previewImgBytesList.length==0
                  ? Text('이미지 선택')
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: previewImgBytesList.map((bytes) => ImgBox(
                          bytes: bytes,
                          onRemove: (){

                            setState(() {
                              previewImgBytesList.remove(bytes);
                            });
                          },
                        )).toList(),
                      ),
                    ),
              ElevatedButton(
                  onPressed: () async {
                    final picker = ImagePicker();
                    List<XFile> imgFiles = await picker.pickMultiImage();
                    if(imgFiles.isNotEmpty) {
                      List<Uint8List>? imageBytesList = [];
                      for(var imgFile in imgFiles) {
                        try {
                          Uint8List bytes =
                          await ImgUtil.convertResizedUint8List(
                              xFile: imgFile);
                          print("선택한 이미지의 데이터 크기: ${bytes.lengthInBytes} bytes");
                          imageBytesList.add(bytes);
                        } catch (e) {
                          print(
                              "이미지 데이터 크기 오류 발생! 선택한 이미지의 데이터 크기: ${await imgFile.length()} bytes");
                          print("오류: $e");
                        }
                      }
                      setState(() {
                        previewImgBytesList.addAll(imageBytesList);
                      });
                    }

                  },
                  child: Text('갤러리에서 이미지 선택'),
              ),
              ElevatedButton(
                  onPressed: () async{
                    // Firebase Storage 업로드

                    if(previewImgBytesList.length==0) {
                      print('이미지를 선택해주세요');
                      return;
                    }

                    for (var bytes in previewImgBytesList) {
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


class ImgBox extends StatelessWidget {

  Uint8List bytes;
  Function onRemove;

  ImgBox({
    required this.bytes,
    required this.onRemove
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                bytes,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
          ),
          Positioned(
              top:0,
              right: 5,
              child: GestureDetector(
                onTap: (){
                  onRemove();
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black54,
                  ),
                  child: Icon(Icons.close,color: Colors.white, size: 16,),
                )
              )
          )
        ],
      ),
    );
  }
}
