import 'package:flutter/material.dart';

import '../widgets/movie_list.dart';
import '../widgets/movie_tags.dart';
import '../widgets/movies_title.dart';
import '../widgets/search_bar.dart';
import 'settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MoviesTitle(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const SettingsPage()));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
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
