import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/movie_response.dart';
import '../services/movies.dart';

final searchMoviesProviderWithPaging =
    StateNotifierProvider.autoDispose.family<Movies, MovieResponse, String>((ref, query) {
  print('recreating provider $query');
  // TODO should query be passed in from widget or be it's own provider
  return Movies(ref.read(moviesServiceProvider), query);
});

class Movies extends StateNotifier<MovieResponse> {
  Movies(this._moviesService, this._query) : super(MovieResponse.initial()) {
    getMovies();
  }

  final MoviesService _moviesService;
  final String _query;

  Future<void> getMovies() async {
    print('getting movies for $_query!');
    try {
      final moviesResponse = await _moviesService.searchMovies(_query, state.page);

      state = state.copyWith(
        results: [...state.results, ...moviesResponse.results],
        page: state.page + 1,
        totalPages: moviesResponse.totalPages,
        totalResults: moviesResponse.totalResults,
        error: '',
      );
    } catch (e) {
      print('error getting movies by page: ${e.toString()}');
      state = state.copyWith(error: e.toString());
    }
  }

  void handleScrollWithIndex(int index) {
    final itemPosition = index + 1;
    final requestMoreData = itemPosition % 20 == 0 && itemPosition != 0;
    final pageToRequest = itemPosition ~/ 20;

    if (requestMoreData && pageToRequest + 1 >= state.page) {
      getMovies();
    }
  }
}
