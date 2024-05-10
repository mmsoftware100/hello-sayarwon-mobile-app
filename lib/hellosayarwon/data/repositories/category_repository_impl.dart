import 'package:dartz/dartz.dart';
import 'package:hellosayarwon/core/error/failures.dart';
import 'package:hellosayarwon/hellosayarwon/data/datasources/category_remote_datasource.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/category.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_categories_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_category_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/repositories/category_repository.dart';

import '../../../core/error/exceptions.dart';

class CategoryRepositoryImpl implements CategoryRepository{

  CategoryRemoteDatasource categoryRemoteDatasource;

  CategoryRepositoryImpl({
    required this.categoryRemoteDatasource
  });

  @override
  Future<Either<Failure, List<Category>>> getCategories({required GetCategoriesPara getCategoriesPara}) async{
    try{
      List<Category> categoryList = await categoryRemoteDatasource.getCategories(getCategoriesPara: getCategoriesPara);
      return right(categoryList);
    }
    catch(exp){
      if(exp is SingleMessageException){
        return left(SingleMessageFailure(message: exp.message));
      }
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Category>> getCategory({required GetCategoryPara getCategoryPara}) async{
    try{
      Category category = await categoryRemoteDatasource.getCategory(getCategoryPara: getCategoryPara);
      return right(category);
    }
    catch(exp){
      if(exp is SingleMessageException){
        return left(SingleMessageFailure(message: exp.message));
      }
      return left(ServerFailure());
    }
  }
  
}