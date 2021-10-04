import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/movie.dart';
import '../pages/movie_details.dart';
import '../providers/movie.dart';
import '../providers/movies.dart';

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

    return RefreshIndicator(
      onRefresh: () => moviesController.getMovies(),
      child: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2 / 3),
          itemCount: movies.results.length,
          itemBuilder: (BuildContext context, int index) {
            // TODO replace this with a shared scrollController listener
            // OR a useScrollController hooks implementation
            moviesController.handleScrollWithIndex(index);
            final Movie movie = movies.results[index];

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProviderScope(
                      overrides: [
                        movieProvider.overrideWithValue(movie),
                      ],
                      child: const MovieDetailsPage(),
                    ),
                  ),
                );
              },
              child: Card(
                child: Container(
                  margin: const EdgeInsets.all(4),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(movie.posterPathUrl),
                            ),
                          ),
                        ),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
    //   );
  }
}
