import 'package:app_new_movies/ui/screens/tabs/search/build_search_movie_list.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "Search Screen";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 19, 18),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            width: double.infinity,
            height: 55,
            child: TextField(
              controller: controller,
              onChanged: (value) {
                setState(() {
                  BuildSearchMovieList(
                    q: value,
                  );
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 55, 54, 53),
                prefixIcon: InkWell(
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  onTap: () {
                    setState(() {
                      BuildSearchMovieList(
                        q: controller.text,
                      );
                    });
                  },
                  child: const Icon(
                    Icons.search,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
                hintText: "Search",
                hintStyle: const TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
          Expanded(
            child: BuildSearchMovieList(q: controller.text),
          )
        ],
      ),
    );
  }
}