import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:hellosayarwon/core/status/pagination.dart';
import 'package:hellosayarwon/core/status/status.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/category.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_article_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_articles_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_categories_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_category_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/update_article_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/usecases/articles/update_article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/usecases/categories/get_category.dart';

import '../../../core/error/failures.dart';
import '../../domain/usecases/articles/get_article.dart';
import '../../domain/usecases/articles/get_articles.dart';
import '../../domain/usecases/categories/get_categories.dart';

class CategoryProvider extends ChangeNotifier {
  // use case list
  GetCategories getCategories;
  GetCategory getCategory;


  // constructor
  CategoryProvider({required this.getCategories, required this.getCategory });

  // Data repo
  /// Data List
  /// for home page
  List<Category> categories = [];
  Pagination categoriesPagination = Pagination.sample;
  DataStatus categoriesDataStatus = DataStatus.idle;
  SingleMessageFailure categoriesSingleMessageFailure = SingleMessageFailure(message: "");


  /// for list by category page
  Category category = Category.sample;
  DataStatus categoryDataStatus = DataStatus.idle;
  SingleMessageFailure categorySingleMessageFailure = SingleMessageFailure(message: "");


  // supplymentary methods
  void setCategoryDetail(Category categoryDetail){
    category = categoryDetail;
    notifyListeners();
  }

  // main methods
  Future<bool> getCategoriesPlz( {required GetCategoriesPara getCategoriesPara}) async {
    // before phase
    // update status
    categoriesDataStatus = DataStatus.loading;
    if(getCategoriesPara.page == 1){
      categories.clear();
    }
    notifyListeners();

    // doing business using use case
    final Either<Failure, List<Category>> categoriesEither = await getCategories(getCategoriesPara);

    // after phase
    return categoriesEither.fold((failure) {
      // failure phase
      categoriesDataStatus = DataStatus.error;
      if(failure is SingleMessageFailure){
        categoriesSingleMessageFailure = failure;
      }
      // တစ်ခြား exception တွေ ဆိုရင်တော့ Something went wrong လို့ပဲ မှတ်လိုက်မလား
      else{
        categoriesSingleMessageFailure = SingleMessageFailure(message: "Something went wrong @p");
      }
      notifyListeners();
      return false;
    }, (categoriesFromServer) {
      // success phase
      print("get categories from server ");
      print(categoriesFromServer.length);
      categoriesDataStatus = DataStatus.data;
      categories.addAll(categoriesFromServer);
      print(categories.length);
      categoriesPagination.currentPage = getCategoriesPara.page + 1;
      notifyListeners();
      return true;
    });
  }

  Future<bool> getCategoryPlz({required GetCategoryPara getCategoryPara}) async {
    // before phase
    // update status
    categoryDataStatus = DataStatus.loading;
    notifyListeners();

    // doing business using use case

    final Either<Failure, Category> categoryEither = await getCategory(getCategoryPara);
    return categoryEither.fold((failure) {
      // failure phase
      categoryDataStatus = DataStatus.error;
      if(failure is SingleMessageFailure){
        categorySingleMessageFailure = failure;
      }
      // တစ်ခြား exception တွေ ဆိုရင်တော့ Something went wrong လို့ပဲ မှတ်လိုက်မလား
      else{
        categorySingleMessageFailure = SingleMessageFailure(message: "Something went wrong @p");
      }
      notifyListeners();

      return false;
    }, (categoryDetail) {
      // success phase
      categoryDataStatus = DataStatus.data;
      category = categoryDetail;
      notifyListeners();

      return true;
    });
  }
  
}
