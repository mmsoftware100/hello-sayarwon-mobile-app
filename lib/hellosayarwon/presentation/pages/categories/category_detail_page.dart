import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/pages/articles/article_list_by_category_page.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/pages/articles/article_list_page.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/providers/category_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/status/status.dart';
import '../../../domain/entities/article.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/paras/get_article_para.dart';
import '../../providers/article_provider.dart';
import '../articles/article_detail_page.dart';
import '../articles/components/article_description_shimmer.dart';

class CategoryDetailPage extends StatefulWidget {
  static const String routeName = "/CategoryDetailPage";
  const CategoryDetailPage({super.key});

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Detail Page"),
      ),
      body: _mainWidget(Provider.of<CategoryProvider>(context, listen: true).category),
    );
  }

  Widget _mainWidget(Category category){
    return ListView(
      children: [
        // headers
        CachedNetworkImage(
          imageUrl: category.thumbnail,
          progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.fill,
        ),

        // category photo

        Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              // category title
              Text(category.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),),

              SizedBox(height: 8.0,),

              // category description
              if(Provider.of<CategoryProvider>(context, listen: true).categoryDataStatus == DataStatus.loading) ArticleDescriptionShimmer(),
              Text(category.description, style: TextStyle( fontSize: 16.0, height: 2.0),),

              // category articles
              // Text(category.articles.length.toString()),
              Column(
                children: [
                  ...category.articles.map((e) => _articleCard(article: e)).toList()
                ],
              ),

              SizedBox(height: 24.0,),
              // go to listing page button or link
              ElevatedButton(onPressed: (){
                // go to article listing for articles by category
                // TODO: add category detail logic in article provider
                Provider.of<ArticleProvider>(context, listen: false).setCategoryDetail(category);
                // ဒီ page က သူ့ဘာသာ refresh လုပ်လိမ့်မယ်၊ အပေါ်က set လုပ်ထားတဲ့ category အပေါ် မူတည်ပြီး။
                Navigator.pushNamed(context, ArticleListByCategoryPage.routeName);
              }, child: Text("More Articles ➡️")),

              SizedBox(height: 24.0,),
            ],
          ),
        )
      ],
    );
  }


  Widget _articleCard({required Article article}){
    return InkWell(
      onTap: (){
        // set article detail and go to detail page
        Provider.of<ArticleProvider>(context, listen: false).setArticleDetail(article);
        String accessToken = "";
        String permalink = article.permalink;
        GetArticlePara getArticlePara = GetArticlePara(accessToken: accessToken, permalink: permalink);
        Provider.of<ArticleProvider>(context, listen: false).getArticlePlz(getArticlePara: getArticlePara);
        Navigator.pushNamed(context, ArticleDetailPage.routeName);
      },
      child: Container(
        height: 150,
        margin: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
        decoration:   BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(8.0)
        ),
        child:  Row(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0)
                ),
                child: CachedNetworkImage(
                  height: 150,
                  imageUrl: article.thumbnail,
                  progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(article.title),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
  Widget _articleCard2({required Article article}){
    return InkWell(
      onTap: (){
        // set article detail and go to detail page
        Provider.of<ArticleProvider>(context, listen: false).setArticleDetail(article);
        String accessToken = "";
        String permalink = article.permalink;
        GetArticlePara getArticlePara = GetArticlePara(accessToken: accessToken, permalink: permalink);
        Provider.of<ArticleProvider>(context, listen: false).getArticlePlz(getArticlePara: getArticlePara);
        Navigator.pushNamed(context, ArticleDetailPage.routeName);
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.all(8.0),
        decoration:   BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(8.0)
        ),
        child:  Row(
          children: [
            Expanded(
              flex: 1,
              child: CachedNetworkImage(
                imageUrl: article.thumbnail,
                progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Expanded(
                flex: 3,
                child: Center(child: Text(article.title),)
            )
          ],
        ),
      ),
    );
  }

}
