import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config.dart';
import '../enums/movie_type.dart';
import '../models/movie_response.dart';
import '../providers/dio.dart';

final moviesServiceProvider = Provider((ref) => MoviesService(ref));

class MoviesService {
  MoviesService(this.ref) : _dio = ref.read(dioProvider);

  final ProviderReference ref;
  final Dio _dio;

  Future<MovieResponse> getMovies(MovieType type, [int page = 1]) async {
    final response = await _dio
        .get('movie/${type.value}', queryParameters: {'api_key': Config.API_KEY, 'region': 'CA', 'page': page});

    return MovieResponse.fromJson(response.data);
  }
}
