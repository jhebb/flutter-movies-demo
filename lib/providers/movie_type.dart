import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/enums/movie_type.dart';

final movieTypeProvider = StateProvider<MovieType>((ref) => MovieType.popular);
