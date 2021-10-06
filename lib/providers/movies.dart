import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/movie_type.dart';
import '../models/movie_response.dart';
import '../services/movies.dart';
import 'movie_type.dart';

final moviesProviderWithPaging = StateNotifierProvider<Movies, MovieResponse>((ref) {
  return Movies(ref.read(moviesServiceProvider), ref.watch(movieTypeProvider).state);
});

class Movies extends StateNotifier<MovieResponse> {
  Movies(this._moviesService, this._type) : super(MovieResponse.initial()) {
    getMovies();
  }

  final MoviesService _moviesService;
  final MovieType _type;

  bool get hasReachedEnd => (state.page - 1) >= state.totalPages;

  // TODO: handle refresh scenarios - right now we just requery the last query and add a page
  Future<void> getMovies() async {
    try {
      final moviesResponse = await _moviesService.getMovies(_type, state.page);

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
