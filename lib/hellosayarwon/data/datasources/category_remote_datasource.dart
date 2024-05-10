import '../../domain/entities/category.dart';
import '../../domain/entities/paras/get_categories_para.dart';
import '../../domain/entities/paras/get_category_para.dart';

abstract class CategoryRemoteDatasource {
  Future<List<Category>> getCategories( {required GetCategoriesPara getCategoriesPara});
  Future<Category> getCategory({required GetCategoryPara getCategoryPara});
}

class CategoryRemoteDatasourceImpl implements CategoryRemoteDatasource{
  @override
  Future<List<Category>> getCategories({required GetCategoriesPara getCategoriesPara}) {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<Category> getCategory({required GetCategoryPara getCategoryPara}) {
    // TODO: implement getCategory
    throw UnimplementedError();
  }
  
}