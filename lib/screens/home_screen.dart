import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_assignment/provider/movie_provider.dart';
import 'package:movie_assignment/screens/search_screen.dart';
import 'package:provider/provider.dart';
import '../models/movie_model.dart';
import '../screens/detail_screen.dart';
import '../common/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch movies when the screen initializes
    Provider.of<MovieProvider>(context, listen: false).fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgoundColor,
        title: Image.asset(
          "assets/img.png",
          height: 50,
          width: 100,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  _fadeTransition(SearchScreen()),
                );
              },
              child: Icon(Icons.search, size: 30, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25),
            Consumer<MovieProvider>(
              builder: (context, movieProvider, child) {
                if (movieProvider.movies.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<ShowModel> movies = movieProvider.movies;

                return Column(
                  children: [
                    Container(
                      color: Colors.black,
                      width: double.infinity,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 370.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                        items: movies.take(3).map((movie) {
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigate with the specific movie object when an item is tapped
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                        movieName: movie.name,
                                        imageUrl: movie.image ??
                                            "https://i.pinimg.com/736x/30/dc/2f/30dc2f5293bf4fe189f60f381e779e30.jpg",
                                        rating: movie.rating,
                                        summary: movie.summary,
                                        genre: movie.genres,
                                        language: movie.language,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xffE50914).withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        movie.image ??
                                            'https://i.pinimg.com/736x/30/dc/2f/30dc2f5293bf4fe189f60f381e779e30.jpg',
                                        height: 310,
                                        width: 300,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    movieName: movie.name,
                                    imageUrl: movie.image ??
                                        "https://i.pinimg.com/736x/30/dc/2f/30dc2f5293bf4fe189f60f381e779e30.jpg",
                                    rating: movie.rating,
                                    summary: movie.summary,
                                    genre: movie.genres,
                                    language: movie.language,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffE50914).withOpacity(0.5),
                                    spreadRadius: 4,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10),
                                        ),
                                        child: Image.network(
                                          movie.image ??
                                              'https://i.pinimg.com/736x/30/dc/2f/30dc2f5293bf4fe189f60f381e779e30.jpg',
                                          height: 250,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        right: 10,
                                        bottom: 10,
                                        child: InkWell(
                                          onTap: () {
                                            Provider.of<MovieProvider>(
                                              context,
                                              listen: false,
                                            ).toggleFavorite(index);
                                          },
                                          child: Icon(
                                            movieProvider.isFavorite[index]
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: movieProvider.isFavorite[index]
                                                ? Color(0xffE50914)
                                                : Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        Text(
                                          'Rating: ${movie.rating} ⭐',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  PageRouteBuilder _fadeTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
