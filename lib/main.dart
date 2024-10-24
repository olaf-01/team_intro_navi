import 'package:flutter/material.dart';
import 'team_dish.dart'; // 새로운 home_page.dart 파일을 import
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '어둠의 삼색조',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const IntroPage(),
    );
  }
}

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int _selectedNaviIndex = 0;
  bool _isIntroPage = true; // 처음에는 IntroPageContent가 보이게 설정

  void _onBottomNavigationItemTapped(int index) async {
    if (index == 0) {
      // Figma 버튼 클릭 시 외부 링크로 이동
      await _launchURL('https://www.figma.com');
    } else if (index == 2) {
      // Notion 버튼 클릭 시 외부 링크로 이동
      await _launchURL('https://www.notion.so');
    } else {
      // TeamDishPage로 페이지 변경
      setState(() {
        _selectedNaviIndex = index;
        _isIntroPage = false; // IntroPageContent에서 다른 페이지로 이동하게 설정
      });
    }
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isIntroPage
          ? IntroPageContent(
        onTapStart: () {
          setState(() {
            _isIntroPage = false; // 이미지 클릭 시 IntroPageContent를 종료하고 다른 페이지로 이동
          });
        },
      )
          : _getSelectedPage(), // 네비게이션 바에서 선택된 페이지를 표시
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedNaviIndex,
        onTap: _onBottomNavigationItemTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.art_track),
              label: "Figma"),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Team list"),
          BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: "Notion"),
        ],
      ),
    );
  }

  // 선택된 네비게이션 인덱스에 따라 페이지를 반환하는 함수
  Widget _getSelectedPage() {
    if (_selectedNaviIndex == 1) {
      return TeamDishPage(); // TeamDishPage로 연결
    } else {
      return Center(child: Text("Select a Page")); // 기본으로 표시할 텍스트
    }
  }
}

class IntroPageContent extends StatelessWidget {
  final VoidCallback onTapStart; // IntroPage에서 내부 페이지로 넘어가기 위한 콜백

  const IntroPageContent({super.key, required this.onTapStart});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 배경 이미지를 꽉 채워서 추가
        Image.asset(
          'images/background.png', // 배경 이미지 경로
          fit: BoxFit.cover, // 화면을 꽉 채우는 배경 이미지
          width: double.infinity,
          height: double.infinity,
        ),
        // 텍스트를 이미지 상단에 배치
        Positioned(
          top: 100, // 텍스트 위치를 이미지 상단으로 이동
          left: 0,
          right: 0,
          child: Text(
            '어둠의 냉장고', // 추가할 텍스트
            textAlign: TextAlign.center, // 텍스트 중앙 정렬
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontFamily: "Jindo",
              shadows: [
                Shadow( // 그림자 효과 추가
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(5.0, 5.0),
                ),
              ],
            ),
          ),
        ),
        // 중앙에 새로운 이미지 추가
        Center(
          child: GestureDetector(
            onTap: onTapStart, // 이미지를 누르면 IntroPage를 종료하고 내부 페이지로 이동
            child: Padding(
              padding: const EdgeInsets.only(top: 150), // 텍스트와 이미지 사이의 간격 조정
              child: Image.asset(
                'images/cover.png', // 가운데에 추가할 이미지 경로
                fit: BoxFit.contain,
                width: 450, // 이미지 가로 크기
                height: 700, // 이미지 세로 크기
              ),
            ),
          ),
        ),
      ],
    );
  }
}
