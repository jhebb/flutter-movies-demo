import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config.dart';
import '../enums/movie_type.dart';
import '../models/movie.dart';
import '../models/movie_response.dart';
import '../services/movies.dart';
import 'dio.dart';
import 'movie_type.dart';

final moviesProvider = FutureProvider<List<Movie>>((ref) async {
  final MovieType movieType = ref.watch(movieTypeProvider).state;
  final dio = ref.watch(dioProvider);

  try {
    final response =
        await dio.get('movie/${movieType.value}', queryParameters: {'api_key': Config.API_KEY, 'region': 'CA'});
    return MovieResponse.fromJson(response.data).results;
  } catch (e) {
    print('oops: ${e.toString()}');
    return <Movie>[];
  }
});

final moviesProviderWithPaging = StateNotifierProvider<Movies, MovieResponse>((ref) {
  return Movies(ref.read(moviesServiceProvider), ref.watch(movieTypeProvider).state);
});

class Movies extends StateNotifier<MovieResponse> {
  Movies(this._moviesService, this._type) : super(MovieResponse.initial()) {
    getMovies();
  }

  final MoviesService _moviesService;
  final MovieType _type;

  Future<void> getMovies() async {
    print('getting movies!');
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
