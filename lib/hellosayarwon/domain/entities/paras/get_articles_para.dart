
class GetArticlesPara{
  final String accessToken;
  final String query;
  final int categoryId;
  final int page;
  bool favourite;

  GetArticlesPara({
    required this.accessToken,
    required this.query,
    required this.categoryId,
    required this.page,
    this.favourite = false
  });

  Map<String, String> toJson(){
    Map<String, String> data = {
      "page": page.toString()
    };
    if(categoryId != 0){
      data["category_id"] = categoryId.toString();
    }
    if(query.isNotEmpty){
      data["s"] = query;
    }

    return data;
  }
}