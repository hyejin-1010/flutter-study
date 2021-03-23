import 'package:flutter/material.dart';
import 'package:provider_study/src/model/movie.dart';
import 'package:provider_study/src/repository/movie_repository.dart';

class MovieProvider extends ChangeNotifier {
  MovieRepository _movieRepository = MovieRepository();

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  loadMovies() async {
    List<Movie> listMovies = await _movieRepository.loadMovies();
    // TODO: listMovies에 대해 예외처리 및 가공 절차
    _movies = listMovies;
    notifyListeners();
  }
}