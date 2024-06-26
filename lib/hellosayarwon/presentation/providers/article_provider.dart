import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:hellosayarwon/core/status/pagination.dart';
import 'package:hellosayarwon/core/status/status.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/category.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_article_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_articles_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/toggle_favourite_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/update_article_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/usecases/articles/update_article.dart';

import '../../../core/error/failures.dart';
import '../../domain/usecases/articles/get_article.dart';
import '../../domain/usecases/articles/get_articles.dart';
import '../../domain/usecases/articles/toggle_favourite.dart';

class ArticleProvider extends ChangeNotifier {
  // use case list
  GetArticles getArticles;
  GetArticle getArticle;
  UpdateArticle updateArticle;
  ToggleFavourite toggleFavourite;

  // constructor
  ArticleProvider({
    required this.getArticles,
    required this.getArticle,
    required this.updateArticle,
    required this.toggleFavourite
  });

  // Data repo
  /// Data List
  /// for home page
  List<Article> articles = [];
  Pagination articlesPagination = Pagination.sample;
  DataStatus articlesDataStatus = DataStatus.idle;
  SingleMessageFailure articlesSingleMessageFailure = SingleMessageFailure(message: "");


  /// for favourite list
  List<Article> articlesByFavourite = [];
  Pagination articlesByFavouritePagination = Pagination.sample;
  DataStatus articlesByFavouriteDataStatus = DataStatus.idle;
  SingleMessageFailure articlesByFavouriteSingleMessageFailure = SingleMessageFailure(message: "");


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
  void setCategoryDetail(Category categoryDetail){
    category = categoryDetail;
    // ဘယ်ချိန် Clear လုပ်မလဲ? စဉ်းစားထားရန်။
    // နောက် state က ဘယ်ဟာ သုံးမလဲ?
    // articles ကိုပဲ ဆက်သုံးကြမလား?
    // state ခွဲရင် method ခွဲရမလား?
    // ခွဲရင် method တွေ များလာမှာ ၊ မခွဲရင် method တစ်ခုက state နှစ်ခု သုံးခုကို ကိုင်တွယ်ရမယ်။
    // articles.clear();
    articlesByCategory.clear();
    // လက်ရှိ state တစ်ခုပဲ သုံးတာပေါ့။

    notifyListeners();
  }

  void setSearchKeyword(String query){
    searchKeyword = query;
    notifyListeners();
  }

