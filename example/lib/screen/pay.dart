import 'package:flutter/material.dart';
import 'package:bootpay/bootpay.dart';
import 'package:bootpay/model/extra.dart';
import 'package:bootpay/model/item.dart';
import 'package:bootpay/model/payload.dart';
import 'package:bootpay/model/user.dart';

class PayScreen extends StatefulWidget {
  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  Payload payload = Payload();
  String webApplicationId = '5b8f6a4d396fa665fdc2b5e7';
  String androidApplicationId = '5b8f6a4d396fa665fdc2b5e8';
  String iosApplicationId = '5b8f6a4d396fa665fdc2b5e9';

  @override
  void initState() {
    super.initState();
    bootpayRequestDataInit();
  }

  void bootpayRequestDataInit() {
    Item item1 = Item();
    item1.name = "미키 마우스";
    item1.qty = 1;
    item1.id = "ITEM_CODE_MOUSE";
    item1.price = 500;

    Item item2 = Item();
    item2.name = "키보드";
    item2.qty = 1;
    item2.id = "ITEM_CODE_KEYBOARD";
    item2.price = 500;

    List<Item> itemList = [item1, item2];

    payload.webApplicationId = webApplicationId;
    payload.androidApplicationId = androidApplicationId;
    payload.iosApplicationId = iosApplicationId;
    payload.pg = '나이스페이';
    payload.method = '네이버페이';
    payload.orderName = "테스트 상품";
    payload.price = 1000.0;
    payload.orderId = DateTime.now().millisecondsSinceEpoch.toString();
    payload.metadata = {
      "callbackParam1": "value12",
      "callbackParam2": "value34",
      "callbackParam3": "value56",
      "callbackParam4": "value78",
    };
    payload.items = itemList;

    User user = User();
    user.username = "사용자 이름";
    user.email = "user1234@gmail.com";
    user.area = "서울";
    user.phone = "010-4033-4678";
    user.addr = '서울시 동작구 상도로 222';

    Extra extra = Extra();
    extra.appScheme = 'bootpayFlutterExample';
    extra.cardQuota = '3';

    payload.user = user;
    payload.extra = extra;
    payload.extra?.openType = "iframe";
  }

  void goBootpayTest(BuildContext context) {
    Bootpay().requestPayment(
      context: context,
      payload: payload,
      showCloseButton: true,
      onCancel: (String data) {
        print('------- onCancel: $data');
        Navigator.of(context).pop();
      },
      onError: (String data) {
        print('------- onError: $data');
        Navigator.of(context).pop();
      },
      onClose: () {
        print('------- onClose');
        Navigator.of(context).pop();
      },
      onIssued: (String data) {
        print('------- onIssued: $data');
      },
      onConfirm: (String data) {
        print('------- onConfirm: $data');
        return true;
      },
      onDone: (String data) {
        print('------- onDone: $data');
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('결제', style: TextStyle(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('결제 화면', style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontSize: 16,
                color: Colors.black,
              )),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => goBootpayTest(context),
                child: Text('통합결제 테스트', style: TextStyle(
                  fontFamily: 'NotoSansKR',
                  fontSize: 16,
                  color: Colors.white,
                )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
