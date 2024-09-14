import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/store_model.dart';
import '../model/user_model.dart';
import '../vo/store.dart';
import '../vo/user.dart';

class AiRecommendScreen extends StatefulWidget {
  const AiRecommendScreen({super.key});

  @override
  State<AiRecommendScreen> createState() => _AiRecommendScreenState();
}

class _AiRecommendScreenState extends State<AiRecommendScreen> {

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('------------------------------------');
    int loginUserIdx = Provider.of<UserModel>(context,listen: false).loggedInUser.u_idx;
    Provider.of<StoreModel>(context, listen: false).fetchRecommendStores(loginUserIdx);
  }

  @override
  Widget build(BuildContext context) {
    User loginUser = Provider.of<UserModel>(context).loggedInUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              SizedBox(height: 60),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${loginUser.u_nick}님께\n추천하는 상점 LIST',
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Consumer<StoreModel>(builder: (context, storeModel, child) {
                // stores 리스트가 비어있으면 빈 상태 표시
                if (storeModel.recommendstores.isEmpty) {
                  return Text(
                    '추천할 상점이 없습니다.',
                    style: TextStyle(fontSize: 16),
                  );
                }
                // stores 리스트가 있으면 목록을 표시
                return Column(
                  children: storeModel.recommendstores
                      .map((store) => StoreRecommendList(store: store))
                      .toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class StoreRecommendList extends StatelessWidget {
  final Store store;

  StoreRecommendList({required this.store, super.key});

  String _formatAddress(String address) {
    final parts = address.split(' ');

    if (parts.length >= 3) {
      return '${parts[0]} ${parts[1]}';
    }

    return address;
  }

  String _mapTypeToString(int type) {
    switch (type) {
      case 1:
        return '호텔';
      case 2:
        return '테마파크';
      case 3:
        return '액티비티';
      case 4:
        return '전시회';
      default:
        return '기타';
    }
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber[600]!; // 첫 번째 아이템은 노란색 배경
      case 2:
        return Colors.grey[600]!;   // 두 번째 아이템은 회색 배경
      case 3:
        return Colors.brown;  // 세 번째 아이템은 갈색 배경
      default:
        return Colors.black;  // 나머지는 검은색 배경
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => ItemDetailScreen(item: item)),
        // );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // 그림자 색상
                spreadRadius: 2, // 그림자 퍼짐 정도
                blurRadius: 6, // 그림자 흐림 정도
                offset: Offset(0, 2), // 그림자의 위치
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                child: Image.network(
                  '${store.s_img}',
                  width: double.infinity,
                  height: 162,
                  fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${store.s_name}',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              height: 1.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.storefront,
                              size: 20,
                              color: Colors.amber,
                            ),
                            Text(
                              ' ${_formatAddress(store.s_address)}',
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
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

