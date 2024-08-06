import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '알림',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '검색화면',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();
  List<String> _allData = [];
  List<String> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_filterData);
  }

  @override
  void dispose() {
    _controller.removeListener(_filterData);
    _controller.dispose();
    super.dispose();
  }

  void _filterData() {
    String query = _controller.text.toLowerCase();
    setState(() {
      _filteredData = _allData
          .where((item) => item.toLowerCase().contains(query))
          .toList();
    });
  }

  void _clearSearch() {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(

                  hintText: '유명한 여행지를 검색해보세요',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: _clearSearch,
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _filteredData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredData[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


