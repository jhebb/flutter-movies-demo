import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../colors.dart';
import '../enums/movie_type.dart';
import '../providers/movie_type.dart';

class MovieTags extends ConsumerWidget {
  const MovieTags({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final MovieType movieType = watch(movieTypeProvider).state;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: MovieType.values
          .map(
            (type) => InkWell(
              onTap: () => context.read(movieTypeProvider).state = type,
              child: Chip(
                label: Text(type.name),
                backgroundColor: type == movieType ? AppColors.buttonPrimary : null,
              ),
            ),
          )
          .toList(),
    );
  }
}
