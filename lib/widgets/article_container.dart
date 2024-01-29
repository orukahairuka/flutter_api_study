import 'package:api_study/models/article.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:api_study/screens/article_screen.dart';


class ArticleContainer extends StatelessWidget {
  const ArticleContainer({
    super.key,
    required this.article,
  });
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => ArticleScreen(article: article)),
            ),
          );
        },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 36,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFF55C500),
          borderRadius: BorderRadius.all(
            Radius.circular(32),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //投稿日時
            Text(
              DateFormat('yyyy/MM/dd').format(article.createdAt),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            //タイトル
            Text(
              article.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            //タグ
            Text(
              '#${article.tags.join(' #')}', //文字列の配列をjoinで結合
              style: const TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //ハートアイコンといいね数
                Column(
                  children: [
                    const Icon(
                      Icons.favorite, //ハートアイコン
                      color: Colors.white,
                    ),
                    Text(
                  article.likesCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                  ],
                ),
                //投稿者のアイコンと登録者名
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(article.user.profileImageUrl),
                ),
                const SizedBox(height: 4),
                Text(
                  article.user.id,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
              ],
            ),
          ],
        ),
      ),
      ),
    );
  }
}
