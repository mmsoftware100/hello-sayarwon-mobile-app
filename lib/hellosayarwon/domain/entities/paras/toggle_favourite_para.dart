
import 'package:hellosayarwon/hellosayarwon/domain/entities/article.dart';

class ToggleFavouritePara{
  final String accessToken;
  final Article article;

  ToggleFavouritePara({
    required this.accessToken,
    required this.article
  });
}