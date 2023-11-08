import 'package:app_new_movies/ui/screens/tabs/browser/build_movie_widget.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/discover_movies_responses.dart';
import '../../../../data/repos/movies_repo/data_sources/online_data_sources.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/loadeing_widget.dart';

class BuildMovieListByGenresId extends StatelessWidget {
  String genresType;
  BuildMovieListByGenresId({super.key, required this.genresType});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: OnlineDataSources.getMoviesBrowse(genresType),
      builder: (context, snapshot) {
        if(snapshot.hasData)
        {
          return buildMovie(snapshot.data!);
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
    );
  }

  Widget buildMovie(List<ResultsDisc> genResults) {
    return ListView.builder(
      itemCount: genResults.length,
      itemBuilder: (context, index) {
        return BuildMovieWidget(genResults: genResults[index]);
      },
    );
  }
}