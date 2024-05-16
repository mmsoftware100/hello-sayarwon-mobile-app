import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/pages/articles/article_detail_page.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/providers/article_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../domain/entities/article.dart';
import '../../../domain/entities/paras/get_article_para.dart';
import '../../../domain/entities/paras/get_articles_para.dart';

// လောလောဆယ် ရိုးရိုးရှင်းရှင်း ပဲ လုပ်ဉီးမယ်။
// main listing ဆိုပါတော့။

class ArticleSearchPage extends StatefulWidget {
  static const String routeName = "/ArticleSearchPage";
  const ArticleSearchPage({super.key});

  @override
  State<ArticleSearchPage> createState() => _ArticleSearchPageState();
}

class _ArticleSearchPageState extends State<ArticleSearchPage> {

  final TextEditingController tec = TextEditingController();
  final RefreshController _refreshController = RefreshController(initialRefresh:  false);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Page"),
      ),
      body: _mainWidget(),
    );
  }

  // data methods
  void _onRefresh() async{
    // monitor network fetch

    print("ArticleSearchPage->_onRefresh");

    /*
    String accessToken = "";
    String query = "လိင်";
    int categoryId = 0;
    int page = 1;
    GetArticlesPara getArticlesPara = GetArticlesPara(accessToken: accessToken, query: query, categoryId: categoryId, page: page);
    bool status = await Provider.of<ArticleProvider>(context, listen: false).getArticlesPlz(getArticlesPara: getArticlesPara);

     */
    String accessToken = "";
    String query = tec.text;
    int categoryId = 0;

    int page = 1;
    GetArticlesPara getArticlesPara = GetArticlesPara(accessToken: accessToken, query: query, categoryId: categoryId, page: page);
    bool status = await Provider.of<ArticleProvider>(context, listen: false).getArticlesPlz(getArticlesPara: getArticlesPara);
    print("ArticleSearchPage->_onRefresh status $status");

    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    print("ArticleSearchPage->_onLoading");
    String accessToken = "";
    String query = tec.text;
    int categoryId = Provider.of<ArticleProvider>(context, listen: false).category.id;// ဒါဆိုရင် filter အတွက် အဆင်ပြေသွားမယ်။
    int page = Provider.of<ArticleProvider>(context, listen: false).articlesBySearchPagination.currentPage;

    GetArticlesPara getArticlesPara = GetArticlesPara(accessToken: accessToken, query: query, categoryId: categoryId, page: page);
    bool status = await Provider.of<ArticleProvider>(context, listen: false).getArticlesPlz(getArticlesPara: getArticlesPara);
    print("ArticleSearchPage->_onLoading status $status");
    _refreshController.loadComplete();
  }



  Widget _mainWidget(){
    // pull to refresh လိုတယ်။
    return Column(
      children: [
        TextFormField(
          controller: tec,
        ),
        ElevatedButton(onPressed: (){
          _refreshController.requestRefresh();
        }, child: Text("Search")),
        Expanded(child: _pullToRefresh())
      ],
    );
  }

  Widget _pullToRefresh(){
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: const WaterDropHeader(),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: _articleList(
        articleList: Provider.of<ArticleProvider>(context, listen: true).articlesBySearch,
        //dataStatus: widget.dataStatus, //  Provider.of<ImirrorProvider>(context, listen: true).articleStatus,
        //pagination: widget.pagination, //  Provider.of<ImirrorProvider>(context, listen: true).paginationEntity
      ),
    );
  }

  Widget _articleList({required List<Article> articleList}){
    // should return listview or column ?
    return ListView.separated(
        itemBuilder: (context, index) => _articleCard(article: articleList[index]),
        separatorBuilder: (context, index) => Container(),
        itemCount: articleList.length
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
}
