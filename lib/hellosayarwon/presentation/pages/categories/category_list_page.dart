import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/category.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/paras/get_category_para.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/pages/articles/article_detail_page.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/providers/article_provider.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/providers/category_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../domain/entities/article.dart';
import '../../../domain/entities/paras/get_article_para.dart';
import '../../../domain/entities/paras/get_articles_para.dart';
import 'category_detail_page.dart';

// လောလောဆယ် ရိုးရိုးရှင်းရှင်း ပဲ လုပ်ဉီးမယ်။
// main listing ဆိုပါတော့။

class CategoryListPage extends StatefulWidget {
  static const String routeName = "/CategoryListPage";
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {

  final RefreshController _refreshController = RefreshController(initialRefresh:  true);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Article Listing"),
      ),
      body: _mainWidget(),
    );
  }

  // data methods
  void _onRefresh() async{
    // monitor network fetch

    print("TestPage->_refreshArticles");
    String accessToken = "";
    String query = "";
    int categoryId = 0;
    int page = 1;
    GetArticlesPara getArticlesPara = GetArticlesPara(accessToken: accessToken, query: query, categoryId: categoryId, page: page);
    bool status = await Provider.of<ArticleProvider>(context, listen: false).getArticlesPlz(getArticlesPara: getArticlesPara);
    print("TestPage->_refreshArticles status $status");
    _refreshController.refreshCompleted();



    //int pageNo = 1;
    //int categoryId = Provider.of<ImirrorProvider>(context, listen: false).category.id; // 0 for all and others for other
    //await Provider.of<ImirrorProvider>(context,listen: false).selectArticlePlz(accessToken: "accessToken", pageNo: pageNo, projectId: projectId,query: "", categoryId: categoryId);
    //await Future.delayed(const Duration(milliseconds: 5000));
    // if failed,use refreshFailed()
    //_refreshController.refreshCompleted();
  }

  void _onLoading() async{
    print("TestPage->_loadMoreArticles");
    String accessToken = "";
    String query = "";
    int categoryId = 0;
    int page = Provider.of<ArticleProvider>(context, listen: false).articlesPagination.currentPage;

    GetArticlesPara getArticlesPara = GetArticlesPara(accessToken: accessToken, query: query, categoryId: categoryId, page: page);
    bool status = await Provider.of<ArticleProvider>(context, listen: false).getArticlesPlz(getArticlesPara: getArticlesPara);
    print("TestPage->_refreshArticles status $status");
    _refreshController.loadComplete();


    // ဘယ် Page ကို ယူမှာလဲ ဆိုတာ ပြဿနာ ဖြစ်ပြီ။
    // category id zero ဆိုရင် main pagination ကို သုံးပြီး
    // category id က > 0 ဆိုရင် article list for category က pagination ကို သုံးမယ်။
    // Refactor တော့ ပြန်လုပ်မှ ရမယ်။


    // ဘယ်အချိန်မှာ zero ပြန်ပြောင်းမလဲ?
    // category card ကို နှိပ်တိုင်း သူက update လုပ်သွားမှာ ဖြစ်ပေမယ့်။ Home Page ကို ပြန်လာတာကို ဘယ်လို Handle လုပ်မလဲ?
    // article for category Listing မှာ back key ကို handle လုပ်ထားရမယ်။ နောက်ဆုတ်လိုက်တာနဲ့ category ကို zero ပြန်လုပ်တာမျိုး။


    /*
    int categoryId = Provider.of<ImirrorProvider>(context, listen: false).category.id; // 0 for all and others for other
    int pageNo = Provider.of<ImirrorProvider>(context, listen: false).paginationEntity.currentPage;
    if(categoryId > 0){
      // ဒီ state ကိုတော့ provider ဘက်က maintain လုပ်ပေးဖို့ လိုမယ်။
      // category အသစ်ပြောင်းတိုင်းမှာ Current Page ကို ၁ က စမယ်။
      pageNo = Provider.of<ImirrorProvider>(context, listen: false).articleListForCategoryPaginationEntity.currentPage;
    }
    await Provider.of<ImirrorProvider>(context,listen: false).selectArticlePlz(accessToken: "accessToken", pageNo: pageNo, query: "", projectId: projectId, categoryId: categoryId);
    */
    //await Future.delayed(const Duration(milliseconds: 5000));


  }

  Widget _mainWidget(){
    // pull to refresh လိုတယ်။
    return _pullToRefresh(); // ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount)
  }

  Widget _pullToRefresh(){
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: const WaterDropHeader(),
      controller: _refreshController,
      onRefresh: _onRefresh,
      //onLoading: _onLoading,
      child: _categoryList(
        categoryList: Provider.of<CategoryProvider>(context, listen: true).categories,
        //dataStatus: widget.dataStatus, //  Provider.of<ImirrorProvider>(context, listen: true).articleStatus,
        //pagination: widget.pagination, //  Provider.of<ImirrorProvider>(context, listen: true).paginationEntity
      ),
    );
  }

  Widget _categoryList({required List<Category> categoryList}){
    // should return listview or column ?
    return ListView.separated(
        itemBuilder: (context, index) => _categoryCard(category: categoryList[index]),
        separatorBuilder: (context, index) => Container(),
        itemCount: categoryList.length
    );
  }

  Widget _categoryCard({required Category category}){
    return InkWell(
      onTap: (){
        // set article detail and go to detail page
        Provider.of<CategoryProvider>(context, listen: false).setCategoryDetail(category);
        String accessToken = "";
        String permalink = category.permalink;
        GetCategoryPara getCategoryPara = GetCategoryPara(accessToken: accessToken, permalink: permalink);
        Provider.of<CategoryProvider>(context, listen: false).getCategoryPlz(getCategoryPara: getCategoryPara);
        Navigator.pushNamed(context, CategoryDetailPage.routeName);
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
                imageUrl: category.thumbnail,
                progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Expanded(
                flex: 3,
                child: Center(child: Text(category.title),)
            )
          ],
        ),
      ),
    );
  }
}
