
import 'package:doublefive/domain/entities/imirror/mirror_category.dart';

import '../directory/contact_data.dart';

class Article{
  // ID Things
  int id;
  // permalink
  String permalink;


  String title;
  String description;
  String thumbnail;

  // supplimentry
  int categoryId;
  MirrorCategory category;

  // meta data
  String createdAt;
  String updatedAt;

  


  MirrorArticle({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.categoryId,
    required this.category,
    required this.contactData,
    required this.createdAt,
    required this.updatedAt
  });

  static MirrorArticle get sample{

    return MirrorArticle(
      id: 0,
      title:"title",
      description:"description",
      thumbnail: "https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg?size=626&ext=jpg&ga=GA1.1.1412446893.1704758400&semt=sph", // "https://placehold.co/400", // "thumbnail",
      categoryId: 0,
      category : MirrorCategory.sample,
      contactData : [], // empty array to avoid stack overflow
      createdAt:"createdAt",
      updatedAt:"updatedAt",
    );
  }
}