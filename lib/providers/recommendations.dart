import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/movie_response.dart';
import '../services/movies.dart';

// TODO: This is very similar to movies_provider and logic could be re-used by
//  using/abusing the type param to choose which service call is made
final recommendationsProviderWithPaging =
    StateNotifierProvider.autoDispose.family<Recommendations, MovieResponse, num>((ref, id) {
  return Recommendations(ref.read(moviesServiceProvider), id);
});

class Recommendations extends StateNotifier<MovieResponse> {
  Recommendations(this._moviesService, this._id) : super(MovieResponse.initial()) {
    getRecommendations();
  }

  final MoviesService _moviesService;
  final num _id;

  bool get hasReachedEnd => (state.page - 1) >= state.totalPages;

  Future<void> getRecommendations() async {
    try {
      final moviesResponse = await _moviesService.getRecommendations(_id, state.page);

      state = state.copyWith(
        results: [...state.results, ...moviesResponse.results],
        page: state.page + 1,
        totalPages: moviesResponse.totalPages,
        totalResults: moviesResponse.totalResults,
        error: '',
      );
    } catch (e) {
      print('error getting recommendations by page: ${e.toString()}');
      state = state.copyWith(error: e.toString());
    }
  }

  void handleScrollWithIndex(int index) {
    final itemPosition = index + 1;
    final requestMoreData = itemPosition % 20 == 0 && itemPosition != 0;
    final pageToRequest = itemPosition ~/ 20;

    if (requestMoreData && pageToRequest + 1 >= state.page) {
      getRecommendations();
    }
  }
}
