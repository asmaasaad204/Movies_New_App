import 'package:flutter/material.dart';
import '../../../../../data/model/upcoming_movies_responses.dart';
import '../../../../../data/repos/movies_repo/data_sources/online_data_sources.dart';
import '../../../../widgets/error_widget.dart';
import '../../../../widgets/loadeing_widget.dart';
import 'build_up_movie.dart';

class UpMovieList extends StatelessWidget {
  const UpMovieList({super.key});

  static late int upLength;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: OnlineDataSources.getUpcomingMovies(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildMoviesList(snapshot.data!);
        } else if (snapshot.hasError) {
          return ErrorView(message: snapshot.error.toString());
        } else {
          return const LoadingWidget();
        }
      },
    );
  }

  Widget buildMoviesList(List<ResultsUp> upMovie) {
    upLength = upMovie.length;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: upMovie.length,
      itemBuilder: (context, index) {
        return BuildUpMovie(resultsUp: upMovie[index]);
      },
    );
  }
}