

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:hellosayarwon/core/status/status.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_article_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_articles_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/usecases/articles/update_article.dart';

import '../../../core/error/failures.dart';
import '../../domain/usecases/articles/get_article.dart';
import '../../domain/usecases/articles/get_articles.dart';

class ArticleProvider extends ChangeNotifier{

  //use case list
  GetArticles getArticles;
  GetArticle getArticle;
  UpdateArticle updateArticle;

  //constructor
  ArticleProvider({
    required this.getArticles,
    required this.getArticle,
    required this.updateArticle
  });

  //Data repo
  List<Article> articles = [];
  DataStatus articlesDataStatus = DataStatus.idle;
  SingleMessageFailure articleSingleMessageFailure = SingleMessageFailure(message: "");

  Future<bool> getArticlesPlz({required GetArticlesPara getArticlesPara})async{
    final Either<Failure,List<Article>> articlesEither = await getArticles(getArticlesPara);
    return articlesEither.fold( (failure) { return false; }, (articleWithPaginationData) { return true; });
  }

}