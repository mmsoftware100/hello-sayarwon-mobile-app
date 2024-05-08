

import 'article.dart';

class Category{
  // for id
  int id;
  int parent; // for sub category things
  // permalink for ID Things
  String permalink;

  String title;
  String description;
  String thumbnail;


  List<Category> subCategories;
  List<Article> articles;

  String createdAt;
  String updatedAt;


  Category({
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

  static Category get sample{

    return Category(
      id: 0,
      parent: 0,
      permalink: "",
      title:"title",
      description:"description",
      thumbnail: "https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg?size=626&ext=jpg&ga=GA1.1.1412446893.1704758400&semt=sph", // "https://placehold.co/400", // "thumbnail",
      subCategories: [],
      articles : [],
      createdAt:"createdAt",
      updatedAt:"updatedAt",
    );
  }
}