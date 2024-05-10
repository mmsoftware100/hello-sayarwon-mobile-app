

import 'package:get_it/get_it.dart';
import 'package:hellosayarwon/hellosayarwon/domain/repositories/article_repository.dart';
import 'package:hellosayarwon/hellosayarwon/domain/repositories/category_repository.dart';
import 'package:hellosayarwon/hellosayarwon/domain/usecases/articles/get_article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/usecases/articles/get_articles.dart';
import 'package:hellosayarwon/hellosayarwon/domain/usecases/articles/update_article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/usecases/categories/get_categories.dart';
import 'package:hellosayarwon/hellosayarwon/domain/usecases/categories/get_category.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/providers/article_provider.dart';

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
  sl.registerLazySingleton<GetArticles>(() => GetArticles(articleRepository: sl()));
  sl.registerLazySingleton<UpdateArticle>(() => UpdateArticle(articleRepository: sl()));

  sl.registerLazySingleton<GetCategories>(() => GetCategories(categoryRepository: sl()));
  sl.registerLazySingleton<GetCategory>(() => GetCategory(categoryRepository: sl()));




  //
  // /// Repositories
  // sl.registerLazySingleton<ArticleRepository>(() => MirrorArticleRepositoryImpl(mirrorArticleRemoteDatasource: sl(), mirrorArticleLocalDatasource: sl()));
  // sl.registerLazySingleton<CategoryRepository>(() => UserRepositoryImpl(userRemoteDatasource: sl()));
  // sl.registerLazySingleton<FriendRepository>(() => FriendRepositoryImpl(friendRemoteDatasource: sl()));
  // sl.registerLazySingleton<ChatGroupRepository>(() => ChatGroupRepositoryImpl(chatGroupRemoteDatasource: sl()));
  //
  //
  // sl.registerLazySingleton<UserOldRepository>(() => OldUserRepositoryImpl(userRemoteDataSource: sl()));
  //
  // sl.registerLazySingleton<FundRiserRepository>(() => FundRiserRepositoryImpl(fundRiserRemoteDataSource: sl()));
  //
  // sl.registerLazySingleton<DashboardInfoRepository>(() => DashboardInfoRepositoryImpl(dashboardInfoRemoteDataSource: sl()));
  //
  // sl.registerLazySingleton<TransactionInfoRepository>(() => TransactionInfoRepositoryImpl(transactionInfoRemoteDataSource: sl()));
  //
  // sl.registerLazySingleton<FeatureFlagRepository>(() => FeatureFlagRepositoryImpl(featureFlagRemoteDataSource: sl()));
  //
  // sl.registerLazySingleton<ProfilesRepository>(() => ProfilesRepositoryImpl(profileRemoteDataSource: sl()));
  //
  // sl.registerLazySingleton<StateRepository>(() => StateRepositoryImpl(stateRemoteDataSource: sl()));
  //
  // sl.registerLazySingleton<CheckPointRepository>(() => CheckPointRepositoryImpl(checkPointRemoteDataSource: sl()));
  //
  // sl.registerLazySingleton<ArticleRepository>(() => ArticleRepositoryImpl(articleRemoteDataSource: sl()));
  //
  // sl.registerLazySingleton<VoteRepository>(() => VoteRepositoryImpl(voteRemoteDataSource: sl()));
  //
  // sl.registerLazySingleton<CommentRepository>(() => CommentRepositoryImpl(commentRemoteDataSource: sl()));
  //
  //
  //
  //
  //
  //
  //
  // // Local Datasource
  // sl.registerLazySingleton<MirrorArticleLocalDatasource>(() => MirrorArticleLocalDatasourceImpl(databaseInterface: sl()));
  //
  //
  // ///  Remote Datasource
  // sl.registerLazySingleton<MirrorArticleRemoteDatasource>(() => MirrorArticleRemoteDatasourceImpl(networkInterface: sl()));
  // sl.registerLazySingleton<UserRemoteDatasource>(() => UserRemoteDatasourceImpl(networkInterface: sl()));
  // sl.registerLazySingleton<FriendRemoteDatasource>(() => FriendRemoteDatasourceImpl(networkInterface: sl()));
  // sl.registerLazySingleton<ChatGroupRemoteDatasource>(() => ChatGroupRemoteDatasourceImpl(networkInterface: sl()));
  //
  // sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(networkInterface: sl()));
  //
  // sl.registerLazySingleton<FundRiserRemoteDataSource>(() => FundRiserRemoteDataSourceImpl(networkInterface: sl()));
  //
  // sl.registerLazySingleton<DashboardInfoRemoteDataSource>(() => DashboardInfoRemoteDataSourceImpl(networkInterface: sl()));
  //
  // sl.registerLazySingleton<TransactionInfoRemoteDataSource>(() => TransactionInfoRemoteDataSourceImpl(networkInterface: sl()));
  //
  // sl.registerLazySingleton<FeatureFlagRemoteDataSource>(() => FeatureFlagRemoteDataSourceImpl(networkInterface: sl()));
  //
  // sl.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl(networkInterface: sl()));
  //
  // sl.registerLazySingleton<StateRemoteDataSource>(() => StateRemoteDataSourceImpl(networkInterface: sl()));
  //
  // sl.registerLazySingleton<CheckPointRemoteDataSource>(() => CheckPointRemoteDataSourceImpl(networkInterface: sl()));
  //
  // sl.registerLazySingleton<ArticleRemoteDataSource>(() => ArticleRemoteDataSourceImpl(networkInterface: sl()));
  //
  // sl.registerLazySingleton<VoteRemoteDataSource>(() => VoteRemoteDataSourceImpl(networkInterface: sl()));
  //
  // sl.registerLazySingleton<CommentRemoteDataSource>(() => CommentRemoteDataSourceImpl(networkInterface: sl()));
  //
  //
  //
  //
  //
  //
  //
  //
  // ///Network
  // sl.registerLazySingleton<NetworkInterface>(() => NetworkInterfaceImpl(client: sl()));
  // sl.registerLazySingleton<DatabaseInterface>(() => DatabaseInterfaceImpl(db: sl()));
  //
  //
  // // Final Implementations
  // sl.registerLazySingleton(() => Dio());
  // /// Database Initialize
  // final Database database = await openDatabase(
  //     join(await getDatabasesPath(), dbName),
  //     onCreate: (db, version) async{
  //       print("Database->onCreate");
  //       print(createArticleSql);
  //       await db.execute( createArticleSql );
  //       //print(createMarriedSql);
  //       //await db.execute( createMarriedSql );
  //     },
  //     version: dbVersion,
  //     onUpgrade: (db, oldVersion, currentVersion){
  //       print("Database->onUpgrade");
  //     },
  //     onDowngrade: (db, oldVersion, currentVersion){
  //       print("Database->onDowngrade");
  //     }
  // );
  // print(database);
  // print(await database.getVersion());
  //
  // sl.registerLazySingleton<Database>(() => database);

}