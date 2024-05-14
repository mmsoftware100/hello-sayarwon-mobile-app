import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hellosayarwon/core/status/status.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/providers/article_provider.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/article.dart';
import '../../../domain/entities/paras/get_article_para.dart';
import 'components/article_description_shimmer.dart';

class ArticleDetailPage extends StatefulWidget {
  static const String routeName = "/ArticleDetailPage";
  const ArticleDetailPage({super.key});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Article Detail"),
      ),
      body: _mainWidget(Provider.of<ArticleProvider>(context, listen: true).article),
    );
  }

  Widget _mainWidget(Article article){
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        // photo
        CachedNetworkImage(
          imageUrl: article.thumbnail,
          progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.fill,
        ),
        // main content
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // title
              Text(article.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,height: 2.0),),
              // Text(Provider.of<ArticleProvider>(context, listen: true).articleDataStatus.toString()),
              // description

              if(Provider.of<ArticleProvider>(context, listen: true).articleDataStatus == DataStatus.loading) ArticleDescriptionShimmer(),
              // TODO: show loading shimmer effect on loading
              if(Provider.of<ArticleProvider>(context, listen: true).articleDataStatus == DataStatus.data) Text(article.description, style: TextStyle(height: 2.0),),

              // related content
              // get random 10 articles
              Text("Related Articels"),
              Column(
                children: [
                  ...Provider.of<ArticleProvider>(context, listen: true).getRandomArticles().map((e) => _articleCard(article: e)).toList()
                ],
              )


            ],
          ),
        ),

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
        Navigator.pushReplacementNamed(context, ArticleDetailPage.routeName);
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
