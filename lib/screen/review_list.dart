import 'package:flutter/material.dart';

class ReviewList extends StatefulWidget {
  const ReviewList({super.key});

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 32.0),
          child: Text(
            '리뷰',
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
        backgroundColor: Color(0xff0e4194),
      ),
      body: ListView.builder(
        itemCount: 10, // 예시로 10개의 리뷰 항목 생성
        itemBuilder: (context, index) => ReviewListItem(index: index),
      ),
    );
  }
}

class ReviewListItem extends StatelessWidget {
  final int index;

  const ReviewListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/review_detail'); // 리뷰 클릭 시 상세 화면으로 이동
      },
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://media.istockphoto.com/id/133909981/ko/%EC%82%AC%EC%A7%84/%EB%82%9C%EC%9F%81%EC%9D%B4-%ED%96%84%EC%8A%A4%ED%84%B0.jpg?s=1024x1024&w=is&k=20&c=bp9ixkktP66OlSqdGrOQl1DM4GOqP5g9v8SoVUBRYjk=', // 사용자 프로필 이미지 (예시)
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '사용자 ${index + 1}', // 예시 사용자 이름
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          for (var i = 0; i < 5; i++)
                            Icon(
                              i < 4 ? Icons.star : Icons.star_border,
                              size: 20,
                              color: Colors.amber,
                            ),
                          const SizedBox(width: 5),
                          Text('4.0'), // 예시 평점
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '다녀온장소',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '리뷰 내용 예시 ${index + 1}. 이곳에 사용자가 남긴 리뷰의 내용이 들어갑니다. 리뷰 내용이 길어질 경우, 자동으로 줄 바꿈이 됩니다.',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2, // 최대 2줄까지 표시
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://blog.kakaocdn.net/dn/T6eNa/btq7VxC5FDE/qUIYzH0wGfhfPVnN4zfaCk/img.jpg', // 리뷰 이미지 (예시)
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '작성일 ${DateTime.now().toLocal().toString().split(' ')[0]}', // 예시 작성 날짜
              style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w300,
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
