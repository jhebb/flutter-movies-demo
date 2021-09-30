import 'package:flutter/material.dart';

import '../widgets/movie_list.dart';
import '../widgets/movie_tags.dart';
import '../widgets/movies_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MoviesTitle(),
      ),
      body: Column(
        children: const <Widget>[
          MovieTags(),
          Expanded(child: MovieList()),
        ],
      ),
    );
  }
}
