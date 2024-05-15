

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hellosayarwon/hellosayarwon/data/datasources/article_local_datasource.dart';
import 'package:hellosayarwon/hellosayarwon/data/datasources/article_remote_datasource.dart';
import 'package:hellosayarwon/hellosayarwon/data/datasources/category_remote_datasource.dart';
import 'package:hellosayarwon/hellosayarwon/data/repositories/article_repository_impl.dart';
import 'package:hellosayarwon/hellosayarwon/data/repositories/category_repository_impl.dart';
import 'package:hellosayarwon/hellosayarwon/domain/repositories/article_repository.dart';
import 'package:hellosayarwon/hellosayarwon/domain/repositories/category_repository.dart';
import 'package:hellosayarwon/hellosayarwon/domain/usecases/articles/get_article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/usecases/articles/get_articles.dart';
import 'package:hellosayarwon/hellosayarwon/domain/usecases/articles/update_article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/usecases/categories/get_categories.dart';
import 'package:hellosayarwon/hellosayarwon/domain/usecases/categories/get_category.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/providers/article_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'hellosayarwon/data/const/constants.dart';
import 'hellosayarwon/data/third_party/network_interface.dart';

final sl = GetIt.instance;


Future<void> init() async {

  // Providers

  sl.registerFactory( () => ArticleProvider(
      getArticles: sl(),
      getArticle: sl(),
      updateArticle: sl()
  ));


  ///Use Cases
  sl.registerLazySingleton<GetArticles>(() => GetArticles(articleRepository: sl()));
  sl.registerLazySingleton<GetArticle>(() => GetArticle(articleRepository: sl()));
  sl.registerLazySingleton<UpdateArticle>(() => UpdateArticle(articleRepository: sl()));

  sl.registerLazySingleton<GetCategories>(() => GetCategories(categoryRepository: sl()));
  sl.registerLazySingleton<GetCategory>(() => GetCategory(categoryRepository: sl()));


  /// Repositories
  sl.registerLazySingleton<ArticleRepository>(() => ArticleRepositoryImpl(articleRemoteDatasource: sl(), articleLocalDatasource: sl()));
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(categoryRemoteDatasource: sl()));

  // Local Datasource
  sl.registerLazySingleton<ArticleLocalDatasource>(() => ArticleLocalDatasourceImpl(databaseInterface: sl()));

  ///  Remote Datasource
  sl.registerLazySingleton<ArticleRemoteDatasource>(() => ArticleRemoteDatasourceImpl(networkInterface: sl()));
  sl.registerLazySingleton<CategoryRemoteDatasource>(() => CategoryRemoteDatasourceImpl(networkInterface: sl()));

  ///Network
  sl.registerLazySingleton<NetworkInterface>(() => NetworkInterfaceImpl(client: sl()));
  // sl.registerLazySingleton<DatabaseInterface>(() => DatabaseInterfaceImpl(db: sl()));


  // Final Implementations
  sl.registerLazySingleton(() => Dio());

  /// Database Initialize
  final Database database = await openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) async{
        print("Database->onCreate");
        print(createArticleSql);
        await db.execute( createArticleSql );
        //print(createMarriedSql);
        //await db.execute( createMarriedSql );
      },
      version: dbVersion,
      onUpgrade: (db, oldVersion, currentVersion){
        print("Database->onUpgrade");
      },
      onDowngrade: (db, oldVersion, currentVersion){
        print("Database->onDowngrade");
      }
  );
  print(database);
  print(await database.getVersion());

  sl.registerLazySingleton<Database>(() => database);

}