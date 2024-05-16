import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/pages/articles/article_list_by_favourite_page.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/pages/articles/article_list_page.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/pages/categories/category_list_page.dart';
import 'package:provider/provider.dart';

import '../../../data/const/constants.dart';
import '../../../domain/entities/paras/get_articles_para.dart';
import '../../../domain/entities/paras/get_categories_para.dart';
import '../../providers/article_provider.dart';
import '../../providers/category_provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/HomePage";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int _currentIndex = 0;

  final List<Widget> _pages = [
    ArticleListPage(),
    CategoryListPage(),
    ArticleListByFavouritePage(),
    Center(child: Text("2"),),
    Center(child: Text("3"),),
    Center(child: Text("4"),),
    /*
    NewHomePage(),
    ImirrorCategoryPage(),
    ImirrorListingPage(),
    // ImirrorSearchPage(),
    ImmirrorAboutPage()

     */
  ];




  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// Create a [AndroidNotificationChannel] for heads up notifications
  late AndroidNotificationChannel channel;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // executes after build
      _refresh();


      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
        'This channel is used for important notifications.', // description
        importance: Importance.high,
      );

      _firebaseMessaging.requestPermission(
        sound: true,
        badge: true,
        alert: true,
        provisional: false, // Set to true for iOS 12 and above to enable provisional authorization.
      );


      print("trying to subscribe topic $FCM_TOPIC");
      _firebaseMessaging.subscribeToTopic(FCM_TOPIC);
      print("subscribed");

      _firebaseMessaging.getToken().then((token) {
        print("Firebase Token: $token");
      });

      // foreground handler

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("FCM->foreground handler");
        print("Received FCM message: ${message.notification?.body}");
        showFlutterNotification(message);
      });

      /*

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print("FCM->when a user presses a notification message displayed via FCM.");
        // FCM က ပြတဲ့ notification ကို user က နှိပ်လိုက်တဲ့အချိန်။
        Navigator.pushNamed(context, "/home");

      });

       */




    });
  }



  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      // how to handle callback on this notification.
      // we also need payload
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: 'launch_background',
          ),
        ),
      );
    }
  }



  void _refresh()async{

    // ဒီနေရာမှာ

    // articles, category, favourite သုံးခုလုံး select လုပ်ထားမယ်။ page ၁ အတွက်။
    // refresh (၃) ကို ဒီကူးလာခဲ့မယ်။

    String accessToken = "";
    String query = "";
    int categoryId = 0; // Provider.of<ArticleProvider>(context, listen: false).category.id;// ဒါဆိုရင် filter အတွက် အဆင်ပြေသွားမယ်။
    // ဘယ်ချိန်မှာ ဒီ category filter ကို clear ပြန်လုပ်မလဲ?
    // နောက် search လည်း ရှိသေးတယ်။
    int page = 1;
    GetArticlesPara getArticlesPara = GetArticlesPara(accessToken: accessToken, query: query, categoryId: categoryId, page: page);
    Provider.of<ArticleProvider>(context, listen: false).getArticlesPlz(getArticlesPara: getArticlesPara);

    GetCategoriesPara getCategoriesPara = GetCategoriesPara(accessToken: accessToken, page: page);
    Provider.of<CategoryProvider>(context, listen: false).getCategoriesPlz(getCategoriesPara: getCategoriesPara);

    GetArticlesPara getArticlesParaForFav = GetArticlesPara(accessToken: accessToken, query: query, categoryId: categoryId, page: page, favourite: true);
    Provider.of<ArticleProvider>(context, listen: false).getArticlesPlz(getArticlesPara: getArticlesParaForFav);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Home Page"),
      // ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ပင်မ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'အမျိုးအစား',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "အကြိုက်",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.search),
          //   label: 'Search',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.favorite),
          //   label: 'Favorites',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'အကောင့်',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
