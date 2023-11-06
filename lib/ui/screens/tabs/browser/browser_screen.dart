import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BrowserScreen extends StatefulWidget {
  static const routeName = "Browser Screen";

  const BrowserScreen({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BrowserScreen> {
  List<dynamic> genres = [];

  @override
  void initState() {
    super.initState();
    fetchGenres();
  }

  Future<void> fetchGenres() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/genre/movie/list?api_key=8bcaebf0d1310c08bc2f916753bff65e'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        genres = data['genres'];
      });
    } else {
      print('Failed to fetch genres');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Browse Category',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color(0xff121312),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: GridView.builder(
          itemCount: genres.length,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            List<String> imageNames = [
              'assets/images/photo1.jpg',
              'assets/images/Adventure.jpeg',
              'assets/images/Animation.jpeg',
              'assets/images/Comedy.jpeg',
              'assets/images/Crime.jpeg',
              'assets/images/Documentary.jpeg',
              'assets/images/Drama.jpeg',
              'assets/images/Family.jpeg',
              'assets/images/Music.jpeg',
              'assets/images/History.jpeg',
              'assets/images/Horror.jpeg',
              'assets/images/Fantasy.jpeg',
              'assets/images/Mystery.jpeg',
              'assets/images/Romance.jpeg',
              'assets/images/Science Fiction.jpeg',
              'assets/images/TV Movie.jpeg',
              'assets/images/Thriller.jpeg',
              'assets/images/War.jpeg',
              'assets/images/Western.jpeg',
            ];
            return Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 4, right: 5),
              child: GridTile(
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        ///Click to another screen
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        width: 300,
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(
                              imageNames[index],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 35,
                        bottom: 0,
                        left: 1,
                        right: 10,
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                            child: Container(
                              child: Center(
                                child: Text(
                                  genres[index]['name'],
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
