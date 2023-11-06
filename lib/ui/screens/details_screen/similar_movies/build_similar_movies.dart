import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../data/model/similar_movies_responses.dart';
import '../../../widgets/loadeing_widget.dart';
import '../datails_screen.dart';

class BuildSimMovie extends StatelessWidget {
  ResultsSim simResults;

  BuildSimMovie({super.key, required this.simResults});

  String baseUrl = "https://image.tmdb.org/t/p/w500";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailsScreen.routeName,
            arguments: simResults.id.toString());
      },
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(6),
                        topLeft: Radius.circular(6)),
                    child: Stack(children: [
                      CachedNetworkImage(
                        imageUrl: "$baseUrl${simResults.posterPath}",
                        height: MediaQuery.of(context).size.height * .17,
                        width: MediaQuery.of(context).size.width * .26,
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
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6)),
              child: Container(
                padding: const EdgeInsets.all(4),
                width: MediaQuery.of(context).size.width * .26,
                height: MediaQuery.of(context).size.height * .068,
                color: const Color.fromARGB(255, 52, 53, 52),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Image(
                            image: AssetImage('assets/images/Group 16.png')),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          simResults.voteAverage!.toStringAsFixed(1),
                          style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                        width: 200,
                        child: Text(simResults.title ?? "",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 11),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false)),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          "${DateTime.tryParse(simResults.releaseDate!)?.year ?? "".toString()}",
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          simResults.originalLanguage ?? "",
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white54,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
