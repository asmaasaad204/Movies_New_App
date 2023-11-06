import 'package:flutter/material.dart';
import '../../../../data/model/similar_movies_responses.dart';
import '../../../../data/repos/movies_repo/data_sources/online_data_sources.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/loadeing_widget.dart';
import 'build_similar_movies.dart';

class SimilarMovieList extends StatelessWidget {
  late String id;

  SimilarMovieList({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
   id = ModalRoute.of(context)!.settings.arguments as String;

    return FutureBuilder(
      future: OnlineDataSources.getSimilarMovies(id),
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

  Widget buildMoviesList(List<ResultsSim> simMovie) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: simMovie.length,
      itemBuilder: (context, index) {
        return BuildSimMovie(simResults: simMovie[index]);
      },
    );
  }
}