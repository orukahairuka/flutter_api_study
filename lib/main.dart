import 'package:flutter/material.dart';
import 'package:api_study/screens/search_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // packageをインポート


Future<void> main() async {
  await dotenv.load(fileName: '.env'); // .envファイルを読み込み
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qiita Search',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'hiragino_kaku_gothic_pro',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF55C500),
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
            ),
      ),
      home: const SearchScreen(),
    );
  }
}
