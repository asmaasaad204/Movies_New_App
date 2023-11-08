import 'dart:convert';

import 'package:app_new_movies/data/model/discover_movies_responses.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../model/details_movie_responses.dart';
import '../../../model/genre_movies_responses.dart';
import '../../../model/movies_by_search_responses.dart';
import '../../../model/popular_movies_responses.dart';
import '../../../model/recommended_movies_responses.dart';
import '../../../model/similar_movies_responses.dart';
import '../../../model/upcoming_movies_responses.dart';

class OnlineDataSources {
  static const String baseUrl = "api.themoviedb.org";
  static const String simiBaseUrl = "api.themoviedb.org/3/movie/";
  static const String popularMoviesEndPoint = "/3/movie/popular";
  static const String upcomingMoviesEndPoint = "/3/movie/upcoming";
  static const String recommendedMoviesEndPoint = "/3/movie/top_rated";
  static const String detailsScreenEndPoint = "/3/movie/";
  static const String similarMoviesEndPoint = "/similar";
  static const String searchEndPoint = "/3/search/movie";
  static const String genresListEndPoint = "/3/genre/movie/list";
  static const String discoverEndPoint = "/3/discover/movie";

  static const Map<String, String> headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4YmNhZWJmMGQxMzEwYzA4YmMyZjkxNjc1M2JmZjY1ZSIsInN1YiI6IjY1M2ZlYjBlZTg5NGE2MDBmZjE4MTFhMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.jotI1JAx-7oGhzLmK4xguL84xkcpLxfJ4dhKyHLJfT4',
    'accept': 'application/json',
  };

  Future<PopularMoviesResponses> getPopularMovies() async {
    Uri url = Uri.https(baseUrl, popularMoviesEndPoint);
    Response response = await http.get(url, headers: headers);
    Map json = jsonDecode(response.body);
    PopularMoviesResponses popularMoviesResponses =
        PopularMoviesResponses.fromJson(json);
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        popularMoviesResponses.results!.isNotEmpty == true) {
      return popularMoviesResponses;
    }
    throw Exception("Something went wrong...!");
  }

  static Future<List<ResultsUp>> getUpcomingMovies() async {
    Uri url = Uri.https(baseUrl, upcomingMoviesEndPoint);
    Response response = await http.get(url, headers: headers);
    Map json = jsonDecode(response.body);
    UpcomingMoviesResponses upcomingMoviesResponses =
        UpcomingMoviesResponses.fromJson(json);
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        upcomingMoviesResponses.results!.isNotEmpty == true) {
      return upcomingMoviesResponses.results!;
    }
    throw Exception("Something went wrong...!");
  }

  static Future<List<ResultsRec>> getRecommendedMovies() async {
    Uri url = Uri.https(baseUrl, recommendedMoviesEndPoint);
    Response response = await http.get(url, headers: headers);
    Map json = jsonDecode(response.body);
    RecommendedMoviesResponses recommendedMoviesResponses =
        RecommendedMoviesResponses.fromJson(json);
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        recommendedMoviesResponses.results!.isNotEmpty == true) {
      return recommendedMoviesResponses.results!;
    }
    throw Exception("Something went wrong...!");
  }

  static Future<DetailsMovieResponses> getDetailsMovies(String id) async {
    Uri url = Uri.parse("https://$baseUrl$detailsScreenEndPoint$id");
    Response response = await http.get(url, headers: headers);
    Map json = jsonDecode(response.body);
    DetailsMovieResponses detailsMovieResponses =
        DetailsMovieResponses.fromJson(json);
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        id.isNotEmpty == true) {
      return detailsMovieResponses;
    }
    throw Exception("Something went wrong...!");
  }

  static Future<List<ResultsSim>> getSimilarMovies(String id) async {
    Uri url = Uri.parse("https://$simiBaseUrl$id$similarMoviesEndPoint");
    Response response = await http.get(url, headers: headers);
    Map json = jsonDecode(response.body);
    SimilarMoviesResponses similarMoviesResponses =
        SimilarMoviesResponses.fromJson(json);
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        id.isNotEmpty) {
      return similarMoviesResponses.results!;
    }
    throw Exception("Something went wrong...!");
  }

  static Future<List<MovieGenres>> getGenresList() async {
    Uri url = Uri.https(baseUrl, genresListEndPoint);
    Response response = await http.get(url, headers: headers);
    Map json = jsonDecode(response.body);
    GenresMovieListResponses genresMovieListResponses =
        GenresMovieListResponses.fromJson(json);
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        genresMovieListResponses.genres!.isNotEmpty == true) {
      return genresMovieListResponses.genres!;
    }
    throw "Something went wrong please try again later...!";
  }

  static Future<List<Results>> getMoviesBySearch(String q) async {
    Uri url = Uri.https(baseUrl, searchEndPoint, {"query": q});
    Response response = await http.get(url, headers: headers);
    Map json = jsonDecode(response.body);
    MoviesBySearchResponses moviesBySearchResponses =
        MoviesBySearchResponses.fromJson(json);
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        q.isNotEmpty) {
      return moviesBySearchResponses.results!;
    }
    throw Exception("Something went wrong...!");
  }

  static Future<List<ResultsDisc>> getMoviesBrowse(String id) async {
    Uri url = Uri.https(baseUrl, discoverEndPoint, {"with_genres": id});
    Response response = await http.get(url, headers: headers);
    Map json = jsonDecode(response.body);
    DiscoverMoviesResponses discoverMoviesResponses =
        DiscoverMoviesResponses.fromJson(json);
    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        id.isNotEmpty) {
      return discoverMoviesResponses.results!;
    }
    throw Exception("Something went wrong...!");
  }
}