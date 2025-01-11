import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:movie_assignment/models/movie_model.dart';

const baseUrl = "https://api.tvmaze.com/search/";

class ApiServices {
  Future<List<ShowModel>> getMovies() async {
    String end = "shows?q=all";
    final url = "$baseUrl$end";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success: Fetched movies data");

      // Decode the response and parse the list of shows
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<ShowModel> shows = jsonResponse.map((data) {
        // Extract the `show` field from each result
        return ShowModel.fromJson(data['show']);
      }).toList();

      return shows;
    } else {
      throw Exception("Failed to load movies");
    }
  }
}
