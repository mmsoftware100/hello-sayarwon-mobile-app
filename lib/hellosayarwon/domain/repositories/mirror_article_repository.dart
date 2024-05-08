

import 'package:dartz/dartz.dart';
import 'package:doublefive/domain/entities/directory/project_info.dart';
import 'package:doublefive/domain/entities/directory/update_info.dart';
import 'package:doublefive/domain/entities/imirror/mirror_article.dart';
import 'package:doublefive/domain/entities/imirror/mirror_category.dart';
import 'package:doublefive/domain/usecases/mirror/select_mirror_articles_data.dart';
import 'package:doublefive/domain/usecases/mirror/select_mirror_categories_data.dart';

import '../../../core/error/failures.dart';

abstract class MirrorArticleRepository{
  Future<Either<Failure,List<MirrorArticle>>> getArticles({required SelectMirrorArticlesData selectMirrorArticlesData});
  Future<Either<Failure,List<MirrorCategory>>> getCategories({required SelectMirrorCategoriesData selectMirrorCategoriesData});
  Future<Either<Failure, ProjectInfo>> getProjectInfo({required int projectId});
  Future<Either<Failure, UpdateInfo>> getUpdateInfo({required int projectId});
}

