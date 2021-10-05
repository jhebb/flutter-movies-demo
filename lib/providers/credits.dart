import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cast.dart';
import '../services/movies.dart';

final castProvider = FutureProvider.autoDispose.family<List<Cast>, num>((ref, id) async {
  final movieService = ref.read(moviesServiceProvider);

  print('making castProvider $id');

  try {
    final response = await movieService.getCredits(id);

    return response.cast;
  } catch (e) {
    print('error getting cast: ${e.toString()}');

    return <Cast>[];
  }
});
