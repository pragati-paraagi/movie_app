import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchProvider with ChangeNotifier {
  List<dynamic> searchResults = [];
  bool isLoading = false;
  bool noResultsFound = false;

  Future<void> fetchMovies(String searchTerm) async {
    if (searchTerm.isEmpty) {
      searchResults = [];
      noResultsFound = false;
      notifyListeners();
      return;
    }

    isLoading = true;
    noResultsFound = false;
    notifyListeners();

    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$searchTerm'));

    if (response.statusCode == 200) {
      final List<dynamic> results = jsonDecode(response.body);

      isLoading = false;
      searchResults = results;

      // If no results are found, set the noResultsFound flag
      if (results.isEmpty) {
        noResultsFound = true;
      }
      notifyListeners();
    } else {
      isLoading = false;
      searchResults = [];
      noResultsFound = true; // Show no results message in case of error
      notifyListeners();
    }
  }
}
