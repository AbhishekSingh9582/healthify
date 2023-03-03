import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/article.dart';

class ArticleProvider with ChangeNotifier {
  List<Article>? _articles = [];

  List<Article> get getArticle {
    return [..._articles!];
  }

  Future<List<Article>> fetchArticle() async {
    List<Article> lst = [];
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('article').get();
      snapshot.docs.forEach((element) {
        lst.add(Article.fromJson(element.data()));
      });
      _articles = lst;
      print('${lst.length}');
    } catch (error) {
      print('$error');
    }
    return lst;
  }
}
