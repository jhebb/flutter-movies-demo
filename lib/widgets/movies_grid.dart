import 'package:flutter/material.dart';

import '../models/movie.dart';
import 'movie_card.dart';

class MoviesGrid extends StatelessWidget {
  const MoviesGrid({
    this.movies = const [],
    required this.onRefresh,
    this.onItemLoaded,
    Key? key,
  }) : super(key: key);

  final List<Movie> movies;
  final Future<void> Function() onRefresh;
  final void Function(int)? onItemLoaded;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2 / 3),
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            // TODO replace this with a shared scrollController listener
            // OR a useScrollController hooks implementation
            if (onItemLoaded != null) {
              onItemLoaded!(index);
            }

            final Movie movie = movies[index];

            return MovieCard(movie: movie);
          },
        ),
      ),
    );
  }
}
