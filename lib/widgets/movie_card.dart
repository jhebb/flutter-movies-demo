import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/movie.dart';
import '../pages/movie_details.dart';
import '../providers/movie.dart';
import 'movie_rating.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({required this.movie, this.isRatingVisible = true, Key? key}) : super(key: key);

  final Movie movie;
  final bool isRatingVisible;

  @override
  Widget build(BuildContext context) {
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
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(movie.posterPathUrl),
                  ),
                ),
              ),
              if (isRatingVisible)
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: MovieRating(movie.voteAverageRounded, extended: false),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
