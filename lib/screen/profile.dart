import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 4; // 기본 프로필 선택
  Offset _fabOffset = Offset(1600, 130); // 초기 위치 설정

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/restaurant');
        break;
      case 1:
        Navigator.pushNamed(context, '/ai_recommend');
        break;
      case 2:
        Navigator.pushNamed(context, '/home');
        break;
      case 3:
        Navigator.pushNamed(context, '/notifications');
        break;
      case 4:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                 /* backgroundImage: NetworkImage(
                    'https://example.com/your_profile_image.jpg',
                  ),*/
                  backgroundImage: AssetImage('assets/images/abc.png'), // 로컬 이미지 사용
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile_alter');
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
                  contentPadding: EdgeInsets.symmetric(horizontal: 0), // 여기서 패딩을 설정합니다.
                  leading: Icon(Icons.person, color: Colors.blueAccent),
                  title: Text(
                    '프로필 변경',
                    style: TextStyle(
                      fontFamily: 'NotoSansKR',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/profile_alter');
                  },
                ),
                Divider(color: Colors.black, thickness: 0.5, indent: 7), // 여기서 시작 위치를 설정합니다.
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: Icon(Icons.payment, color: Colors.blueAccent),
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
                Divider(color: Colors.black, thickness: 0.5, indent: 7),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: Icon(Icons.receipt, color: Colors.blueAccent),
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
                Divider(color: Colors.black, thickness: 0.5, indent: 7),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: Icon(Icons.favorite, color: Colors.blueAccent),
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
                Divider(color: Colors.black, thickness: 0.5, indent: 7),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: Icon(Icons.rate_review, color: Colors.blueAccent),
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
                Divider(color: Colors.black, thickness: 0.5, indent: 7),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: Icon(Icons.bookmark, color: Colors.blueAccent),
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
                Divider(color: Colors.black, thickness: 0.5, indent: 7),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: Icon(Icons.announcement, color: Colors.blueAccent),
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
                Divider(color: Colors.black, thickness: 0.5, indent: 7),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: Icon(Icons.support_agent, color: Colors.blueAccent),
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
                Divider(color: Colors.black, thickness: 0.5, indent: 7),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: Icon(Icons.settings, color: Colors.blueAccent),
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
                Divider(color: Colors.black, thickness: 0.5, indent: 7),
              ],
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
                backgroundColor: Colors.blueAccent,
              ),
              childWhenDragging: Container(),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/chatbot');
                },
                child: Icon(Icons.chat, color: Colors.white),
                backgroundColor: Colors.blueAccent,
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5), // Shadow color with opacity
              offset: Offset(0, -2), // Offset the shadow upwards (top shadow effect)
              blurRadius: 4.0, // Blur radius for the shadow
              spreadRadius: 0, // Spread radius of the shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xff0e4194),
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: TextStyle(fontSize: 10),
            unselectedLabelStyle: TextStyle(fontSize: 10),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                label: '맛집',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'AI추천',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: '알림',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '프로필',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
