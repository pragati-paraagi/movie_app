import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../services/api.dart';

class MovieProvider with ChangeNotifier {
  List<ShowModel> _movies = [];
  List<bool> _isFavorite = [];

  List<ShowModel> get movies => _movies;
  List<bool> get isFavorite => _isFavorite;

  final ApiServices _apiServices = ApiServices();

  Future<void> fetchMovies() async {
    try {
      _movies = await _apiServices.getMovies();
      _isFavorite = List<bool>.filled(_movies.length, false);
      notifyListeners();
    } catch (e) {
      // Handle the error
      print('Error fetching movies: $e');
    }
  }

  void toggleFavorite(int index) {
    _isFavorite[index] = !_isFavorite[index];
    notifyListeners();
  }
}
