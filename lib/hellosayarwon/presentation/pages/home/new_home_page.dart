import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hellosayarwon/core/status/pagination.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/article.dart';
import 'package:hellosayarwon/hellosayarwon/domain/entities/category.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/pages/articles/article_list_page.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/pages/articles/article_search_page.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/providers/article_provider.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/providers/category_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/status/status.dart';
import '../../../data/const/constants.dart';
import '../../../domain/entities/paras/get_article_para.dart';
import '../../../domain/entities/paras/get_articles_para.dart';
import '../../../domain/entities/paras/get_category_para.dart';
import '../articles/article_detail_page.dart';
import '../categories/category_detail_page.dart';

class NewHomePage extends StatefulWidget {
  static final String routeName = '/NewHomePage';
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {

  TextEditingController _searchInputTec = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainWidget(),
    );
  }

  Widget _mainWidget(){
    return SingleChildScrollView(
      child: Column(
        children: [
          _coverPhoto(),
          // _searchInput()
          SizedBox(height: 8.0,),
          _categoryList(
              categoryList: Provider.of<CategoryProvider>(context, listen: true).categories,
              dataStatus: Provider.of<CategoryProvider>(context, listen: true).categoriesDataStatus,
              pagination: Provider.of<CategoryProvider>(context, listen: true).categoriesPagination
          ),
          //Text(Provider.of<ArticleProvider>(context, listen: true).articlesPagination.currentPage.toString()),
          //Text(Provider.of<ArticleProvider>(context, listen: true).articlesDataStatus.toString()),
          _articleList(
              articleList: Provider.of<ArticleProvider>(context, listen: true).articles,
              dataStatus: Provider.of<ArticleProvider>(context, listen: true).articlesDataStatus,
              pagination: Provider.of<ArticleProvider>(context, listen: true).articlesPagination
          ),
          // Expanded(child: _articleList())
          Provider.of<ArticleProvider>(context, listen: true).articles.isNotEmpty ?  _allListing() : Container(),
          SizedBox(height: 8.0,)
        ],
      ),
    );
  }

  Widget _coverPhoto(){
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // background image
        Column(
          children: [
            ShaderMask(
                blendMode: BlendMode.srcATop, // Set the blend mode as needed
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black , // Adjust opacity and color as needed
                      // Colors.transparent,
                    ],
                  ).createShader(bounds);
                },
                child: CachedNetworkImage(imageUrl: COVER_PHOTO_URL)
            ),
            SizedBox(height: 36.0,)
          ],
        ),
        // title, subtitle and search input
        Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end, // Aligns the Column content at the bottom
            children: [
              Text("Hello ဆရာဝန်", style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: Colors.white),),
              SizedBox(height: 8.0,),
              Text("ပိုမို ကျန်းမာပျော်ရွှင်စေဖို့\nစိတ်ချရသော ကျန်းမာရေး အချက်အလက်များ", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.white, height: 1.5),),

              SizedBox(height: 8.0,),
              _searchInput()

            ],
          ),
        ),
      ],
    );
  }

  Widget _searchInput(){
    // layout
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
      // margin: EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
      decoration: BoxDecoration(
          color: Colors.transparent
      ),
      // input decoration
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]

        ),
        child: TextFormField(
          // TODO: on submit to make search and go to next page
          onFieldSubmitted: (_){
            print("onFieldSubmitted");
            print(_);
            if(_.isEmpty) return;

            // search and go to listing page
            int categoryId = 0;
            int pageNo = 0;
            String accessToken = "";


            //Provider.of<ImirrorProvider>(context, listen: false).selectArticlePlz(accessToken: accessToken, pageNo: pageNo, query: _, projectId: projectId, categoryId: categoryId);
            // go to listing page for category

            //MirrorCategory category = MirrorCategory(id: 1000, name: "Search Result", createdAt: "createdAt", updatedAt: "");
            //Provider.of<ImirrorProvider>(context, listen: false).setCategoryDetail(category); ျိ်ိ်dsdfsdf
            Provider.of<ArticleProvider>(context, listen: false).setSearchKeyword(_);
            Navigator.pushNamed(context, ArticleSearchPage.routeName);

          },
          // keyboardType: TextInputType.,
          // style: TextStyle(color: Colors.white),
          controller: _searchInputTec,
          // keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            // prevent label floating
            floatingLabelBehavior: FloatingLabelBehavior.never,
            // prefix: Icon(Icons.search),
            prefixIcon: Icon(Icons.search),
            suffixIcon: Icon(Icons.settings),
            hintText: "လိုချင်တာ ရိုက်ရှာလိုက်ပါ",
            labelText: 'ရှာဖွေရန်',
            //labelStyle: TextStyle(color: Colors.white),
            //hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Phone is empty';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _categoryList({required List<Category> categoryList, required DataStatus dataStatus, required Pagination pagination}){
    // return _categoryShimmerEffect();
    if(dataStatus == DataStatus.loading && categoryList.isEmpty) return _categoryShimmerEffect();
    if(dataStatus == DataStatus.error && categoryList.isEmpty) return _categoryErrorWidget();

    return Container(
      height: 72,
      color: Colors.transparent,
      child: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          // This next line does the trick.
          scrollDirection: Axis.horizontal,
          children: [
            ...List.generate(categoryList.length, (index) => _categoryCard(category: categoryList[index])).toList()
          ],
        ),
      ),
    );
  }

  Widget _categoryCard({required Category category}){
    // နှိပ်ချင်စရာ ဖြစ်အောင် လုပ်ရမယ်။
    return InkWell(
      onTap: () {
        Provider.of<CategoryProvider>(context, listen: false).setCategoryDetail(category);
        String accessToken = "";
        String permalink = category.permalink;
        GetCategoryPara getCategoryPara = GetCategoryPara(accessToken: accessToken, permalink: permalink);
        Provider.of<CategoryProvider>(context, listen: false).getCategoryPlz(getCategoryPara: getCategoryPara);
        Navigator.pushNamed(context, CategoryDetailPage.routeName);

        // Provider.of<CategoryProvider>(context, listen: false).setCategoryDetail(category);
        // Navigator.pushNamed(context, ImirrorArticleListForCategoryPage.routeName);

        // Provider.of<WpContentProvider>(context, listen: false)
        //     .setDetailWpContent(wpContent);
        // Navigator.pushNamed(context, WpContentRoute.routeName);
      },
      child: Container(
        // height: 50,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]
        ),
        child: Row(
          children: [
            // Icon(Icons.map_outlined),
            CachedNetworkImage(
              // width: MediaQuery.of(context).size.width / 4,
              imageUrl: category.thumbnail,
              progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.contain,
            ),
            SizedBox(width: 8.0,),
            Center(child: Text(category.title)),
          ],
        ),
      ),
    );
  }



  Widget _articleList({required List<Article>  articleList, required DataStatus   dataStatus, required Pagination  pagination}){


    // return _articleShimmerEffect();
    if(dataStatus == DataStatus.loading && articleList.isEmpty) return _articleShimmerEffect();
    if(dataStatus == DataStatus.error && articleList.isEmpty) return _articleErrorWidget();

    // grid view
    return Column(
      children: [
        // row style card?
        ...List.generate(articleList.length, (index) =>  _articleCard(article: articleList[index])).toList()

      ],
    );
  }

  String _dateTimeToDaysAgo(String dateTimeString) {
    // Parse the DateTime string into a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Calculate the difference between the parsed DateTime and the current DateTime
    Duration difference = DateTime.now().difference(dateTime);

    // Convert the difference into days
    int days = difference.inDays;

    // Format the result as "X days ago"
    String formattedResult = '$days days ago';


    // hours
    if(days == 0){
      days = difference.inHours;
      // Format the result as "X days ago"
      formattedResult = '$days hours ago';

      // minutes
      if(days == 0){
        days = difference.inMinutes;
        // Format the result as "X days ago"
        formattedResult = '$days minutes ago';



        // seconds
        if(days == 0){
          days = difference.inSeconds;
          // Format the result as "X days ago"
          formattedResult = '$days seconds ago';
        }

      }

    }


    return formattedResult;
  }

  Widget _articleCard({required Article article}){
    /*
      String dateTimeString = '2024-04-30 12:00:00'; // Example DateTime string
      print(dateTimeToDaysAgo(dateTimeString)); // Output: 3 days ago
     */
    return InkWell(
      onTap: () {
        Provider.of<ArticleProvider>(context, listen: false).setArticleDetail(article);
        String accessToken = "";
        String permalink = article.permalink;
        GetArticlePara getArticlePara = GetArticlePara(accessToken: accessToken, permalink: permalink);
        Provider.of<ArticleProvider>(context, listen: false).getArticlePlz(getArticlePara: getArticlePara);
        Navigator.pushNamed(context, ArticleDetailPage.routeName);

        //Provider.of<ImirrorProvider>(context, listen: false).setArticleDetail(article);
        //Navigator.pushNamed(context, ImirrorDetailPage.routeName);
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8.0)

        ),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    height: 80,
                    imageUrl: article.thumbnail,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        Container(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                          ),
                        ),
                    errorWidget: (_,__,___) => Icon(Icons.image),
                  ),
                )
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.title),
                    SizedBox(height: 4.0,),
                    Text(_dateTimeToDaysAgo(article.updatedAt), style: TextStyle(color: Colors.grey, fontSize: 12),)
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget _allListing(){
    return ElevatedButton(
        onPressed: (){
          Navigator.pushNamed(context, ArticleListPage.routeName);
        },
        child: Text("All Articles")
    );
  }


  Widget _categoryErrorWidget(){
    return Column(
      children: [
        Icon(Icons.error, color: Colors.red,),
        SizedBox(height: 8.0,),
        Text(Provider.of<CategoryProvider>(context, listen: true).categoriesSingleMessageFailure.message),
        SizedBox(height: 8.0,),
        ElevatedButton(onPressed: (){

          String accessToken = "";
          String query = "";
          int categoryId = 0; // Provider.of<ArticleProvider>(context, listen: false).category.id;// ဒါဆိုရင် filter အတွက် အဆင်ပြေသွားမယ်။
          // ဘယ်ချိန်မှာ ဒီ category filter ကို clear ပြန်လုပ်မလဲ?
          // နောက် search လည်း ရှိသေးတယ်။
          int page = 1;
          GetArticlesPara getArticlesPara = GetArticlesPara(accessToken: accessToken, query: query, categoryId: categoryId, page: page);
          Provider.of<ArticleProvider>(context, listen: false).getArticlesPlz(getArticlesPara: getArticlesPara);

        }, child: Text("Refresh"))
      ],
    );
  }
  Widget _categoryShimmerEffect(){
    return Container(
      height: 72,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          ...List.generate(5, (index) => _categoryShimmerCard()).toList()
        ],
      ),
    );

  }
  Widget _categoryShimmerCard(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 126.0,
        height: 50.0,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,

          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0)
            ),
          ),
        ),
      ),
    );
  }


  Widget _articleShimmerEffect() {
    return Column(
      children: [
        ...List.generate(5, (index) => _articleShimmerCard()).toList()
      ],
    );
  }

  Widget _articleErrorWidget(){
    return Column(
      children: [
        Icon(Icons.error, color: Colors.red,),
        SizedBox(height: 8.0,),
        Text(Provider.of<CategoryProvider>(context, listen: true).categoriesSingleMessageFailure.message),
        SizedBox(height: 8.0,),
        ElevatedButton(onPressed: (){
          int pageNo = 1;
          int categoryId = 0;
          // Provider.of<ImirrorProvider>(context, listen: false).selectArticlePlz(accessToken: "accessToken", pageNo: pageNo, projectId: projectId, query: "", categoryId: categoryId);
        }, child: Text("Refresh"))
      ],
    );
  }


  Widget _articleShimmerCard(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 150.0,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,

          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0)
            ),
          ),
        ),
      ),
    );
  }
}



