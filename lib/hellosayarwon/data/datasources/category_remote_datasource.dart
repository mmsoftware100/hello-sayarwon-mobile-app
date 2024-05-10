import '../../domain/entities/category.dart';
import '../../domain/entities/paras/get_categories_para.dart';
import '../../domain/entities/paras/get_category_para.dart';

abstract class CategoryRepository{
  Future< List<Category>>  getCategories({required GetCategoriesPara getCategoriesPara});
  Future<  Category >  getCategory({required GetCategoryPara getCategoryPara});
}