import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/movies.dart';
import 'movies_grid.dart';

class MovieList extends ConsumerWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final moviesController = watch(moviesProviderWithPaging.notifier);
    final movies = watch(moviesProviderWithPaging);

    if (movies.error != '') {
      return const Text('oops, error');
    }

    if (movies.results.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return MoviesGrid(
      movies: movies.results,
      onRefresh: moviesController.getMovies,
      onItemLoaded: moviesController.handleScrollWithIndex,
    );
  }
}
