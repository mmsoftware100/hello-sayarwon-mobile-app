import 'package:hellosayarwon/hellosayarwon/data/const/constants.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/paras/get_categories_para.dart';
import '../../domain/entities/paras/get_category_para.dart';
import '../models/category_model.dart';
import '../third_party/network_interface.dart';

abstract class CategoryRemoteDatasource {
  Future<List<Category>> getCategories( {required GetCategoriesPara getCategoriesPara});
  Future<Category> getCategory({required GetCategoryPara getCategoryPara});
}

class CategoryRemoteDatasourceImpl implements CategoryRemoteDatasource{
  final NetworkInterface networkInterface;
  CategoryRemoteDatasourceImpl({required this.networkInterface});

  @override
  Future<List<Category>> getCategories({required GetCategoriesPara getCategoriesPara}) async {
    var map = {"page": getCategoriesPara.page};
    try {
      dynamic response = await networkInterface.getRequest(
          url: categoriesEndpoint,
          data: map,
          bearerToken: getCategoriesPara.accessToken
      );
      List<dynamic> data = response['data'];
      // Serialize Here
      List<Category> categories = [];
      for (int i = 0; i < data.length; i++) {
        try {
          categories.add(CategoryModel.fromJson(data[i]).toEntity());
        } catch (exp, stackTrace) {
          print(exp);
          print(stackTrace);
        }
      }
      return categories;
    } catch (e) {
      print(e.runtimeType);
      rethrow;
    }
  }

  @override
  Future<Category> getCategory({required GetCategoryPara getCategoryPara}) async {
    try {
      String endpoint = '$categoryEndpoint/${getCategoryPara.permalink}';
      dynamic response = await networkInterface.getRequest(
          url: endpoint,
          data: {},
          bearerToken: getCategoryPara.accessToken
      );
      var data = response['data'];
      return CategoryModel.fromJson(data).toEntity();
    } catch (e) {
      print(e.runtimeType);
      rethrow;
    }
  }
  
}