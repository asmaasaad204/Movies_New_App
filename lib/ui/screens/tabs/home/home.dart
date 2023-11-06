import 'package:app_new_movies/ui/screens/tabs/home/pop_movie_model_view.dart';
import 'package:app_new_movies/ui/screens/tabs/home/rec_movies/re_movie_list.dart';
import 'package:app_new_movies/ui/screens/tabs/home/up_movies/up_movie_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/model/popular_movies_responses.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/loadeing_widget.dart';
import '../../details_screen/datails_screen.dart';

class Home extends StatefulWidget {
  static const String routeName = "Home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PopMoviesModelView modelView = PopMoviesModelView();
  String baseUrl = "https://image.tmdb.org/t/p/w500";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      modelView.getPop();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentView;
    return BlocBuilder<PopMoviesModelView, MoviesStatePop>(
      bloc: modelView,
      builder: (context, state) {
        if (state is LoadingStatePop) {
          currentView = const LoadingWidget();
        } else if (state is SuccessStatePop) {
          currentView = buildPopMovieHome(state.results);
        } else {
          currentView = ErrorView(message: (state as ErrorStatePop).errorText);
        }
        return currentView;
      },
    );
  }

  Widget buildPopMovieHome(List<ResultsPop> results) {
    return Column(
      children: [
        Expanded(
            flex: 4,
            child: CarouselSlider(
                items: results.map((movie) => buildPopMovie(movie)).toList(),
                options: CarouselOptions(autoPlay: true, viewportFraction: 1))),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.all(8),
            color: const Color.fromARGB(255, 40, 42, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 16, top: 4),
                    child: const Text(
                      "New release",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
                const Expanded(child: UpMovieList()),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.all(8),
            color: const Color.fromARGB(255, 40, 42, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 16, top: 4),
                    child: const Text(
                      "Recommended",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
                const Expanded(child: ReMovieList()),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildPopMovie(ResultsPop movie) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        CachedNetworkImage(
          imageUrl: "$baseUrl${movie.backdropPath}",
          height: MediaQuery.of(context).size.height * double.infinity,
          width: MediaQuery.of(context).size.width * double.infinity,
          placeholder: (_, __) => const Center(child: LoadingWidget()),
          errorWidget: (_, __, ___) => const Icon(
            Icons.error,
            color: Color.fromRGBO(253, 174, 26, 1.0),
          ),
        ),
        Container(
          width: double.infinity,
          height: 60,
          color: const Color.fromARGB(255, 40, 42, 40),
          child: Row(
            children: [
              const SizedBox(
                width: 130,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 200,
                          child: Text(
                            movie.title ?? "",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        DateTime.parse(movie.releaseDate ?? "").year.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(movie.adult! ? "PG-3" : "R",
                          style: const TextStyle(
                              color: Colors.white54, fontSize: 11)),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 18,
          child: Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, DetailsScreen.routeName,
                      arguments: movie.id.toString());
                },
                child: CachedNetworkImage(
                  imageUrl: "$baseUrl${movie.posterPath}",
                  height: MediaQuery.of(context).size.height * .18,
                  width: MediaQuery.of(context).size.width * .27,
                  fit: BoxFit.fill,
                  placeholder: (_, __) => const Center(child: LoadingWidget()),
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.error,
                    color: Color.fromRGBO(253, 174, 26, 1.0),
                  ),
                ),
              ),
            ),
            InkWell(
                onTap: () {},
                child: const Image(
                    image: AssetImage('assets/images/bookmark.png')))
          ]),
        )
      ],
    );
  }
}
