import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 4; // 기본 프로필 선택

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
        title: Text('프로필', style: TextStyle(
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
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://example.com/your_profile_image.jpg',
              ),
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
            Text(
              '설정',
              style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w500,
                fontSize: 23,
                color: Colors.black,
              ),
            ),
            Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.person, color: Colors.blueAccent),
              title: Text('프로필 변경', style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontSize: 16,
                color: Colors.black,
              )),
              onTap: () {
                Navigator.pushNamed(context, '/profile_alter');
              },
            ),
            ListTile(
              leading: Icon(Icons.payment, color: Colors.blueAccent),
              title: Text('결제', style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontSize: 16,
                color: Colors.black,
              )),
              onTap: () {
                Navigator.pushNamed(context, '/pay');
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt, color: Colors.blueAccent),
              title: Text('결제내역', style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontSize: 16,
                color: Colors.black,
              )),
              onTap: () {
                Navigator.pushNamed(context, '/receipt');
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.blueAccent),
              title: Text('찜목록', style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontSize: 16,
                color: Colors.black,
              )),
              onTap: () {
                // 찜목록 화면으로 이동
              },
            ),
            ListTile(
              leading: Icon(Icons.rate_review, color: Colors.blueAccent),
              title: Text('내가 쓴 리뷰', style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontSize: 16,
                color: Colors.black,
              )),
              onTap: () {
                // 내가 쓴 리뷰 화면으로 이동
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark, color: Colors.blueAccent),
              title: Text('북마크 목록', style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontSize: 16,
                color: Colors.black,
              )),
              onTap: () {
                // 북마크 목록 화면으로 이동
              },
            ),
            ListTile(
              leading: Icon(Icons.announcement, color: Colors.blueAccent),
              title: Text('공지사항', style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontSize: 16,
                color: Colors.black,
              )),
              onTap: () {
                // 공지사항 화면으로 이동
              },
            ),
            ListTile(
              leading: Icon(Icons.support_agent, color: Colors.blueAccent),
              title: Text('고객센터', style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontSize: 16,
                color: Colors.black,
              )),
              onTap: () {
                // 고객센터 화면으로 이동
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.blueAccent),
              title: Text('환경 설정', style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontSize: 16,
                color: Colors.black,
              )),
              onTap: () {
                // 환경 설정 화면으로 이동
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/chatbot');
        },
        child: Icon(Icons.chat, color: Colors.white),
        backgroundColor: Colors.blueAccent,
      ),
      // 추가된 부분
      bottomNavigationBar: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xff0e4194),
            selectedItemColor: Colors.amberAccent,
            unselectedItemColor: Colors.white,
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
