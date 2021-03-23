import 'dart:convert';

import 'package:provider_study/src/model/movie.dart';
import 'package:http/http.dart' as http;

class MovieRepository {
  var queryParam = { 'api_key': '6740b184474d24a65c6e5be930d48040' };

  Future<List<Movie>> loadMovies() async {
    var uri = Uri.https("api.themoviedb.org", "/3/movie/popular", queryParam);
    var response = await http.get(uri);

    if (response.body != null) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body["results"] != null) {
        List<dynamic> list = body["results"];
        return list.map<Movie>((item) => Movie.fromJson(item)).toList();
      }
    }
  }
}