import 'package:flutter/material.dart'; // 외부 패키지 - 절대 경로가 좋음

class notionPage extends StatelessWidget {
  const notionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Notion",
                style:
                TextStyle(fontSize: 50),
        ),
      )
    );
  }
}