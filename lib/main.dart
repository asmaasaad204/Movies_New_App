import 'package:app_new_movies/ui/screens/details_screen/datails_screen.dart';
import 'package:app_new_movies/ui/screens/home_screen.dart';
import 'package:app_new_movies/ui/screens/tabs/browser/browser_screen.dart';
import 'package:app_new_movies/ui/screens/tabs/home/home.dart';
import 'package:app_new_movies/ui/screens/tabs/search/search_screen.dart';
import 'package:app_new_movies/ui/screens/tabs/watchlist/watch_list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          HomeScreen.routeName: (_) => const HomeScreen(),
          Home.routeName: (_) => Home(),
          BrowserScreen.routeName: (_) => const BrowserScreen(),
          SearchScreen.routeName: (_) => const SearchScreen(),
          WatchListScreen.routeName: (_) => const WatchListScreen(),
          DetailsScreen.routeName: (_) => DetailsScreen(),
        },
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}