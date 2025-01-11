class ShowModel {
  String name;
  String language;
  List<String> genres;
  double rating;
  String? image; // Image can be null
  String summary;

  ShowModel({
    required this.name,
    required this.language,
    required this.genres,
    required this.rating,
    this.image, // Make image optional
    required this.summary,
  });

  factory ShowModel.fromJson(Map<String, dynamic> json) {
    return ShowModel(
      name: json['name'] ?? 'No Name', // Default value if name is missing
      language: json['language'] ?? 'Unknown', // Default if language is missing
      genres: List<String>.from(json['genres'] ?? []), // Default to an empty list if genres are missing
      rating: json['rating']['average']?.toDouble() ?? 0.0, // Safely handle missing or null rating
      image: json['image'] != null ? json['image']['medium'] : 'https://i.pinimg.com/736x/30/dc/2f/30dc2f5293bf4fe189f60f381e779e30.jpg', // Handle missing image
      summary: json['summary']?.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '') ?? 'No summary available', // Strip HTML tags
    );
  }
}
