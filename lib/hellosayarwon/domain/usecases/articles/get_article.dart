
import 'package:dartz/dartz.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_articles_para.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../entities/paras/get_article_para.dart';
import '../../repositories/article_repository.dart';

class GetArticle implements UseCase<Article, GetArticlePara> {

  final ArticleRepository articleRepository;

  GetArticle({required this.articleRepository});

  @override
  Future<Either<Failure,  Article>>  call(GetArticlePara params) async{
    return await articleRepository.getArticle(getArticlePara: params);
  }
}