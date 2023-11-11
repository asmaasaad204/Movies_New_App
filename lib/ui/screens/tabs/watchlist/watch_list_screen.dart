import 'package:app_new_movies/ui/screens/tabs/watchlist/build_watchlist.dart';
import 'package:flutter/material.dart';

class WatchListScreen extends StatefulWidget {
  static const String routeName = "WatchList";

  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  String baseUrl = "https://image.tmdb.org/t/p/w500";

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 19, 18),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 19, 18),
        elevation: 0,
        title: const Text("Watchlist",
          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),),
      ),
      body: const BuildWatchList(),
    );
  }
}
