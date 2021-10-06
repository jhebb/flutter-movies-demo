import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/recommendations.dart';
import 'movies_grid.dart';

class RecommendationsList extends ConsumerWidget {
  const RecommendationsList({this.id = 0, Key? key}) : super(key: key);

  final num id;

  @override
  Widget build(BuildContext context, watch) {
    final recommendationsController = watch(recommendationsProviderWithPaging(id).notifier);
    final movies = watch(recommendationsProviderWithPaging(id));

    if (movies.error != '') {
      return const Text('oops, error');
    }

    if (movies.results.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return MoviesGrid(
      movies: movies.results,
      hasReachedEnd: recommendationsController.hasReachedEnd,
      onRefresh: recommendationsController.getRecommendations,
      onItemLoaded: recommendationsController.handleScrollWithIndex,
    );
  }
}
