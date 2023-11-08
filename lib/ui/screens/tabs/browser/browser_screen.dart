import 'package:app_new_movies/ui/screens/tabs/browser/build_category_list.dart';
import 'package:flutter/material.dart';

import 'build_movie_list_by_genres.dart';

class BrowserScreen extends StatefulWidget {
  static const routeName = "Browser Screen";

  const BrowserScreen({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BrowserScreen> {
  late Widget currentWidget;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentWidget = BuildCategoriesList(onCategoryClick);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
      if(currentWidget is! BuildCategoriesList)
      {
        currentWidget = BuildCategoriesList(onCategoryClick);
        setState(() {});
        return Future.value(false);
      }
      else
      {
        return Future.value(true);
      }
    },
    child: currentWidget
    );
  }

  onCategoryClick(String type)
  {
    setState(() {
      currentWidget = BuildMovieListByGenresId(genresType: type);
    });
  }
}