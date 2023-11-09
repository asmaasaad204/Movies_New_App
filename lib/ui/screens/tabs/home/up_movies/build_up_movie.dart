import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../data/model/upcoming_movies_responses.dart';
import '../../../../widgets/loadeing_widget.dart';
import '../../../details_screen/datails_screen.dart';

class BuildUpMovie extends StatefulWidget {
  ResultsUp resultsUp;
  BuildUpMovie({super.key, required this.resultsUp});

  @override
  State<BuildUpMovie> createState() => _BuildUpMovieState();
}

class _BuildUpMovieState extends State<BuildUpMovie> {
  String baseUrl = "https://image.tmdb.org/t/p/w500";
  String urlM = "assets/images/bookmark.png";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailsScreen.routeName,
            arguments: widget.resultsUp.id.toString());
      },
      child: Column(
        children: [
          const SizedBox(height: 18,),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child:
                    Stack(children: [
                      CachedNetworkImage(
                        imageUrl: "$baseUrl${widget.resultsUp.posterPath}",
                        height: MediaQuery.of(context).size.height * .175,
                        width: MediaQuery.of(context).size.width * .26,
                        fit: BoxFit.fill,
                        placeholder: (_, __) => const Center(child: LoadingWidget()),
                        errorWidget: (_, __, ___) => const Icon(Icons.error, color: Color.fromRGBO(253, 174, 26, 1.0),),
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              if (urlM == "assets/images/bookmark.png") {
                                saveMovies(widget.resultsUp);
                                urlM = "assets/images/bookmark_selected.png";
                              } else {
                                deleteMovies(widget.resultsUp);
                                urlM = "assets/images/bookmark.png";
                              }
                            });
                          },
                          child: Image(image: AssetImage(urlM))),
                    ])),
              ),
            ],
          ),
        ],
      ),
    );
  }

  saveMovies(ResultsUp resultsUp)
  {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("Movies");
    DocumentReference documentReference = collectionReference.doc(resultsUp.id.toString());
    documentReference.set(resultsUp.toJson());
  }

  deleteMovies(ResultsUp resultsUp)
  {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("Movies");
    DocumentReference documentReference = collectionReference.doc(resultsUp.id.toString());
    documentReference.delete();
  }
}