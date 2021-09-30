import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config.dart';
import '../providers/movie.dart';

class MovieDetailsPage extends ConsumerWidget {
  const MovieDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    // TODO: instead of tutorial method, try adding new provider
    // OR, follow Andreas method of scoping by passing in id - this may be avoidable with a global key
    final movie = watch(movieProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('${Config.IMAGE_BASE_URL}${movie.backdropPath}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 120,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('${Config.IMAGE_BASE_URL}${movie.posterPath}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          Text(movie.title, style: Theme.of(context).textTheme.headline6),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(movie.releaseDate),
                              const SizedBox(width: 50),
                              const Icon(Icons.star, size: 18),
                              Text('${movie.voteAverage / 10}'),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  left: 20,
                  bottom: -80,
                )
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            const Divider(
              thickness: 1.5,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(movie.overview),
          ],
        ),
      ),
    );
  }
}
