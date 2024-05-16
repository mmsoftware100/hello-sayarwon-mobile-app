import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hellosayarwon/hellosayarwon/presentation/pages/articles/article_list_page.dart';

import '../../../data/const/constants.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/HomePage";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text("1"),),
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
    int pageNo = 1;
    int categoryId = 0;
    // for offline

    /*
    Provider.of<ImirrorProvider>(context, listen: false).selectArticlePlz(accessToken: "accessToken", pageNo: pageNo, projectId: projectId, categoryId: categoryId, query: "", local: true);

    Provider.of<ImirrorProvider>(context, listen: false).selectArticlePlz(accessToken: "accessToken", pageNo: pageNo, projectId: projectId, categoryId: categoryId, query: "");
    Provider.of<ImirrorProvider>(context, listen: false).selectCategoryListPlz(accessToken: "accessToken", pageNo: pageNo, projectId: projectId);
    Provider.of<ImirrorProvider>(context, listen: false).getProjectInfoPlz(projectId: projectId);
    bool updateStatus = await Provider.of<ImirrorProvider>(context, listen: false).getUpdateInfoPlz(projectId: projectId);
    if(updateStatus == true){
      // check api response
      UpdateInfo updateInfo = Provider.of<ImirrorProvider>(context, listen: false).updateInfo;
      if(updateInfo.update){
        // now show alert
        return showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text(title),
                content: Text("New Version!"),
                actions: [
                  updateInfo.force == false ? TextButton(
                      onPressed: (){
                        // we can dismis
                        Navigator.pop(context);
                      },
                      child: Text("Cancel")): Container(),
                  TextButton(
                      onPressed: ()async{
                        Navigator.pop(context);
                        // open download link
                        if (!await launchUrl(Uri.parse(updateInfo.downloadLink))) {
                          throw Exception('Could not launch ${updateInfo.downloadLink}');
                        }
                        else{
                          print("can not open");
                        }

                      },
                      child: Text("Update"))

                ],
              );
            }
        );
      }
    }
    
     */

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
            icon: Icon(Icons.article),
            label: "နေရာ",
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
            label: 'ဆက်သွယ်ပါ',
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
