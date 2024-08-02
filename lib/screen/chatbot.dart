import 'package:flutter/material.dart';
import '../model/chatbot_model.dart';

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  List<ChatbotModel> messages = [];
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 초기 인사 메시지
    messages.add(ChatbotModel(
      message: "방문해주셔서 감사합니다 :)",
      isUser: false,
    ));
    messages.add(ChatbotModel(
      message: "부산 여행에 대해 관심이 많으시군요! 무엇을 도와드릴까요?\n"
          "1. 부산 인기 명소\n"
          "2. 부산에 가는 방법\n"
          "3. 부산에서 열리는 특별한 연중 이벤트\n"
          "4. 부산의 주요 랜드마크\n"
          "5. 맛집 추천\n"
          "6. 숙박 정보\n"
          "7. 교통 정보\n"
          "8. 쇼핑 정보\n"
          "9. 기타 문의",
      isUser: false,
    ));
  }

  void sendMessage(String message) {
    setState(() {
      messages.add(ChatbotModel(message: message, isUser: true));
      handleBotResponse(message);
    });
    messageController.clear();
  }

  void handleBotResponse(String message) {
    String response;

    switch (message) {
      case '1':
        response = '부산 인기 명소 리스트:\n'
            '- 씨라이프 부산아쿠아리움\n'
            '- 해운대 해수욕장\n'
            '- 감천 문화 마을';
        break;
      case '2':
        response = '부산에 가는 방법:\n'
            '- KTX 이용: 서울역에서 부산역까지 약 2시간 30분 소요\n'
            '- 고속버스 이용: 전국 주요 도시에서 부산행 버스 운행';
        break;
      case '3':
        response = '부산에서 열리는 특별한 연중 이벤트:\n'
            '- 부산 국제 영화제 (10월)\n'
            '- 부산 불꽃축제 (11월)\n'
            '- 해운대 빛 축제 (12월)';
        break;
      case '4':
        response = '부산의 주요 랜드마크:\n'
            '- 광안대교\n'
            '- 부산 타워\n'
            '- 용두산 공원';
        break;
      case '5':
        response = '부산의 맛집 추천:\n'
            '- 돼지국밥\n'
            '- 밀면\n'
            '- 씨앗호떡';
        break;
      case '6':
        response = '부산의 숙박 정보:\n'
            '- 해운대 호텔\n'
            '- 광안리 게스트하우스\n'
            '- 서면 에어비앤비';
        break;
      case '7':
        response = '부산의 교통 정보:\n'
            '- 지하철: 1호선, 2호선, 3호선, 4호선\n'
            '- 버스: 다양한 노선 운행\n'
            '- 택시: 기본요금 3,300원';
        break;
      case '8':
        response = '부산의 쇼핑 정보:\n'
            '- 신세계 센텀시티\n'
            '- 롯데백화점 광복점\n'
            '- 남포동 국제시장';
        break;
      case '9':
        response = '기타 문의사항이 있으시면 질문해주세요!';
        break;
      default:
        response = '죄송합니다, 이해하지 못했습니다. 번호를 다시 선택해주세요.';
    }

    setState(() {
      messages.add(ChatbotModel(message: response, isUser: false));
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('챗봇 종료'),
        content: Text('챗봇을 종료하시겠습니까?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // "예" 버튼이 첫 번째로 나옴
            child: Text('예'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // "아니요" 버튼이 두 번째로 나옴
            child: Text('아니요'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '챗봇',
            style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w500,
              fontSize: 23,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue[800], // 부산을 상징하는 파란색으로 변경
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              bool exit = await _onWillPop();
              if (exit) {
                Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
              }
            },
          ),
        ),
        body: Container(
          color: Colors.blue[50], // 배경색 변경
          padding: EdgeInsets.all(10), // 전체 패딩 추가
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return Align(
                      alignment: message.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: message.isUser ? Colors.blue[600] : Colors.blue[200],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(message.isUser ? 15.0 : 0),
                            bottomRight: Radius.circular(message.isUser ? 0 : 15.0),
                          ),
                        ),
                        child: Text(
                          message.message,
                          style: TextStyle(
                            color: message.isUser ? Colors.white : Colors.black,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: '메시지를 입력하세요...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send, color: Colors.blue[800]),
                      onPressed: () {
                        sendMessage(messageController.text);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
