import 'package:app_new_movies/ui/screens/details_screen/similar_movies/similar_movie_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../data/model/details_movie_responses.dart';
import '../../../data/repos/movies_repo/data_sources/online_data_sources.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loadeing_widget.dart';

class DetailsScreen extends StatelessWidget {
  static const String routeName = "DetailsScreen";
  late String id;
  String baseUrl = "https://image.tmdb.org/t/p/w500";

  DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    id = ModalRoute.of(context)!.settings.arguments as String;

    return FutureBuilder(
      future: OnlineDataSources.getDetailsMovies(id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildDetailsMovie(snapshot.data!, context);
        } else if (snapshot.hasError) {
          return ErrorView(message: snapshot.error.toString());
        } else {
          return const LoadingWidget();
        }
      },
    );
  }

  Widget buildDetailsMovie(
      DetailsMovieResponses detailsMovieResponses, BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 19, 18),
      appBar: AppBar(
        title: Text(
          detailsMovieResponses.title ?? "",
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
        ),
        backgroundColor: const Color.fromARGB(255, 29, 30, 29),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: SizedBox(
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: "$baseUrl${detailsMovieResponses.backdropPath}",
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: LoadingWidget()),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Color.fromRGBO(253, 174, 26, 1.0),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    detailsMovieResponses.title ?? "",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        DateTime.parse(detailsMovieResponses.releaseDate ?? "")
                            .year
                            .toString(),
                        style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(detailsMovieResponses.originalLanguage ?? "",
                          style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 13,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "$baseUrl${detailsMovieResponses.posterPath}",
                              height: MediaQuery.of(context).size.height * .25,
                              placeholder: (context, url) =>
                                  const LoadingWidget(),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                      child: Icon(
                                Icons.error,
                                color: Color.fromRGBO(253, 174, 26, 1.0),
                              )),
                            ),
                          )),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              GridView.builder(
                                  shrinkWrap: true,
                                  controller:
                                      ScrollController(keepScrollOffset: false),
                                  itemCount:
                                      detailsMovieResponses.genres!.length,
                                  itemBuilder: (context, index) => Container(
                                        margin: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 2, color: Colors.grey)),
                                        child: Center(
                                            child: Text(
                                          detailsMovieResponses.genres![index]
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.white54,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10),
                                        )),
                                      ),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 3.7 / 2.5,
                                  )),
                              const SizedBox(
                                height: 6,
                              ),
                              Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  height: 70,
                                  width: double.infinity,
                                  child: SingleChildScrollView(
                                      child: Text(
                                    detailsMovieResponses.overview ?? "",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                  ))),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .01,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Color.fromARGB(255, 253, 176, 33),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      detailsMovieResponses.voteAverage!
                                          .toStringAsFixed(1)
                                          .toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: const Color.fromARGB(255, 40, 42, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, left: 12),
                      child: Text(
                        "More Like This",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: SimilarMovieList(
                        id: detailsMovieResponses.id.toString(),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
