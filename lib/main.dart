import 'package:app_new_movies/ui/screens/details_screen/datails_screen.dart';
import 'package:app_new_movies/ui/screens/home_screen.dart';
import 'package:app_new_movies/ui/screens/tabs/browser/browser_screen.dart';
import 'package:app_new_movies/ui/screens/tabs/home/home.dart';
import 'package:app_new_movies/ui/screens/tabs/search/search_screen.dart';
import 'package:app_new_movies/ui/screens/tabs/watchlist/watch_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
