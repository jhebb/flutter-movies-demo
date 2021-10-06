import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/search_movies.dart';
import '../widgets/movies_grid.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({this.query = '', Key? key}) : super(key: key);

  final String query;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final searchMoviesController = watch(searchMoviesProviderWithPaging(query).notifier);
    final movies = watch(searchMoviesProviderWithPaging(query));

    return Scaffold(
      appBar: AppBar(
        title: Text('Search: $query'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          if (movies.error != '') {
            return const Text('oops, error');
          }

          if (movies.results.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return MoviesGrid(
            onRefresh: searchMoviesController.getMovies,
            hasReachedEnd: searchMoviesController.hasReachedEnd,
            movies: movies.results,
            onItemLoaded: searchMoviesController.handleScrollWithIndex,
          );
        },
      ),
    );
  }
}
