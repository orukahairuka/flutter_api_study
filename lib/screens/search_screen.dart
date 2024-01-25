import 'package:flutter/material.dart';

import 'dart:convert'; //json変換で必要
import 'package:http/http.dart' as http; // httpという変数を通して、httpパッケージにアクセス
import 'package:flutter_dotenv/flutter_dotenv.dart'; //秘匿したアクセストークンの取得に必要
import 'package:api_study/models/article.dart'; //作成済みのArticleモデルクラスをインポート

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _serarchScreenState();
}

class _serarchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 197, 59, 0),
        title: const Text('Qiita Search'),
      ),
      body: Container(),
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
  final String token = dotenv.env['QIITA_TOKEN'] ?? '';

  // 2. Qiita APIにリクエストを送る
  //アクセストークンを含めてリクエストを送信
  final http.Response res = await http.get(uri, headers: {
    'Authorization': 'Bearer $token',
  });
  // 3. 戻り値をArticleクラスの配列に変換
  if (res.statusCode == 200) {
  } else {
    return [];
  }
// 4. 変換したArticleクラスの配列を返す(returnする)
//レスポンスをモデルクラスへ変換
final List<dynamic>body = jsonDecode(res.body);
return body.map((dynamic json) => Article.fromJson(json)).toList();
}
