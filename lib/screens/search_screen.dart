import 'package:api_study/widgets/article_container.dart';
import 'package:flutter/material.dart';

import 'dart:convert'; //json変換で必要
import 'package:http/http.dart' as http; // httpという変数を通して、httpパッケージにアクセス
import 'package:flutter_dotenv/flutter_dotenv.dart'; //秘匿したアクセストークンの取得に必要
import 'package:api_study/models/article.dart'; //作成済みのArticleモデルクラスをインポート
import 'package:api_study/models/user.dart'; //作成済みのUserモデルクラスをインポート
import '../widgets/article_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _serarchScreenState();
}

class _serarchScreenState extends State<SearchScreen> {
  List<Article> articles = []; //検索結果を格納するリスト
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 197, 59, 0),
        title: const Text('Qiita Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 36,
            ),
            child: TextField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                hintText: 'キーワードを入力してください',
              ),
              onSubmitted: (String value) async {
                final results = await searchQiita(value); //検索処理を実行する
                setState(() {
                  articles = results; //検索結果を更新する
                });
              },
            ),
          ),
          Expanded(
            child: ListView(
              children: articles
                  .map((article) => ArticleContainer(article: article))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<Article>> searchQiita(String keyword) async {
  // 1. http通信に必要なデータを準備をする
  final uri = Uri.https('qiita.com', '/api/v2/items', {
    'query': 'title:$keyword',
    'per_page': '10',
  });
  //アクセストークンを取得
  final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';


  // 2. Qiita APIにリクエストを送る
    final http.Response res = await http.get(uri, headers: {
      'Authorization': 'Bearer $token',
    });
  
  // 3. 戻り値をArticleクラスの配列に変換
  if (res.statusCode == 200) {
    final List<dynamic> body = jsonDecode(res.body);
      return body.map((dynamic json) => Article.fromJson(json)).toList();
  } else {
    return [];
  }
}
