import 'cast.dart';

class CreditsResponse {
  CreditsResponse({this.cast = const []});

  final List<Cast> cast;

  CreditsResponse.initial() : cast = [];

  factory CreditsResponse.fromJson(Map<String, dynamic> json) {
    return CreditsResponse(
        cast: json['cast'] != null ? List<Cast>.from(json['cast'].map((item) => Cast.fromJson(item))) : <Cast>[]);
  }
}
