import 'package:flutter/material.dart';
import 'package:movie_assignment/common/utils.dart';

class DetailScreen extends StatelessWidget {
  final String imageUrl;
  final double rating;
  final String summary;
  final String language;
  final List<String> genre; // Changed genre type to List<String>
  final String movieName; // Added movieName field

  const DetailScreen({
    Key? key,
    required this.imageUrl,
    required this.rating,
    required this.summary,
    required this.language,
    required this.genre, // List<String> passed here
    required this.movieName, // Movie name passed here
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(movieName, style: TextStyle(color: Colors.white))),
        backgroundColor: kBackgoundColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movie Poster Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Movie Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rating: $rating ⭐',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < rating ~/ 2 ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      );
                    }),
                  ),
                ],
              ),

              SizedBox(height: 15),

              // Movie Summary
              Text(
                'Summary',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                summary,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),

              SizedBox(height: 20),

              // Movie Language
              Chip(
                label: Text(
                  'Language: $language',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Color(0xffE50914),
              ),
              SizedBox(height: 10),

              // Movie Genre (List<String>)
              Wrap(
                spacing: 8.0, // spacing between chips
                children: genre.map((genre) {
                  return Chip(
                    label: Text(
                      genre,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Color(0xffE50914),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
