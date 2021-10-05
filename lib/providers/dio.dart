import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config.dart';

final dioProvider = Provider<Dio>((ref) {
  final Dio dio = Dio(BaseOptions(baseUrl: Config.BASE_URL));

  // dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, _) {
  //   options.headers.addAll({'Authorization': 'Bearer ${Config.API_TOKEN}'});
  // }));

  return dio;
});
