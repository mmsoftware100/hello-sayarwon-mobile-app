

import 'package:dartz/dartz.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_articles_para.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repositories/article_repository.dart';

class GetArticles implements UseCase<List<Article>, GetArticlesPara> {

  final ArticleRepository articleRepository;

  GetArticles({required this.articleRepository});

  @override
  Future<Either<Failure, List<Article>>> call(GetArticlesPara params) async{
    return await articleRepository.getArticles(getArticlesPara: params);
  }
}