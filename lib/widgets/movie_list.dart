import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config.dart';
import '../models/movie.dart';
import '../pages/movie_details.dart';
import '../providers/movie.dart';
import '../providers/movies.dart';

class MovieList extends ConsumerWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final moviesAsyncValue = watch(moviesProvider);

    return moviesAsyncValue.maybeWhen(
      error: (error, _) => Text('Dang: ${error.toString()}'),
      orElse: () => const Center(
        child: CircularProgressIndicator(),
      ),
      data: (movies) => Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2 / 3),
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            final Movie movie = movies[index];

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
                              image: NetworkImage('${Config.IMAGE_BASE_URL}${movie.posterPath}'),
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
  }
}
