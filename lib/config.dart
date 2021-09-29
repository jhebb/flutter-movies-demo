class Config {
  static const BASE_URL = String.fromEnvironment('BASE_URL', defaultValue: 'https://api.themoviedb.org/3/');

  static const IMAGE_BASE_URL =
      String.fromEnvironment('IMAGE_BASE_URL', defaultValue: 'https://image.tmdb.org/t/p/w185');

  static const API_KEY = String.fromEnvironment('API_KEY', defaultValue: 'daf6fa0753d2304c156a21ac5b83c1c6');
}
