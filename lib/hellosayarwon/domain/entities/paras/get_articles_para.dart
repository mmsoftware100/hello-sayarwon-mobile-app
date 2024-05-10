
class GetArticlesPara{
  final String accessToken;
  final String query;
  final int categoryId;
  final int page;

  GetArticlesPara({
    required this.accessToken,
    required this.query,
    required this.categoryId,
    required this.page
  });
}