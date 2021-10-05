import 'movie.dart';

class MovieResponse {
  MovieResponse({
    this.page = 0,
    this.results = const [],
    this.totalPages = 0,
    this.totalResults = 0,
    this.error = '',
  });
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;
  String error;

  MovieResponse.initial()
      : results = [],
        page = 1,
        totalPages = 1,
        totalResults = 0,
        error = '';

  MovieResponse copyWith({List<Movie>? results, int? page, int? totalPages, int? totalResults, String? error}) {
    return MovieResponse(
      results: results ?? this.results,
      page: page ?? this.page,
      error: error ?? this.error,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    // TODO not sure if we need a try/catch here?
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
