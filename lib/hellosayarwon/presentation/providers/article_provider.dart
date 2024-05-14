import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:hellosayarwon/core/status/pagination.dart';
import 'package:hellosayarwon/core/status/status.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/category.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_article_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_articles_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/update_article_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/usecases/articles/update_article.dart';

import '../../../core/error/failures.dart';
import '../../domain/usecases/articles/get_article.dart';
import '../../domain/usecases/articles/get_articles.dart';

class ArticleProvider extends ChangeNotifier {
  // use case list
  GetArticles getArticles;
  GetArticle getArticle;
  UpdateArticle updateArticle;

  // constructor
  ArticleProvider(
      {required this.getArticles,
      required this.getArticle,
      required this.updateArticle});

  // Data repo
  /// Data List
  /// for home page
  List<Article> articles = [];
  Pagination articlesPagination = Pagination.sample;
  DataStatus articlesDataStatus = DataStatus.idle;
  SingleMessageFailure articlesSingleMessageFailure =
      SingleMessageFailure(message: "");

  /// Data Detail
  /// for detail page
  Article article = Article.sample;
  DataStatus articleDataStatus = DataStatus.idle;
  SingleMessageFailure articleSingleMessageFailure =
      SingleMessageFailure(message: "");


  /// for list by category page
  Category category = Category.sample;
  List<Article> articlesByCategory = [];
  Pagination articlesByCategoryPagination = Pagination.sample;
  DataStatus articlesByCategoryDataStatus = DataStatus.idle;
  SingleMessageFailure articlesByCategorySingleMessageFailure = SingleMessageFailure(message: "");


  /// for list by search page
  String searchKeyword = "";
  List<Article> articlesBySearch = [];
  Pagination articlesBySearchPagination = Pagination.sample;
  DataStatus articlesBySearchDataStatus = DataStatus.idle;
  SingleMessageFailure articlesBySearchSingleMessageFailure = SingleMessageFailure(message: "");

  // supplymentary methods
  void setArticleDetail(Article articleDetail){
    article = articleDetail;
    notifyListeners();
  }

  // main methods
  Future<bool> getArticlesPlz( {required GetArticlesPara getArticlesPara}) async {
    // before phase
    // update status
    articlesDataStatus = DataStatus.loading;
    if(getArticlesPara.page == 1){
      articles.clear();
    }
    notifyListeners();

    // doing business using use case
    final Either<Failure, List<Article>> articlesEither =
        await getArticles(getArticlesPara);

    // after phase
    return articlesEither.fold((failure) {
      // failure phase
      articlesDataStatus = DataStatus.error;
      if(failure is SingleMessageFailure){
        articlesSingleMessageFailure = failure;
      }
      // တစ်ခြား exception တွေ ဆိုရင်တော့ Something went wrong လို့ပဲ မှတ်လိုက်မလား
      else{
        articlesSingleMessageFailure = SingleMessageFailure(message: "Something went wrong @p");
      }
      notifyListeners();
      return false;
    }, (articlesFromServer) {
      // success phase
      print("get articles from server ");
      print(articlesFromServer.length);
      articlesDataStatus = DataStatus.data;
      articles.addAll(articlesFromServer);
      print(articles.length);
      articlesPagination.currentPage = getArticlesPara.page + 1;
      notifyListeners();
      return true;
    });
  }

  Future<bool> getArticlePlz({required GetArticlePara getArticlePara}) async {
    // before phase
    // update status
    articleDataStatus = DataStatus.loading;
    notifyListeners();

    // doing business using use case

    final Either<Failure, Article> articleEither =
        await getArticle(getArticlePara);
    return articleEither.fold((failure) {
      // failure phase
      articleDataStatus = DataStatus.error;
      if(failure is SingleMessageFailure){
        articleSingleMessageFailure = failure;
      }
      // တစ်ခြား exception တွေ ဆိုရင်တော့ Something went wrong လို့ပဲ မှတ်လိုက်မလား
      else{
        articleSingleMessageFailure = SingleMessageFailure(message: "Something went wrong @p");
      }
      notifyListeners();

      return false;
    }, (articleDetail) {
      // success phase
      articleDataStatus = DataStatus.data;
      article = articleDetail;
      notifyListeners();

      return true;
    });
  }

  Future<bool> updateArticlePlz( {required UpdateArticlePara updateArticlePara}) async {
    // before phase
    // update status
    articleDataStatus = DataStatus.loading;
    notifyListeners();

    // doing business using use case

    final Either<Failure, Article> articleEither =
        await updateArticle(updateArticlePara);
    return articleEither.fold((failure) {

      // failure phase
      articleDataStatus = DataStatus.error;
      if(failure is SingleMessageFailure){
        articleSingleMessageFailure = failure;
      }
      // တစ်ခြား exception တွေ ဆိုရင်တော့ Something went wrong လို့ပဲ မှတ်လိုက်မလား
      else{
        articleSingleMessageFailure = SingleMessageFailure(message: "Something went wrong @p");
      }
      notifyListeners();

      return false;
    }, (articleUpdate) {
      // success phase
      articleDataStatus = DataStatus.data;
      article = articleUpdate;
      notifyListeners();

      return true;
    });
  }

  // life cycle methods (helpers) data တစ်ခုရဲ့ Life Cycle အပြည့်ဖြစ်အောင် ကူညီပေးမယ့် methods တွေ။
  // လောလောဆယ် လိုသလောက်ပဲ အရင်ရေးထားမယ်။ Presentation ဘက်ကို သွားမယ်။

  List<Article> getRandomArticles(){
    // Create an instance of Random class
    Random random = Random();

    // Create an empty list to store random elements
    List<Article> randomElements = [];

    // Get 3 random elements
    for (int i = 0; i < 5; i++) {
      // Get a random index
      int randomIndex = random.nextInt(articles.length);

      // Get the random item from the list
      Article article = articles[randomIndex];

      // Add the random item to the list of random elements
      randomElements.add(article);
    }
    return randomElements;
  }
}
