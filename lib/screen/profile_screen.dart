import 'package:busan_trip/screen/login_opening_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Offset _fabOffset = Offset(330, 650); // 초기 위치 설정

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ));
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그아웃'),
          content: Text('로그아웃 하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginOpeningScreen()), // 화면 이동
                );
              },
              child: Text('예'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        title: Text(
          '프로필',
          style: TextStyle(
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.w500,
            fontSize: 23,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0, // 스크롤 시 AppBar 색상 변경 방지
      ),
      body: Stack(
        children: [
          SingleChildScrollView( // SingleChildScrollView 설정(나현)
            child: ConstrainedBox(
              constraints: BoxConstraints( // SingleChildScrollView 설정(나현)
                minHeight: MediaQuery.of(context).size.height, // 최소 높이 설정(나현)
              ),
              child: IntrinsicHeight(
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/default_profile.jpg'), // AssetImage 사용
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/profile_alter'); // 경로가 설정된 라우트로 이동
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '설정',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 13), // 아래로 패딩 추가
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.logout, color: Color(0xff0e4194)),
                        title: Text(
                          '로그아웃',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () => _showLogoutDialog(context),
                      ),
                      Divider(color: Colors.grey, thickness: 1.0),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.payment, color: Color(0xff0e4194)),
                        title: Text(
                          '결제',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/pay');
                        },
                      ),
                      Divider(color: Colors.grey, thickness: 1.0),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.receipt, color: Color(0xff0e4194)),
                        title: Text(
                          '결제내역',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/receipt');
                        },
                      ),
                      Divider(color: Colors.grey, thickness: 1.0),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.favorite, color: Color(0xff0e4194)),
                        title: Text(
                          '찜목록',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          // 찜목록 화면으로 이동
                        },
                      ),
                      Divider(color: Colors.grey, thickness: 1.0),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.rate_review, color: Color(0xff0e4194)),
                        title: Text(
                          '내가 쓴 리뷰',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          // 내가 쓴 리뷰 화면으로 이동
                        },
                      ),
                      Divider(color: Colors.grey, thickness: 1.0),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.bookmark, color: Color(0xff0e4194)),
                        title: Text(
                          '북마크 목록',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          // 북마크 목록 화면으로 이동
                        },
                      ),
                      Divider(color: Colors.grey, thickness: 1.0),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.announcement, color: Color(0xff0e4194)),
                        title: Text(
                          '공지사항',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          // 공지사항 화면으로 이동
                        },
                      ),
                      Divider(color: Colors.grey, thickness: 1.0),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.support_agent, color: Color(0xff0e4194)),
                        title: Text(
                          '고객센터',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          // 고객센터 화면으로 이동
                        },
                      ),
                      Divider(color: Colors.grey, thickness: 1.0),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(Icons.settings, color: Color(0xff0e4194)),
                        title: Text(
                          '환경 설정',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          // 환경 설정 화면으로 이동
                        },
                      ),
                      Divider(color: Colors.grey, thickness: 1.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: _fabOffset.dx,
            top: _fabOffset.dy,
            child: Draggable(
              feedback: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/chatbot');
                },
                child: Icon(Icons.chat, color: Colors.white),
                backgroundColor: Color(0xff0e4194),
              ),
              childWhenDragging: Container(),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/chatbot');
                },
                child: Icon(Icons.chat, color: Colors.white),
                backgroundColor: Color(0xff0e4194),
              ),
              onDragEnd: (details) {
                setState(() {
                  _fabOffset = details.offset;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
