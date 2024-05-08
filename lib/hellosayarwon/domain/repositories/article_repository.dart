

import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../entities/article.dart';
import '../entities/category.dart';
import '../entities/paras/get_article_para.dart';
import '../entities/paras/get_articles_para.dart';
import '../entities/paras/get_categories_para.dart';
import '../entities/paras/get_category_para.dart';
import '../entities/paras/update_article_para.dart';



abstract class ArticleRepository{
  // CRUD
  Future<Either<Failure,List<Article>>> getArticles({required GetArticlesPara getArticlesPara});
  Future<Either<Failure, Article >> getArticle({required GetArticlePara getArticlePara});
  Future<Either<Failure, Article >> updateArticle({required UpdateArticlePara updateArticlePara}); // for favourite

  Future<Either<Failure,List<Category>>> getCategories({required GetCategoriesPara getCategoriesPara});
  Future<Either<Failure, Category >> getCategory({required GetCategoryPara getCategoryPara});

}