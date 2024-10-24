import 'package:flutter/material.dart';
import 'package:team_app2/main.dart';
import 'membersDetail.dart';


class TeamDishPage extends StatelessWidget {
  const TeamDishPage({super.key});

  // 프로필 데이터 리스트
  final List<Map<String, dynamic>> profiles = const [
    {"name": "권하윤", "imagePath": 'images/하윤(2).png', "textColor": Colors.white},
    {"name": "임정현", "imagePath": 'images/정현(2).png', "textColor": Colors.white},
    {"name": "이하연", "imagePath": 'images/하연(2).png', "textColor": Colors.white},
    {"name": "김서현", "imagePath": 'images/서현(2).png', "textColor": Colors.white},
    {"name": "송민제", "imagePath": 'images/민제(2).png', "textColor": Colors.white},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: const Color(0xFF393939), // 전체 배경색을 어두운 회색으로 설정
        child: ListView.builder(
          itemCount: profiles.length,
          itemBuilder: (context, index) {
            return _buildProfile(
              context, // context를 전달합니다.
              profiles[index]["name"],
              profiles[index]["imagePath"],
              profiles[index]["textColor"],
            );
          },
        ),
      ),
    );
  }

  // 프로필 구성하는 위젯
  Widget _buildProfile(BuildContext context, String name, String imagePath, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0), // 각 프로필 사이에 간격 추가
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🐥', style: TextStyle(fontSize: 20)),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => membersDetail(name: name), // 클릭한 이름을 전달합니다.
                ),
              );
            },
            child: Image.asset(
              imagePath,
              width: 200, // 이미지의 가로 크기 설정
              height: 130, // 이미지의 세로 크기 설정
              fit: BoxFit.contain,
            ),
          ),
          Text(
            name,
            style: TextStyle(fontSize: 25, color: textColor, fontFamily: 'Free'), // 전달받은 텍스트 색상 사용
          ),
          const SizedBox(height: 30), // 각 프로필 사이에 간격 추가
        ],
      ),
    );
  }
}
