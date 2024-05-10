
import 'package:hellosayarwon/hellosayarwon/data/models/article_model.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';
@JsonSerializable(explicitToJson: true)

class CategoryModel {
  @JsonKey(name: 'term_id' , defaultValue: 0)
  int id;

  @JsonKey(name: 'parent' , defaultValue: 0)
  int parent;

  @JsonKey(name: 'permalink' , defaultValue: "")
  String permalink;



  @JsonKey(name: 'name' , defaultValue: "title")
  String title;


  @JsonKey(name: 'description' , defaultValue: "description")
  String description;


  @JsonKey(name: 'image' , defaultValue: "thumbnail")
  String thumbnail;

  // တကယ့် JSON မှာ ဒါပါလာမှာ မဟုတ်ဘူး။ အပြင်မှာ field သပ်သပ်နဲ့ လာမှာ
  @JsonKey(name: 'sub_categories' , defaultValue: [])
  List<CategoryModel> subCategories;

  // ဒါလည်း အတူတူပဲ main category json မှာ မပါဘူး။
  @JsonKey(name: 'explainers_posts' , defaultValue: [])
  List<ArticleModel> articles;

  @JsonKey(name: 'created_at' , defaultValue: "")
  String createdAt;

  @JsonKey(name: 'updated_at' , defaultValue: "")
  String updatedAt;



  CategoryModel({
    required this.id,
    required this.parent,
    required this.permalink,
    required this.title,
    required this.description,
    required this.thumbnail,


    required this.subCategories,
    required this.articles,

    required this.createdAt,
    required this.updatedAt
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return _$CategoryModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  Category toEntity(){
    return Category(
        id: id,
        parent: parent,
        permalink: permalink,
        title: title,
        description: description,
        thumbnail: thumbnail,
        subCategories: subCategories.map((e) => e.toEntity()).toList(),
        articles: articles.map((e) => e.toEntity()).toList(),
        createdAt: createdAt,
        updatedAt: updatedAt
    );
  }
}

