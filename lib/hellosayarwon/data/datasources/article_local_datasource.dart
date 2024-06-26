
import 'package:hellosayarwon/core/error/failures.dart';
import 'package:hellosayarwon/hellosayarwon/data/models/article_model.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_article_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_articles_para.dart';
import '../../../core/error/exceptions.dart';
import '../const/constants.dart';
import '../third_party/database_interface.dart';

abstract class ArticleLocalDatasource {
  Future<Article> storeArticle({required ArticleModel article});
  Future<Article> updateArticle({required int id,required ArticleModel article});
  Future<Article> deleteArticle({required int id});
  Future<Article> getArticle({required int id});
  Future<List<Article>> getArticleList({required GetArticlesPara getArticlesPara});
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
    print("ArticleLocalDatasource->getArticle $id");
    try{
      // success case
      dynamic response = await databaseInterface.getDetail(tableName: articleTableName, id: id, query: {});
      if(response == null){
        throw NoDataException();
      }
      print("ArticleLocalDatasource->getArticle response");
      print(response);
      print(response.runtimeType);
      // type '_Map<dynamic, dynamic>' is not a subtype of type 'Map<String, dynamic>'
      // ဒါက from json နဲ့ မရတော့ပဲ။ ရိုးရိုး model လို ဖြစ်နေပြီ။
      // database က ထွက်လာတာက model key တွေ အတိုင်းပဲ။
      // from db လို့ ရေးရမလိုပဲ။

      ArticleModel articleModel = ArticleModel.fromDb(response);
      print("successfully converted from db to article");
      print(articleModel.title);
      print(articleModel.id);
      return articleModel.toEntity(); // ArticleModel.fromJson(response).toEntity();
    }
    catch(e, stackTrace){
      print("ArticleLocalDatasource->getArticle serialize exp");
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
  Future<List<Article>> getArticleList({required GetArticlesPara getArticlesPara}) async{
    try{
      // success case
      Map<String, dynamic> map = {};
      if(getArticlesPara.favourite){
        map["favourite"] = 1;
      }
      dynamic response = await databaseInterface.getList(tableName: articleTableName, query: map ); // list of article maps
      print("ArticleLocalDatasourceImpl->getArticleList response");
      print(response);
      List<Article> articleList = [];
      for(int i=0; i< response.length; i++){
        articleList.add(ArticleModel.fromDb(response[i]).toEntity());
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
      print("ArticleLocalDatasource->updateArticle $id ${article.title} ${article.favourite}");
      dynamic response = await databaseInterface.update(tableName: articleTableName, data: article.toDbStore(), id: id); // update
      return ArticleModel.fromDb(response).toEntity();
    }
    catch(e, stackTrace){
      print(e.runtimeType);
      print(stackTrace);
      // TODO: should catch db exception
      throw SingleMessageException(message: e.toString());
    }
  }
}