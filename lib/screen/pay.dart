import 'package:bootpay/bootpay.dart';
import 'package:bootpay/model/extra.dart';
import 'package:bootpay/model/item.dart';
import 'package:bootpay/model/payload.dart';
import 'package:bootpay/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PayScreen extends StatelessWidget {
  // 예시 애플리케이션 ID를 설정하세요.
  final String webApplicationId = '5b8f6a4d396fa665fdc2b5e7';
  final String androidApplicationId = '5b8f6a4d396fa665fdc2b5e8';
  final String iosApplicationId = '5b8f6a4d396fa665fdc2b5e9';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '결제',
          style: TextStyle(
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.w500,
            fontSize: 23,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '결제 화면',
                style: TextStyle(
                  fontFamily: 'NotoSansKR',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => bootpayTest(context),
                child: Text('결제하기', style: TextStyle(fontFamily: 'NotoSansKR')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void bootpayTest(BuildContext context) {
    Payload payload = getPayload();
    if (kIsWeb) {
      payload.extra?.openType = "iframe";
    }

    Bootpay().requestPayment(
      context: context,
      payload: payload,
      showCloseButton: false,
      onCancel: (String data) {
        print('------- onCancel: $data');
      },
      onError: (String data) {
        print('------- onError: $data');
      },
      onClose: () {
        print('------- onClose');
        Bootpay().dismiss(context);
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
      },
    );
  }

  Payload getPayload() {
    Payload payload = Payload();
    Item item1 = Item();
    item1.name = "미키 '마우스";
    item1.qty = 1;
    item1.id = "ITEM_CODE_MOUSE";
    item1.price = 150000;

    Item item2 = Item();
    item2.name = "키보드";
    item2.qty = 1;
    item2.id = "ITEM_CODE_KEYBOARD";
    item2.price = 150000;
    List<Item> itemList = [item1, item2];

    payload.webApplicationId = webApplicationId;
    payload.androidApplicationId = androidApplicationId;
    payload.iosApplicationId = iosApplicationId;

    payload.pg = '나이스페이';
    payload.orderName = "해운대 패키지 여행";
    payload.price = 300000.0;
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
    return payload;
  }
}
