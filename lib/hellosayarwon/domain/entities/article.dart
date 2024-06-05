


import 'category.dart';

class Article{
  // ID Things
  int id;
  // permalink
  String permalink;


  String title;
  String description;
  String thumbnail;

  // supplementary
  int categoryId;
  Category category;


  // favourite
  int favourite;

  // sources
  String sources;


  // meta data
  String createdAt;
  String updatedAt;




  Article({
    required this.id,
    required this.permalink,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.categoryId,
    required this.favourite,
    required this.category,
    required this.sources,
    required this.createdAt,
    required this.updatedAt
  });

  static Article get sample{

    return Article(
      id: 0,
      permalink: '',
      title:"title",
      description:"description",
      thumbnail: "https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg?size=626&ext=jpg&ga=GA1.1.1412446893.1704758400&semt=sph", // "https://placehold.co/400", // "thumbnail",
      categoryId: 0,
      favourite: 0,
      category : Category.sample,
      sources:"",
      createdAt:"createdAt",
      updatedAt:"updatedAt",
    );
  }
}