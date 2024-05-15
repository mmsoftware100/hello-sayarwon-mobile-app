// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      permalink: json['permalink'] as String? ?? '',
      title: json['post_title'] as String? ?? '',
      description: json['post_content'] as String? ?? '',
      thumbnail: json['image_thumbnail'] as String? ?? '',
      categoryId: (json['name'] as num?)?.toInt() ?? 0,
      category: json['users'] == null
          ? null
          : CategoryModel.fromJson(json['users'] as Map<String, dynamic>),
      favourite: (json['favourite'] as num?)?.toInt() ?? 0,
      createdAt: json['post_date_utc'] as String? ?? '',
      updatedAt: json['post_modified_utc'] as String? ?? '',
    );

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'permalink': instance.permalink,
      'post_title': instance.title,
      'post_content': instance.description,
      'image_thumbnail': instance.thumbnail,
      'name': instance.categoryId,
      'favourite': instance.favourite,
      'users': instance.category?.toJson(),
      'post_date_utc': instance.createdAt,
      'post_modified_utc': instance.updatedAt,
    };