  // main methods
  Future<bool> getArticlesPlz( {required GetArticlesPara getArticlesPara}) async {
    print("ArticleProvider->getArticlesPlz ${getArticlesPara.favourite}");

    print("ArticleProvider->getArticlesPlz favourite ${getArticlesPara.favourite}");
    // before phase
    // update status
    if(getArticlesPara.page == 1 && getArticlesPara.favourite == false && getArticlesPara.categoryId == 0 && getArticlesPara.query.isEmpty){
      print("main listing cleared");
      articlesDataStatus = DataStatus.loading;
      articles.clear();
      articlesPagination.currentPage = 1; // refresh
    }
    if(getArticlesPara.page == 1 && getArticlesPara.favourite == true && getArticlesPara.categoryId == 0 && getArticlesPara.query.isEmpty){
      print("fav listing cleared");
      articlesByFavouriteDataStatus = DataStatus.loading;
      articlesByFavourite.clear();
    }
    if(getArticlesPara.page == 1 && getArticlesPara.categoryId > 0 && getArticlesPara.query.isEmpty){
      print("category listing cleared");
      articlesByCategoryDataStatus = DataStatus.loading;
      articlesByCategory.clear();
    }
    // search
    if(getArticlesPara.page == 1 && getArticlesPara.favourite == false && getArticlesPara.categoryId == 0 && getArticlesPara.query.isNotEmpty){
      print("main listing cleared");
      articlesBySearchDataStatus = DataStatus.loading;
      articlesBySearch.clear();
      articlesBySearchPagination.currentPage = 1; // refresh
    }

    notifyListeners();

    // await Future.delayed(Duration(seconds: 5));

    // doing business using use case
    final Either<Failure, List<Article>> articlesEither =
        await getArticles(getArticlesPara);

    // after phase
    return articlesEither.fold((failure) {
      // failure phase
      articlesDataStatus = DataStatus.error;
      // category listing ကို failure ရမလား?
      // main listing ကို failure ရမလား
      // နည်းနည်း နက်နဲ့သွားပြီ။
      if(failure is SingleMessageFailure){
        articlesSingleMessageFailure = failure;
        // main listing
        if(getArticlesPara.favourite == false && getArticlesPara.categoryId == 0){
          articlesDataStatus = DataStatus.error;
          articlesSingleMessageFailure = failure;
        }
        // fav listing
        if(getArticlesPara.favourite == true && getArticlesPara.categoryId == 0){
          articlesByFavouriteDataStatus = DataStatus.error;
          articlesByFavouriteSingleMessageFailure = failure;
        }
        // category listing
        if(getArticlesPara.categoryId > 0){
          articlesByCategoryDataStatus = DataStatus.error;
          articlesByCategorySingleMessageFailure = failure;
        }

      }
      // တစ်ခြား exception တွေ ဆိုရင်တော့ Something went wrong လို့ပဲ မှတ်လိုက်မလား
      else{
        failure = SingleMessageFailure(message: "Something went wrong @p");
        articlesSingleMessageFailure = failure;
        // main listing
        if(getArticlesPara.favourite == false && getArticlesPara.categoryId == 0){
          articlesDataStatus = DataStatus.error;
          articlesSingleMessageFailure = failure;
        }
        // fav listing
        if(getArticlesPara.favourite == true && getArticlesPara.categoryId == 0){
          articlesByFavouriteDataStatus = DataStatus.error;
          articlesByFavouriteSingleMessageFailure = failure;
        }
        // category listing
        if(getArticlesPara.categoryId > 0){
          articlesByCategoryDataStatus = DataStatus.error;
          articlesByCategorySingleMessageFailure = failure;
        }

      }
      notifyListeners();
      return false;
    }, (articlesFromServer) {
      // success phase
      print("get articles from server ");
      print(articlesFromServer.length);
      // articlesDataStatus = DataStatus.data;
      // ဘယ်မှာ သွားထည့်ကြမလဲ
      // method တစ်ခုက state (၃) ခုကို ထိမ်းသောအခါ
      // favourite listing
      if(getArticlesPara.favourite){
        articlesByFavouriteDataStatus = DataStatus.data;
        articlesByFavourite.addAll(articlesFromServer);
        articlesByFavouritePagination.currentPage = getArticlesPara.page + 1;
      }
      // main listing
      if(getArticlesPara.favourite == false && getArticlesPara.categoryId == 0){
        articlesDataStatus = DataStatus.data;
        articlesPagination.currentPage = getArticlesPara.page + 1;
        articles.addAll(articlesFromServer);
      }
      // category listing
      if(getArticlesPara.favourite == false && getArticlesPara.categoryId > 0){
        articlesByCategoryDataStatus = DataStatus.data;
        articlesByCategoryPagination.currentPage = getArticlesPara.page + 1;
        articlesByCategory.addAll(articlesFromServer);
      }
      // search
      if(getArticlesPara.favourite == false && getArticlesPara.categoryId == 0 && getArticlesPara.query.isNotEmpty){
        articlesBySearchDataStatus = DataStatus.data;
        articlesBySearch.addAll(articlesFromServer);
        articlesBySearchPagination.currentPage = getArticlesPara.page + 1;
      }

      // print(articles.length);
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


  Future<bool> toggleFavouritePlz( {required ToggleFavouritePara toggleFavouritePara}) async {
    print("ArticleProvider->toggleFavouritePlz");
    print("${toggleFavouritePara.article.id} to ${toggleFavouritePara.article.favourite}");

    // before phase
    // update status
    articleDataStatus = DataStatus.loading;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1));

    // doing business using use case
    final Either<Failure, Article> articleEither = await toggleFavourite(toggleFavouritePara);
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
      print("ArticleProvider->toggleFavouritePlz success");
      print(articleUpdate.title);
      print(articleUpdate.description);

      articleDataStatus = DataStatus.data;
      print("articleUpdate is ${articleUpdate.favourite}");
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
    for (int i = 0; i < ( articlesByCategory.length > 5 ? 5 : articlesByCategory.length ); i++) {
      // Get a random index
      int randomIndex = random.nextInt(articlesByCategory.length);

      // Get the random item from the list
      Article article = articlesByCategory[randomIndex];

      // Add the random item to the list of random elements
      randomElements.add(article);
    }
    return randomElements;
  }
}
