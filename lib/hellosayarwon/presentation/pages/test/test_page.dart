import 'package:flutter/material.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_article_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_articles_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_categories_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_category_para.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/toggle_favourite_para.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/pages/articles/article_list_by_favourite_page.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/pages/articles/article_list_page.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/pages/articles/article_search_page.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/pages/categories/category_list_page.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/pages/home/home_page.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/providers/article_provider.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/providers/category_provider.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/article.dart';

class TestPage extends StatefulWidget {
  static const String routeName = "/TestPage";
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Page"),
      ),
      body: ListView(
        children: [
          ListTile(title: const Text("Home Page"), onTap: _goToHome, ),
          Divider(),
          ListTile(title: const Text("Go To Listing"), onTap: _goToListing, ),
          ListTile(title: const Text("Refresh Articles"), onTap: _refreshArticles, ),
          ListTile(title: const Text("Load More Articles"), onTap: _loadMoreArticles, ),
          ListTile(title: const Text("Article Detail"), onTap: _articleDetail, ),
          //
          Divider(),
          ListTile(title: const Text("Select category list"), onTap: _selectCategoryList, ),
          ListTile(title: const Text("Select category detail"), onTap: _selectCategoryDetail, ),
          ListTile(title: const Text("Go To Category Listing"), onTap: _goToCategoryListing, ),
          //
          Divider(),
          ListTile(title: const Text("Search Articles"), onTap: _searchArticles, ),
          ListTile(title: const Text("Go To Search"), onTap: _goToSearch, ),
          //
          Divider(),
          ListTile(title: const Text("Toggle favourite"), onTap: _toggleFavourite, ),
          ListTile(title: const Text("Go to Favourite Listing"), onTap: _goToFavouriteList, ),

        ],
      ),
    );
  }

  void _goToHome(){
    Navigator.pushNamed(context, HomePage.routeName);
  }
  void _goToListing(){
    Navigator.pushNamed(context, ArticleListPage.routeName);
  }
  void _goToCategoryListing(){
    Navigator.pushNamed(context, CategoryListPage.routeName);
  }
  void _goToSearch(){
    Navigator.pushNamed(context, ArticleSearchPage.routeName);
  }
  void _goToFavouriteList(){
    Navigator.pushNamed(context, ArticleListByFavouritePage.routeName);
  }

  Future<void> _refreshArticles() async{
    print("TestPage->_refreshArticles");
    String accessToken = "";
    String query = "";
    int categoryId = 0;
    int page = 1;
    GetArticlesPara getArticlesPara = GetArticlesPara(accessToken: accessToken, query: query, categoryId: categoryId, page: page, favourite: false);
    bool status = await Provider.of<ArticleProvider>(context, listen: false).getArticlesPlz(getArticlesPara: getArticlesPara);
    print("TestPage->_refreshArticles status $status");
  }
  Future<void> _loadMoreArticles() async{
    print("TestPage->_loadMoreArticles");
    String accessToken = "";
    String query = "";
    int categoryId = 0;
    int page = Provider.of<ArticleProvider>(context, listen: false).articlesPagination.currentPage;

    GetArticlesPara getArticlesPara = GetArticlesPara(accessToken: accessToken, query: query, categoryId: categoryId, page: page);
    bool status = await Provider.of<ArticleProvider>(context, listen: false).getArticlesPlz(getArticlesPara: getArticlesPara);
    print("TestPage->_refreshArticles status $status");
  }
  Future<void> _articleDetail() async{
    String accessToken = "";
    String permalink = Provider.of<ArticleProvider>(context, listen: false).articles.first.permalink;
    GetArticlePara getArticlePara = GetArticlePara(accessToken: accessToken, permalink: permalink);
    bool status = await Provider.of<ArticleProvider>(context, listen: false).getArticlePlz(getArticlePara: getArticlePara);
    print("TestPage->_articleDetail status $status");
  }
  Future<void> _selectCategoryList() async{
    print("TestPage->_selectCategoryList");
    String accessToken = "";
    int page = 1;
    GetCategoriesPara getCategoriesPara = GetCategoriesPara(accessToken: accessToken, page: page);
    bool status = await Provider.of<CategoryProvider>(context, listen: false).getCategoriesPlz(getCategoriesPara: getCategoriesPara);
    print("TestPage->_selectCategoryList status $status");
  }
  Future<void> _selectCategoryDetail() async{
    print("TestPage->_selectCategoryDetail");
    String accessToken = "";
    String permalink = Provider.of<CategoryProvider>(context, listen: false).categories.first.permalink;
    GetCategoryPara getCategoryPara = GetCategoryPara(accessToken: accessToken, permalink: permalink);
    bool status = await Provider.of<CategoryProvider>(context, listen: false).getCategoryPlz(getCategoryPara: getCategoryPara);
    print("TestPage->_selectCategoryList status $status");
  }
  Future<void> _searchArticles() async{
    print("TestPage->_searchArticles");
    String accessToken = "";
    String query = "လိင်";
    int categoryId = 0;
    int page = 1;
    GetArticlesPara getArticlesPara = GetArticlesPara(accessToken: accessToken, query: query, categoryId: categoryId, page: page);
    bool status = await Provider.of<ArticleProvider>(context, listen: false).getArticlesPlz(getArticlesPara: getArticlesPara);
    print("TestPage->_searchArticles status $status");
  }

  Future<void> _toggleFavourite() async{
    String accessToken = "";
    Article article = Provider.of<ArticleProvider>(context, listen: false).articles.first;
    ToggleFavouritePara toggleFavouritePara = ToggleFavouritePara(accessToken: accessToken, article: article);
    bool status = await Provider.of<ArticleProvider>(context, listen: false).toggleFavouritePlz(toggleFavouritePara: toggleFavouritePara);
    print("TestPage->_toggleFavourite status $status");
  }
}
