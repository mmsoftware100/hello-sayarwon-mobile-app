
import 'package:dartz/dartz.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/toggle_favourite_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/update_article_para.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repositories/article_repository.dart';

class ToggleFavourite implements UseCase<Article, ToggleFavouritePara> {

  final ArticleRepository articleRepository;

  ToggleFavourite({required this.articleRepository});

  @override
  Future<Either<Failure,  Article>>  call(ToggleFavouritePara params) async{
    return await articleRepository.toggleFavourite(toggleFavouritePara: params);
  }
}