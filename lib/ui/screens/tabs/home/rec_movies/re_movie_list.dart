import 'package:flutter/material.dart';
import '../../../../../data/model/recommended_movies_responses.dart';
import '../../../../../data/repos/movies_repo/data_sources/online_data_sources.dart';
import '../../../../widgets/error_widget.dart';
import '../../../../widgets/loadeing_widget.dart';
import 'build_re_movie.dart';

class ReMovieList extends StatelessWidget {
  const ReMovieList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: OnlineDataSources.getRecommendedMovies(),
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

  Widget buildMoviesList(List<ResultsRec> reMovie) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: reMovie.length,
      itemBuilder: (context, index) {
        return BuildReMovie(resultsRe: reMovie[index]);
      },
    );
  }
}