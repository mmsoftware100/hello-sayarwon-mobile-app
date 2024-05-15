import 'package:dartz/dartz.dart';
import 'package:hellosayarwon/core/error/failures.dart';
import 'package:hellosayarwon/hellosayarwon/data/datasources/article_local_datasource.dart';
import 'package:hellosayarwon/hellosayarwon/data/datasources/article_remote_datasource.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_article_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_articles_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/toggle_favourite_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/update_article_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/repositories/article_repository.dart';

import '../../../core/error/exceptions.dart';
import '../models/article_model.dart';

class ArticleRepositoryImpl implements ArticleRepository{
  ArticleRemoteDatasource articleRemoteDatasource;
  // local data source
  ArticleLocalDatasource articleLocalDatasource;

  ArticleRepositoryImpl({
    required this.articleRemoteDatasource,
    required this.articleLocalDatasource
  });


  @override
  Future<Either<Failure, Article>> getArticle({required GetArticlePara getArticlePara}) async{
    try{
      Article article = await articleRemoteDatasource.getArticle(getArticlePara: getArticlePara);
      // database store : (optional)
      try{
        // need to decide we should store or update
        // အခုအတိုင်းက duplicate မဖြစ်နိုင်ပေမယ့်၊ favourite တော့ ပျောက်သွားနိုင်တယ်။
        // ဒါမှ မဟုတ် id ရှိပြီးသားမို့လို့ reject လည်း လုပ်နိုင်တယ်။
        try{
          Article articleDb = await articleLocalDatasource.getArticle(id: article.id);
          // maintain local favourite property
          article.favourite = articleDb.favourite;
          // update
          await articleLocalDatasource.updateArticle(id: article.id, article: ArticleModel.fromEntity(article));
        }
        catch(exp,stackTrace){
          // do not effect on main business
          print("ArticleRepositoryImpl->getArticle articleLocalDatasource.getArticle exp");
          print(exp);
          print(stackTrace);
          // this is new version , so just store
          // ဒီ store ကို ဒီနားမှာပဲ handle လုပ်လည်း ရတာပဲ။ အခုတော့ အဝေးကြီးမှာ handle  လုပ်နေတယ် :P
          articleLocalDatasource.storeArticle(article: ArticleModel.fromEntity(article));
        }

      }
      catch(exp,stackTrace){
        // do not effect on main business
        print("ArticleRepositoryImpl->getArticle exp");
        print(exp);
        print(stackTrace);
      }
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

  // no need to call this business.
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

  @override
  Future<Either<Failure, Article>> toggleFavourite({required ToggleFavouritePara toggleFavouritePara}) async{
    // get detail
    // if not exist, store ? , or we already store during getArticle api response?
    // update favourite field
    // update article
    try{
      try{
        Article articleDb = await articleLocalDatasource.getArticle(id: toggleFavouritePara.article.id);
        // why ZERO
        print("ArticleRepositoryImpl->toggleFavourite ${toggleFavouritePara.article.id}  is ${articleDb.id}");
        // maintain local favourite property
        print("ArticleRepositoryImpl->toggleFavourite from ${articleDb.favourite} to ${articleDb.favourite == 1 ? 0 : 1 }");
        articleDb.favourite = articleDb.favourite == 1 ? 0 : 1 ;
        // update
        Article article = await articleLocalDatasource.updateArticle(id: articleDb.id, article: ArticleModel.fromEntity(articleDb));
        return right(article);
      }
      catch(exp,stackTrace){
        // do not effect on main business
        print("ArticleRepositoryImpl->getArticle articleLocalDatasource.getArticle exp");
        print(exp);
        print(stackTrace);
        rethrow;
      }
    }
    catch(exp,stackTrace){
      if(exp is SingleMessageException){
        return left(SingleMessageFailure(message: exp.message));
      }
      return left(DatabaseFailure());
    }
  }

}