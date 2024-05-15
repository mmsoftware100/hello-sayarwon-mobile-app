import 'package:hellosayarwon/hellosayarwon/data/const/constants.dart';
import 'package:hellosayarwon/hellosayarwon/data/third_party/network_interface.dart';

import '../../domain/entities/article.dart';
import '../../domain/entities/paras/get_article_para.dart';
import '../../domain/entities/paras/get_articles_para.dart';
import '../../domain/entities/paras/update_article_para.dart';
import '../models/article_model.dart';

abstract class ArticleRemoteDatasource {
  // CRUD
  Future<List<Article>> getArticles({required GetArticlesPara getArticlesPara});
  Future<Article> getArticle({required GetArticlePara getArticlePara});
  Future<Article> updateArticle(
      {required UpdateArticlePara updateArticlePara}); // for favourite
}

class ArticleRemoteDatasourceImpl implements ArticleRemoteDatasource {
  final NetworkInterface networkInterface;
  ArticleRemoteDatasourceImpl({required this.networkInterface});

  @override
  Future<Article> getArticle({required GetArticlePara getArticlePara}) async {
    try {
      String endpoint = '$articleEndpoint/${getArticlePara.permalink}';
      dynamic response = await networkInterface.getRequest(
          url: endpoint,
          data: {},
          bearerToken: getArticlePara.accessToken
      );
      var data = response['data']['post'];
      return ArticleModel.fromJson(data).toEntity();
    } catch (e) {
      print(e.runtimeType);
      rethrow;
    }
  }

  @override
  Future<List<Article>> getArticles( {required GetArticlesPara getArticlesPara}) async {
    /*
    var map = {
      "page": getArticlesPara.page
    };

     */
    try {
      String endPoint = articlesEndpoint;
      if(getArticlesPara.query.isNotEmpty){
        endPoint = articleSearchEndpoint;
      }
      dynamic response = await networkInterface.getRequest(
          url: endPoint,
          data: getArticlesPara.toJson(),
          bearerToken: getArticlesPara.accessToken
      );
      List<dynamic> data = response['data']['posts'];
      // Serialize Here
      List<Article> articles = [];
      for (int i = 0; i < data.length; i++) {
        try {
          articles.add(ArticleModel.fromJson(data[i]).toEntity());
        } catch (exp, stackTrace) {
          print(exp);
          print(stackTrace);
        }
      }
      return articles;
    } catch (e) {
      print(e.runtimeType);
      rethrow;
    }
  }

  @override
  Future<Article> updateArticle( {required UpdateArticlePara updateArticlePara}) {
    // TODO: implement updateArticle
    throw UnimplementedError();
  }
}
