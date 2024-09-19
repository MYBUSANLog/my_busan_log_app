import 'package:busan_trip/app_http/heart_list_http.dart';
import 'package:busan_trip/model/heart_list_model.dart';
import 'package:busan_trip/screen/item_detail_screen.dart';
import 'package:busan_trip/vo/heart_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeartListScreen extends StatefulWidget {
  final int userId;

  HeartListScreen({required this.userId});

  @override
  _HeartListScreenState createState() => _HeartListScreenState();
}

class _HeartListScreenState extends State<HeartListScreen> {
  late HeartListModel heartListModel;

  @override
  void initState() {
    super.initState();
    heartListModel = HeartListModel();
    heartListModel.setHeartLists(widget.userId);
  }

  Future<void> _refreshHeartList() async {
    await heartListModel.setHeartLists(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HeartListModel>.value(
      value: heartListModel,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          elevation: 0,
          title: Text(
            '마음함',
            style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '내가 마음에 담은 상품 목록',
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: Consumer<HeartListModel>(
                    builder: (context, heartListModel, child) {
                      return RefreshIndicator(
                        onRefresh: _refreshHeartList,
                        child: heartListModel.heartLists.isNotEmpty
                            ? ListView.builder(
                          itemCount: heartListModel.heartLists.length,
                          itemBuilder: (context, index) {
                            final heartListItem = heartListModel.heartLists[index];
                            return Column(
                              children: [
                                FavoriteCard(
                                  item: heartListItem,
                                  heartListModel: heartListModel,
                                  userId: widget.userId,
                                  onDelete: (int wishIdx) {
                                    setState(() {
                                      heartListModel.heartLists.removeWhere((item) => item.wish_idx == wishIdx);
                                    });
                                  },
                                ),
                                SizedBox(height: 15),
                              ],
                            );
                          },
                        )
                            : Center(child: Text('마음에 담은 상품이 없습니다.')),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FavoriteCard extends StatefulWidget {
  final HeartList item;
  final HeartListModel heartListModel;
  final int userId;
  final Function(int) onDelete; // Callback for deletion


  const FavoriteCard({
    super.key,
    required this.item,
    required this.heartListModel,
    required this.userId,
    required this.onDelete,
  });

  @override
  _FavoriteCardState createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  late bool _isFavorited;

  @override
  void initState() {
    super.initState();
    _isFavorited = true; // Assuming it is initially favorited
  }

  Future<void> _toggleFavorite() async {
    print(widget.item.wish_idx);
    await HeartListHttp.deleteWish(widget.item.wish_idx); // Call HTTP delete method
    widget.onDelete(widget.item.wish_idx); // Notify parent to remove this card
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.item.i_image,
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.item.i_name,
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          height: 1.0,
                        ),
                        softWrap: true,
                      ),
                    ),
                    GestureDetector(
                      onTap: _toggleFavorite, // Call toggle favorite function
                      child: Column(
                        children: [
                          Icon(
                            _isFavorited ? Icons.favorite : Icons.favorite_outline,
                            size: 25,
                            color: _isFavorited ? Colors.red : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 22),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${widget.item.i_price}원~',
                    style: TextStyle(
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
