import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hellosayarwon/core/status/status.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/toggle_favourite_para.dart';
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
        actions: [
          _favouriteButton(Provider.of<ArticleProvider>(context, listen: true).article)
        ],
      ),
      body: _mainWidget(Provider.of<ArticleProvider>(context, listen: true).article),
    );
  }

  Widget _favouriteButton(Article article){
    if(Provider.of<ArticleProvider>(context, listen: true).articleDataStatus == DataStatus.loading) return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator()),
    );
    return IconButton(
        onPressed: (){
          String accessToken = "";
          ToggleFavouritePara toggleFavouritePara = ToggleFavouritePara(accessToken: accessToken, article: article);
          Provider.of<ArticleProvider>(context, listen: false).toggleFavouritePlz(toggleFavouritePara: toggleFavouritePara);
        },
        icon: Icon(article.favourite == 1 ? Icons.favorite :  Icons.favorite_outline_rounded )
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

              if(Provider.of<ArticleProvider>(context, listen: true).articleDataStatus == DataStatus.loading && Provider.of<ArticleProvider>(context, listen: true).article.description.isEmpty) ArticleDescriptionShimmer(),
              // TODO: show loading shimmer effect on loading
              if(Provider.of<ArticleProvider>(context, listen: true).articleDataStatus == DataStatus.data || Provider.of<ArticleProvider>(context, listen: true).article.description.isNotEmpty) Text(article.description, style: TextStyle(fontSize: 16.0, height: 2.0),),

              // related content
              // get random 10 articles
              Text("Related Articles"),
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
        Navigator.pushNamed(context, ArticleDetailPage.routeName);
      },
      child: Container(
        height: 150,
        margin: const EdgeInsets.all(8.0),
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
