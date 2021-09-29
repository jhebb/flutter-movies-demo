import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/movie_type.dart';
import '../providers/movie_type.dart';

class MoviesTitle extends ConsumerWidget {
  const MoviesTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final MovieType movieType = watch(movieTypeProvider).state;

    return Text(
      '${movieType.name} Movies',
    );
  }
}
