import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_lister_app/api/movie_model.dart';

class API {
  static const apiKey =
      String.fromEnvironment('API_KEY', defaultValue: 'API_KEY_ERROR');
  static const imgPath = 'https://image.tmdb.org/t/p/w500';
  static const imgPathHQ = 'https://image.tmdb.org/t/p/original';

  static const _trendingURL =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=$apiKey';
  static const _nowPlayingURL =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey';
  static const _topRatedURL =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey';

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingURL));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['results'] as List;
      return data.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Error');
    }
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await http.get(Uri.parse(_nowPlayingURL));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['results'] as List;
      return data.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Error');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(_topRatedURL));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['results'] as List;
      return data.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Error');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?query=$query&include_adult=false&page=1&api_key=$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['results'] as List;
      return data.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Error');
    }
  }
}
