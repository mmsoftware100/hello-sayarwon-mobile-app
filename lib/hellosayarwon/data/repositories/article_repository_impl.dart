import 'package:dartz/dartz.dart';
import 'package:hellosayarwon/core/error/failures.dart';
import 'package:hellosayarwon/hellosayarwon/data/datasources/article_remote_datasource.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_article_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_articles_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/update_article_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/repositories/article_repository.dart';

import '../../../core/error/exceptions.dart';

class ArticleRepositoryImpl implements ArticleRepository{
  ArticleRemoteDatasource articleRemoteDatasource;

  ArticleRepositoryImpl({
    required this.articleRemoteDatasource
  });


  @override
  Future<Either<Failure, Article>> getArticle({required GetArticlePara getArticlePara}) async{
    try{
      Article article = await articleRemoteDatasource.getArticle(getArticlePara: getArticlePara);
      return right(article);
    }
    catch(exp){
      if(exp is SingleMessageException){
        return left(SingleMessageFailure(message: exp.message));
      }
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getArticles({required GetArticlesPara getArticlesPara}) async{
    try{
      List<Article> articleList = await articleRemoteDatasource.getArticles(getArticlesPara: getArticlesPara);
      return right(articleList);
    }
    catch(exp){
      if(exp is SingleMessageException){
        return left(SingleMessageFailure(message: exp.message));
      }
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Article>> updateArticle({required UpdateArticlePara updateArticlePara}) async{
    try{
      Article article = await articleRemoteDatasource.updateArticle(updateArticlePara: updateArticlePara);
      return right(article);
    }
    catch(exp){
      if(exp is SingleMessageException){
        return left(SingleMessageFailure(message: exp.message));
      }
      return left(ServerFailure());
    }
  }

}