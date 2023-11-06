import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../data/model/upcoming_movies_responses.dart';
import '../../../../widgets/loadeing_widget.dart';
import '../../../details_screen/datails_screen.dart';

class BuildUpMovie extends StatelessWidget {
  ResultsUp resultsUp;

  BuildUpMovie({super.key, required this.resultsUp});

  String baseUrl = "https://image.tmdb.org/t/p/w500";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailsScreen.routeName,
            arguments: resultsUp.id.toString());
      },
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Stack(children: [
                      CachedNetworkImage(
                        imageUrl: "$baseUrl${resultsUp.posterPath}",
                        height: MediaQuery.of(context).size.height * .19,
                        width: MediaQuery.of(context).size.width * .28,
                        fit: BoxFit.fill,
                        placeholder: (_, __) =>
                            const Center(child: LoadingWidget()),
                        errorWidget: (_, __, ___) => const Icon(
                          Icons.error,
                          color: Color.fromRGBO(253, 174, 26, 1.0),
                        ),
                      ),
                      InkWell(
                          onTap: () {},
                          child: const Image(
                              image: AssetImage('assets/images/bookmark.png'))),
                    ])),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
