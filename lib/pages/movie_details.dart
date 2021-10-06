import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/movie.dart';
import '../widgets/cast_list.dart';
import '../widgets/movie_rating.dart';
import '../widgets/recommendations_list.dart';

class MovieDetailsPage extends ConsumerWidget {
  const MovieDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final movie = watch(movieProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
          elevation: 0,
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.description)),
            Tab(icon: Icon(Icons.people)),
            Tab(icon: Icon(Icons.lightbulb)),
          ],
        ),
        body: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(movie.backdropPathUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 150,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(movie.posterPathUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(movie.title, style: Theme.of(context).textTheme.headline6),
                              const SizedBox(height: 20),
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(movie.releaseDate),
                                  ),
                                  const SizedBox(width: 50),
                                  MovieRating(movie.voteAverageRounded),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _MovieDetailTab(
                            title: 'Overview',
                            child: Text(movie.overview),
                          ),
                          _MovieDetailTab(
                            title: 'Cast',
                            child: CastList(id: movie.id),
                          ),
                          _MovieDetailTab(
                            title: 'Similar Movies',
                            child: RecommendationsList(id: movie.id),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MovieDetailTab extends StatelessWidget {
  const _MovieDetailTab({required this.child, this.title, Key? key}) : super(key: key);

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Column(
            children: [
              Text(title!, style: Theme.of(context).textTheme.headline6),
              const SizedBox(height: 8),
            ],
          ),
        Expanded(child: child),
      ],
    );
  }
}
