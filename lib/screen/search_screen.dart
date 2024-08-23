import 'package:busan_trip/screen/search_result_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> _recentSearches = [];

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addSearchTerm(String searchTerm) {
    if (searchTerm.isNotEmpty && !_recentSearches.contains(searchTerm)) {
      setState(() {
        _recentSearches.insert(0, searchTerm); // 최근 검색어를 리스트의 앞쪽에 추가
      });
    }
  }

  void _handleSubmitted(String value) {
    final searchTerm = value.trim();
    if (searchTerm.isNotEmpty) {
      _addSearchTerm(searchTerm); // 최근 검색어에 추가
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchResultList(searchTerm: searchTerm)),
      );
      _controller.clear(); // 입력창 비우기
    } else {
      FocusScope.of(context).unfocus(); // 텍스트가 비어 있을 때 키보드 닫기
    }
  }


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ));

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: SafeArea(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 16.0),
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: '여행지를 검색해주세요',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8.0),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      suffixIcon: _controller.text.isNotEmpty
                          ? IconButton(
                        icon: Icon(Icons.cancel, color: Colors.grey[400], size: 20,),
                        onPressed: () {
                          _controller.clear();
                          setState(() {});
                        },
                      )
                          : null,
                    ),
                    cursorColor: Color(0xff0e4194),
                    onSubmitted: _handleSubmitted, // 텍스트 입력 후 Enter 처리
                    textInputAction: TextInputAction.search,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _recentSearches.length,
                      itemBuilder: (context, index) {
                        final searchTerm = _recentSearches[index];
                        return ListTile(
                          title: Text(searchTerm),
                          onTap: () {
                            // 클릭 시 검색어로 검색 기능을 추가할 수 있습니다.
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}