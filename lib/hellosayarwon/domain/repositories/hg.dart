

import 'package:dartz/dartz.dart';
import 'package:doublefive/domain/entities/transaction_with_pagination_entity.dart';

import '../../core/error/failures.dart';
import '../entities/article_entity.dart';
import '../entities/article_with_pagination_entity.dart';
import '../entities/transaction_info_entity.dart';


abstract class ArticleRepository{
  // CRUD
  Future<Either<Failure,List<Article>>> getArticles({required GetArticlesPara getArticlesPara});
  Future<Either<Failure, Article >> getArticle({required GetArticlePara getArticlePara});
  Future<Either<Failure, Article >> updateArticle({required UpdateArticlePara updateArticlePara});

  Future<Either<Failure,List<Category>>> getCategories({required GetCategoriesPara getCategoriesPara`});
  Future<Either<Failure, Category >> getCategory({required GetCategoryPara getCategoryPara});

}