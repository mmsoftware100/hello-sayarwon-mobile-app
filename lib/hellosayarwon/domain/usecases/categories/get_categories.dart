
import 'package:dartz/dartz.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/category.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_articles_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_categories_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_category_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/repositories/category_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../entities/paras/get_article_para.dart';
import '../../repositories/article_repository.dart';

class GetCategories implements UseCase<List<Category>, GetCategoriesPara> {

  final CategoryRepository categoryRepository;

  GetCategories({required this.categoryRepository});

  @override
  Future<Either<Failure,  List<Category>>>  call(GetCategoriesPara params) async{
    return await categoryRepository.getCategories(getCategoriesPara: params);
  }
}