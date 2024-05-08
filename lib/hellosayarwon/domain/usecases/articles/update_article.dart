
import 'package:dartz/dartz.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/update_article_para.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../repositories/article_repository.dart';

class UpdateArticle implements UseCase<Article, UpdateArticlePara> {

  final ArticleRepository articleRepository;

  UpdateArticle({required this.articleRepository});

  @override
  Future<Either<Failure,  Article>>  call(UpdateArticlePara params) async{
    return await articleRepository.updateArticle(updateArticlePara: params);
  }
}