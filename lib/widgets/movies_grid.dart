import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/movie.dart';
import '../providers/settings.dart';
import 'movie_card.dart';

class MoviesGrid extends ConsumerWidget {
  const MoviesGrid({
    this.movies = const [],
    required this.onRefresh,
    this.onItemLoaded,
    this.hasReachedEnd = false,
    Key? key,
  }) : super(key: key);

  final List<Movie> movies;
  final Future<void> Function() onRefresh;
  final void Function(int)? onItemLoaded;
  final bool hasReachedEnd;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final settings = watch(settingsProvider);

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Center(
        child: CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2 / 3),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  // TODO replace this with a shared scrollController listener
                  // OR a useScrollController hooks implementation
                  if (onItemLoaded != null) {
                    onItemLoaded!(index);
                  }

                  final Movie movie = movies[index];

                  return MovieCard(movie: movie, isRatingVisible: settings.isRatingsForPreviewsEnabled);
                },
                childCount: movies.length,
              ),
            ),
            if (hasReachedEnd)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 16),
                  child: Center(child: Text('That\'s all folks!')),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
