

import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../entities/article.dart';



abstract class ArticleRepository{
  // CRUD
  Future<Either<Failure,List<Article>>> getArticles({required GetArticlesPara getArticlesPara});
  Future<Either<Failure, Article >> getArticle({required GetArticlePara getArticlePara});
  Future<Either<Failure, Article >> updateArticle({required UpdateArticlePara updateArticlePara});

  Future<Either<Failure,List<Category>>> getCategories({required GetCategoriesPara getCategoriesPara`});
  Future<Either<Failure, Category >> getCategory({required GetCategoryPara getCategoryPara});

}