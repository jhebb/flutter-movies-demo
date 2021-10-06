import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/watch_response.dart';
import '../services/movies.dart';

final watchProvider = FutureProvider.autoDispose.family<WatchResponse, num>((ref, id) async {
  final movieService = ref.read(moviesServiceProvider);

  try {
    return movieService.getWatchOptions(id);
  } catch (e) {
    print('error getting watch info: ${e.toString()}');

    return WatchResponse();
  }
});
