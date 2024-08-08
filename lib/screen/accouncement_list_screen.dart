import 'package:flutter/material.dart';

class AccouncementListScreen extends StatefulWidget {
  const AccouncementListScreen({super.key});

  @override
  State<AccouncementListScreen> createState() => _AccouncementListScreenState();
}

class _AccouncementListScreenState extends State<AccouncementListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 32.0), // 왼쪽 패딩을 32.0으로 설정하여 오른쪽으로 이동
          child: Text(
            '공지사항',
            style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w500,
              fontSize: 23,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 2.0,
                  color: Colors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xff0e4194), // 직접 색상 설정
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white, // 활성화된 탭의 글자색
          unselectedLabelColor: Colors.grey, // 비활성화된 탭의 글자색
          tabs: [
            Tab(text: '고정된 공지사항'),
            Tab(text: '최신 공지사항'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  // 배경색을 흰색으로 설정
                  // color: Colors.white,
                  child: _buildFixedAnnouncements(),
                ),
                Container(
                  // 배경색을 흰색으로 설정
                  // color: Colors.white,
                  child: _buildLatestAnnouncements(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFixedAnnouncements() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        _buildAnnouncementTile('🔔 중요 공지사항 1', '공지사항 내용 1'),
        _buildAnnouncementTile('📅 이벤트 알림', '공지사항 내용 2'),
        // 추가 공지사항 항목을 여기에 추가할 수 있습니다.
      ],
    );
  }

  Widget _buildLatestAnnouncements() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        _buildAnnouncementTile('🆕 최신 공지사항 1', '공지사항 내용 3'),
        _buildAnnouncementTile('🆕 최신 공지사항 2', '공지사항 내용 4'),
        // 최신 공지사항 항목을 여기에 추가할 수 있습니다.
      ],
    );
  }

  Widget _buildAnnouncementTile(String title, String subtitle) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(title, style: TextStyle(fontFamily: 'NotoSansKR', fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(fontFamily: 'NotoSansKR')),
      ),
    );
  }
}