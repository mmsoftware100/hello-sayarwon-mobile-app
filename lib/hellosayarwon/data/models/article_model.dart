
import 'package:hellosayarwon/hellosayarwon/domain/entities/article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/category.dart';
import 'package:json_annotation/json_annotation.dart';

import 'category_model.dart';

part 'article_model.g.dart';
@JsonSerializable(explicitToJson: true)

class ArticleModel {
  @JsonKey(name: 'ID' , defaultValue: 0)
  int id;

  @JsonKey(name: 'permalink' , defaultValue: "")
  String permalink;

  @JsonKey(name: 'post_title' , defaultValue: "")
  String title;

  // HTML Tag တွေ Clean လုပ်ဖို့ လိုကောင်း လိုမယ်။
  @JsonKey(name: 'post_content' , defaultValue: "")
  String description;

  // အနိမ့်ဆုံး resolution ကို ယူထားတယ်။
  // generate လုပ်တဲ့အခါ ဒါလိုမယ်။
  // thumbnail:   json['image_thumbnail'] is String ? json['image_thumbnail'] as String : "", // json['image_thumbnail'] as String? ?? '',
  @JsonKey(name: 'image_thumbnail' , defaultValue: "")
  String thumbnail;

  @JsonKey(name: 'name' , defaultValue: 0)
  int categoryId;


  // for local status
  @JsonKey(name: 'favourite' , defaultValue: 0)
  int favourite;

  @JsonKey(name: 'users' , defaultValue: null)
  CategoryModel? category;

  @JsonKey(name: 'post_date_utc' , defaultValue: "")
  String createdAt;

  @JsonKey(name: 'post_modified_utc' , defaultValue: "")
  String updatedAt;

  // related article တွေကို ပြချင်တယ်ဆို ပြနိုင်တယ်



  ArticleModel({
    required this.id,
    required this.permalink,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.categoryId,
    required this.category,
    required this.favourite,
    required this.createdAt,
    required this.updatedAt
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return _$ArticleModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  Article toEntity(){
    return Article(
        id: id,
        permalink: permalink,
        title: title,
        description: removeHtmlTags(description),
        thumbnail: thumbnail,
        categoryId: categoryId,
        category: category?.toEntity() ?? Category.sample,
        createdAt: createdAt,
        updatedAt: updatedAt
    );
  }

  String removeHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }


  Map<String, dynamic> toDbStore() {
    Map<String, dynamic> json = {
      // we don't need id for store
      'title' : title,
      'description' : description,
      'thumbnail' : thumbnail,
      'category_id' : categoryId,
      'created_at' : createdAt,
      'updated_at' : updatedAt,
      // how about Contact Data List ?
    };
    // check new item or not
    if(id > 0){
      json['id'] = id;
    }
    return json;
  }


}

