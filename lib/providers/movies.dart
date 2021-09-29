import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config.dart';
import '../enums/movie_type.dart';
import '../models/movie.dart';
import '../models/movie_response.dart';
import 'dio.dart';
import 'movie_type.dart';

final moviesProvider = FutureProvider<List<Movie>>((ref) async {
  final MovieType movieType = ref.watch(movieTypeProvider).state;
  final dio = ref.watch(dioProvider);

  print('are we here?');

  try {
    final response = await dio.get('movie/${movieType.value}', queryParameters: {'api_key': Config.API_KEY});
    print('data: $response');
    return MovieResponse.fromJson(response.data).results;
  } catch (e) {
    print('oops: ${e.toString()}');
    return <Movie>[];
  }
});
