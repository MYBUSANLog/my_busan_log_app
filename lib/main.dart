import 'package:busan_trip/model/item_model.dart';
import 'package:busan_trip/model/join_model.dart';
import 'package:busan_trip/model/store_model.dart';
import 'package:busan_trip/model/user_model.dart';
import 'package:busan_trip/screen/accouncement_list_screen.dart';
import 'package:busan_trip/screen/bookmark_list_screen.dart';
import 'package:busan_trip/screen/item_detail_screen.dart';
import 'package:busan_trip/screen/heart_list_screen.dart';
import 'package:busan_trip/screen/home_screen.dart';
import 'package:busan_trip/screen/intro_screen.dart';
import 'package:busan_trip/screen/login.dart';
import 'package:busan_trip/screen/login_opening_screen.dart';
import 'package:busan_trip/screen/notification_screen.dart';
import 'package:busan_trip/screen/realtime_list_screen.dart';
import 'package:busan_trip/screen/review_list_screen.dart';
import 'package:busan_trip/screen/root_screen.dart';
import 'package:busan_trip/screen/searchingpage.dart';
import 'package:busan_trip/screen/sign_up.dart'; //회원가입 추가
import 'package:busan_trip/screen/sign_up2.dart';
import 'package:busan_trip/screen/sign_up3.dart';
import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:busan_trip/screen/chatbot.dart';
import 'package:busan_trip/screen/receipt.dart';
import 'package:busan_trip/screen/pay_screen.dart';
import 'package:busan_trip/screen/profile_alter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_user.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; //구글로그인

//새로운 작업 from 정민
// new repository

// 새로운 수정사항(Text)


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //구글로그인 영욱
  await NaverMapSdk.instance.initialize(
    clientId: 'qzi0n4lbj9',
  );

  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
    nativeAppKey: '3cbc4103340e6be3c6247d5228d55534',
    // javaScriptAppKey: 'e09856d7367e723cf282ead8d304029a',
  );

  await initializeDateFormatting('ko_KR', null);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    //   statusBarIconBrightness: Brightness.dark,
    //   systemNavigationBarColor: Colors.white,
    // ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => JoinModel()),
        ChangeNotifierProvider(create: (context) => UserModel()),
        ChangeNotifierProvider(create: (context) => ItemModel()),
        ChangeNotifierProvider(create: (context) => StoreModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
      
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white), //화이트로 수정 영욱
          useMaterial3: true,
        ),
        //인트로스크린 수진 추가
        home:FutureBuilder(
          future: Future.delayed(const Duration(seconds: 6), () => "Intro Completed."),
          builder: (context, snapshot) {
            return AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                child: _splashLoadingWidget(snapshot)
            );
          },
        ),
        //RootScreen(), //위에 주석하고 아래 추가 영욱
        // initialRoute: '/home',
        //영욱 추가 -> root_screen으로 대체(기존 코드 주석처리)
        routes: {
          /* '/ai_recommend': (context) => AIRecommendScreen(),
          '/notifications': (context) => NotificationsScreen(),*/
          '/home': (context) => HomeScreen(),
          // '/profile': (context) => ProfileScreen(),
          '/chatbot': (context) => ChatbotScreen(),
          '/receipt': (context) => ReceiptScreen(),
          '/profile_alter': (context) => ProfileAlterScreen(),
          '/realtime_list_screen': (context) => RealtimeListScreen(),
          '/root_screen':(context) => RootScreen(),
          '/detail_screen':(context) => ItemDetailScreen(),
          '/notification_screen': (context) => NotificationScreen(),
          '/sign_up': (context) => SignUpScreen(), // Sign up route 추가
          // 리뷰 북마크 찜목록 공지사항 추가 안율현
          '/bookmark_list': (context) => BookmarkListScreen(),
          '/heart_list': (context) => HeartListScreen(),
          '/review_list': (context) => ReviewListScreen(),
          '/announcement_list': (context) => AccouncementListScreen(),
          '/login': (context) => LoginScreen(),
          '/sign_up2': (context) => SignUp2(),
          '/sign_up3': (context) => SignUp3(),
          '/login_opening_screen': (context) => LoginOpeningScreen(),
          '/searchingpage': (context) => Searchingpage(),
          '/daumpostcodesearchexample': (context) => DaumPostcodeSearch(),
      
          // '/restaurant_map' : (context) => RestaurantMap(),
        },
      
      ),
    );
  }
}
//intro screen 수진추가
Widget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
  if(snapshot.hasError) {
    return const Text("Error!!");
  } else if(snapshot.hasData) {
    // return LoginOpeningScreen();
    return RootScreen();
  } else {
    return const IntroScreen();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
