import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
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
              leading: Icon(Icons.person, color: Colors.deepPurple),
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
              leading: Icon(Icons.payment, color: Colors.deepPurple),
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
              leading: Icon(Icons.receipt, color: Colors.deepPurple),
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
              leading: Icon(Icons.favorite, color: Colors.deepPurple),
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
              leading: Icon(Icons.rate_review, color: Colors.deepPurple),
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
              leading: Icon(Icons.bookmark, color: Colors.deepPurple),
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
              leading: Icon(Icons.announcement, color: Colors.deepPurple),
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
              leading: Icon(Icons.support_agent, color: Colors.deepPurple),
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
              leading: Icon(Icons.settings, color: Colors.deepPurple),
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
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
