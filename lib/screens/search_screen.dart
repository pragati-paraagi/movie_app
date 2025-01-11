import 'package:flutter/material.dart';
import 'package:movie_assignment/common/utils.dart';
import 'package:provider/provider.dart';
import '../provider/search_view_provider.dart';
import 'detail_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context); // Update to SearchProvider

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Search Movies',
          style: TextStyle(color: Color(0xffE50914)),
        ),
        backgroundColor: kBackgoundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search Movies',
                labelStyle: const TextStyle(
                  color: Colors.white,
                ),
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffE50914)),
                ),
              ),
              cursorColor: Colors.white,
              style: const TextStyle(
                color: Colors.white,
              ),
              onChanged: (query) {
                searchProvider.fetchMovies(query); // Update to use SearchProvider's fetchMovies
              },
            ),

            const SizedBox(height: 10),

            if (searchProvider.isLoading) const CircularProgressIndicator(),

            if (!searchProvider.isLoading && searchProvider.noResultsFound)
              const Center(
                child: Text(
                  'NO MATCH FOUND',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white54),
                ),
              ),

            if (!searchProvider.isLoading && searchProvider.searchResults.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: searchProvider.searchResults.length,
                  itemBuilder: (context, index) {
                    final movie = searchProvider.searchResults[index]['show'];
                    final imageUrl = movie['image'] != null
                        ? movie['image']['medium']
                        : 'https://via.placeholder.com/150';
                    final rating = movie['rating']['average']?.toDouble() ?? 0.0;
                    final summary = movie['summary'] != null
                        ? movie['summary'].replaceAll(RegExp(r'<[^>]*>'), '')
                        : 'No description available.';
                    final language = movie['language'] ?? 'N/A';
                    final genres = List<String>.from(movie['genres'] ?? []);
                    final movieName = movie['name'] ?? 'No title';

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              imageUrl: movie['image']?['original'] ?? 'https://via.placeholder.com/150',
                              rating: rating,
                              summary: summary,
                              language: language,
                              genre: genres,
                              movieName: movieName,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
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
                              Expanded(
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                movieName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
