import 'dart:ui';
import 'package:app_new_movies/data/repos/movies_repo/data_sources/online_data_sources.dart';
import 'package:app_new_movies/ui/widgets/error_widget.dart';
import 'package:app_new_movies/ui/widgets/loadeing_widget.dart';
import 'package:flutter/material.dart';
import '../../../../data/model/genre_movies_responses.dart';

class BuildCategoriesList extends StatefulWidget {
  static const routeName = "Browser Screen";
  Function onCategoryClick;
  BuildCategoriesList(this.onCategoryClick ,{super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BuildCategoriesList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Browse Category',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color(0xff121312),
      body: FutureBuilder(
        future: OnlineDataSources.getGenresList(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
          {
            return buildCategoriesList(snapshot.data!);
          }
          else if(snapshot.hasError)
          {
            return ErrorView(message: snapshot.error.toString());
          }
          else
          {
            return const LoadingWidget();
          }
        },
      ),
    );
  }

  Widget buildCategoriesList(List<MovieGenres> genres)
  {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GridView.builder(
        itemCount: genres.length,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          List<String> imageNames = [
            'assets/images/photo1.jpg',
            'assets/images/Adventure.jpeg',
            'assets/images/Animation.jpeg',
            'assets/images/Comedy.jpeg',
            'assets/images/Crime.jpeg',
            'assets/images/Documentary.jpeg',
            'assets/images/Drama.jpeg',
            'assets/images/Family.jpeg',
            'assets/images/Fantasy.jpeg',
            'assets/images/History.jpeg',
            'assets/images/Horror.jpeg',
            'assets/images/Music.jpeg',
            'assets/images/Mystery.jpeg',
            'assets/images/Romance.jpeg',
            'assets/images/Science Fiction.jpeg',
            'assets/images/TV Movie.jpeg',
            'assets/images/Thriller.jpeg',
            'assets/images/War.jpeg',
            'assets/images/Western.jpeg',
          ];
          return InkWell(
            onTap: () {
              widget.onCategoryClick(genres[index].id.toString());
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
              child: GridTile(
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      width: 180,
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(
                            imageNames[index],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 5,
                        bottom: 0,
                        left: 7,
                        right: 7,
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                            child: Container(
                              child: Center(
                                child: Text(
                                  genres[index].name??"",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}