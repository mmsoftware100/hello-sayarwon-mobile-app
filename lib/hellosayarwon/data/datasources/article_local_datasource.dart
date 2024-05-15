
import 'package:hellosayarwon/core/error/failures.dart';
import 'package:hellosayarwon/hellosayarwon/data/models/article_model.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_article_para.dart';
import '../../../core/error/exceptions.dart';
import '../const/constants.dart';
import '../third_party/database_interface.dart';

abstract class ArticleLocalDatasource {
  Future<Article> storeArticle({required ArticleModel article});
  Future<Article> updateArticle({required int id,required ArticleModel article});
  Future<Article> deleteArticle({required int id});
  Future<Article> getArticle({required int id});
  Future<List<Article>> getArticleList({required GetArticlePara getArticlePara});
}


// ပေးတဲ့ JSON လေးကိုပဲ db ထဲ insert လုပ်မှာလား?
// Model ပေးတာကို insert လုပ်ဉီးမှာလား?
// serialization က ဒီမှာလုပ်မှာလား
// မစဉ်းစားနိုင်ရင် တစ်နေရာမှာ လုပ်လိုက်။ ပြီးမှ refactor လုပ်ကြမယ်။
// Make it work.
class ArticleLocalDatasourceImpl implements ArticleLocalDatasource{


  final DatabaseInterface databaseInterface;
  ArticleLocalDatasourceImpl({required this.databaseInterface});

  @override
  Future<Article> deleteArticle({required int id}) {
    // TODO: implement deleteArticle
    throw UnimplementedError();
  }

  @override
  Future<Article> getArticle({required int id}) async{
    try{
      // success case
      dynamic response = await databaseInterface.getDetail(tableName: articleTableName, id: id, query: {});
      if(response == null){
        throw NoDataException();
      }
      return ArticleModel.fromJson(response).toEntity();
    }
    catch(e, stackTrace){
      print(e.runtimeType);
      print(e);
      print(stackTrace);
      // TODO: should catch db exception
      if(e is NoDataException){
        throw SingleMessageException(message: "No data found");
      }
      throw SingleMessageException(message: e.toString());
    }
  }

  @override
  Future<List<Article>> getArticleList({required GetArticlePara getArticlePara}) async{
    try{
      // success case
      dynamic response = await databaseInterface.getList(tableName: articleTableName, query: {}); // list of article maps
      print("ArticleLocalDatasourceImpl->getArticleList response");
      print(response);
      List<Article> articleList = [];
      for(int i=0; i< response.length; i++){
        articleList.add(ArticleModel.fromJson(response[i]).toEntity());
      }
      return articleList;
    }
    catch(e, stackTrace){
      print(e.runtimeType);
      print(stackTrace);
      // TODO: should catch db exception
      throw SingleMessageException(message: e.toString());
    }
  }

  @override
  Future<Article> storeArticle({required ArticleModel article}) async{
    try{
      dynamic response = await databaseInterface.store(tableName: articleTableName, data: article.toDbStore()); // inserted json map
      return ArticleModel.fromJson(response).toEntity();
    }
    catch(e, stackTrace){
      print(e.runtimeType);
      print(stackTrace);
      // TODO: should catch db exception
      throw SingleMessageException(message: e.toString());
    }
  }

  @override
  Future<Article> updateArticle({required int id, required ArticleModel article}) async{
    try{
      dynamic response = await databaseInterface.update(tableName: articleTableName, data: article.toDbStore(), id: id); // update
      return ArticleModel.fromJson(response).toEntity();
    }
    catch(e, stackTrace){
      print(e.runtimeType);
      print(stackTrace);
      // TODO: should catch db exception
      throw SingleMessageException(message: e.toString());
    }
  }
}