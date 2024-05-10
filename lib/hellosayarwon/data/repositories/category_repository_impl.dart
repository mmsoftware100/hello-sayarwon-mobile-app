import 'package:dartz/dartz.dart';
import 'package:hellosayarwon/core/error/failures.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/category.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_categories_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_category_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository{
  @override
  Future<Either<Failure, List<Category>>> getCategories({required GetCategoriesPara getCategoriesPara}) {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Category>> getCategory({required GetCategoryPara getCategoryPara}) {
    // TODO: implement getCategory
    throw UnimplementedError();
  }
  
}