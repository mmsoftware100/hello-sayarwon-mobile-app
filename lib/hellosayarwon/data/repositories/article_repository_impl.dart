import 'package:dartz/dartz.dart';
import 'package:hellosayarwon/core/error/failures.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_article_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_articles_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/update_article_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository{
  @override
  Future<Either<Failure, Article>> getArticle({required GetArticlePara getArticlePara}) {
    // TODO: implement getArticle
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Article>>> getArticles({required GetArticlesPara getArticlesPara}) {
    // TODO: implement getArticles
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Article>> updateArticle({required UpdateArticlePara updateArticlePara}) {
    // TODO: implement updateArticle
    throw UnimplementedError();
  }

}