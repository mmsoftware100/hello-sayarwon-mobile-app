// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: (json['term_id'] as num?)?.toInt() ?? 0,
      parent: (json['parent'] as num?)?.toInt() ?? 0,
      permalink: json['permalink'] as String? ?? '',
      title: json['name'] as String? ?? 'title',
      description: json['description'] as String? ?? 'description',
      thumbnail: json['image'] as String? ?? 'thumbnail',
      subCategories: (json['sub_categories'] as List<dynamic>?)
              ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      articles: (json['explainers_posts'] as List<dynamic>?)
              ?.map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'term_id': instance.id,
      'parent': instance.parent,
      'permalink': instance.permalink,
      'name': instance.title,
      'description': instance.description,
      'image': instance.thumbnail,
      'sub_categories': instance.subCategories.map((e) => e.toJson()).toList(),
      'explainers_posts': instance.articles.map((e) => e.toJson()).toList(),
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
