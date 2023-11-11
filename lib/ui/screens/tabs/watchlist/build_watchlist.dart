import 'package:app_new_movies/data/model/recommended_movies_responses.dart';
import 'package:app_new_movies/data/repos/movies_repo/data_sources/online_data_sources.dart';
import 'package:app_new_movies/ui/widgets/error_widget.dart';
import 'package:app_new_movies/ui/widgets/loadeing_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../details_screen/datails_screen.dart';

class BuildWatchList extends StatefulWidget {
  static const String routeName = "WatchList";

  const BuildWatchList({super.key});

  @override
  State<BuildWatchList> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<BuildWatchList> {
  String baseUrl = "https://image.tmdb.org/t/p/w500";

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: OnlineDataSources.getMoviesFromFirebase(),
      builder: (context, snapshot) {
        if(snapshot.hasData)
        {
          return buildMovies(snapshot.data!);
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

  Widget buildMovies(List<ResultsRec> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return buildMovie(data[index]);
      },
    );
  }

  Widget buildMovie(ResultsRec data) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, DetailsScreen.routeName,
                  arguments: data.id.toString());
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: "$baseUrl${data.posterPath}",
                        height: MediaQuery.of(context).size.height * .20,
                        width: MediaQuery.of(context).size.width * .35,
                        placeholder: (context, url) {
                          return const LoadingWidget();
                        },
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) {
                          return const Center(
                            child: Icon(
                              Icons.error,
                              color: Color.fromARGB(255, 253, 178, 38),
                            ),
                          );
                        },
                      ),
                      const Image(image: AssetImage("assets/images/bookmark_selected.png"))
                    ],
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .09,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(data.title ?? "",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                                softWrap: false,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "${DateTime.tryParse(data.releaseDate!)?.year ?? "".toString()}",
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white54,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Color.fromARGB(255, 251, 174, 31),
                              size: 16),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            data.voteAverage!.toStringAsFixed(1),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const Divider(
            color: Colors.white,
            indent: 6,
            endIndent: 6,
          )
        ],
      ),
    );
  }
}
