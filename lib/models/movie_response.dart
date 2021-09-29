import 'movie.dart';

class MovieResponse {
  MovieResponse({
    this.page = 0,
    required this.results,
    this.totalPages = 0,
    this.totalResults = 0,
    this.error = '',
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;
  String error;

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    print('totalPages: ${json['total_pages']}');
    print('totalResults: ${json['total_results']}');
    try {
      return MovieResponse(
        page: json['page'] ?? 1,
        results: json['results'] != null
            ? List<Movie>.from(json['results'].map((result) => Movie.fromJson(result)))
            : <Movie>[],
        totalPages: json['total_pages'] ?? 0,
        totalResults: json['total_results'] ?? 0,
      );
    } catch (error) {
      print('movie response broke');
      print(error.toString());
      return MovieResponse(results: <Movie>[], error: error.toString());
    }
  }
}
