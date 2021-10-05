import 'package:flutter/material.dart';

import '../widgets/movie_list.dart';
import '../widgets/movie_tags.dart';
import '../widgets/movies_title.dart';
import '../widgets/search_bar.dart';

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
          SearchBar(),
          MovieTags(),
          Expanded(child: MovieList()),
        ],
      ),
    );
  }
}
