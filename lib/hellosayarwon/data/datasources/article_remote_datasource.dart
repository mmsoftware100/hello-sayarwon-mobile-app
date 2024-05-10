import '../../domain/entities/article.dart';
import '../../domain/entities/paras/get_article_para.dart';
import '../../domain/entities/paras/get_articles_para.dart';
import '../../domain/entities/paras/update_article_para.dart';

abstract class ArticleRemoteDatasource{
  // CRUD
  Future< List<Article>> getArticles({required GetArticlesPara getArticlesPara});
  Future< Article > getArticle({required GetArticlePara getArticlePara});
  Future< Article > updateArticle({required UpdateArticlePara updateArticlePara}); // for favourite
}

class ArticleRemoteDatasourceImpl implements ArticleRemoteDatasource{
  @override
  Future<Article> getArticle({required GetArticlePara getArticlePara}) {
    // TODO: implement getArticle
    throw UnimplementedError();
  }

  @override
  Future<List<Article>> getArticles({required GetArticlesPara getArticlesPara}) {
    // TODO: implement getArticles
    throw UnimplementedError();
  }

  @override
  Future<Article> updateArticle({required UpdateArticlePara updateArticlePara}) {
    // TODO: implement updateArticle
    throw UnimplementedError();
  }
  
}