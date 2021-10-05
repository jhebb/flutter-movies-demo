class Config {
  static const BASE_URL = String.fromEnvironment('BASE_URL', defaultValue: 'https://api.themoviedb.org/3/');

  static const IMAGE_BASE_URL = String.fromEnvironment('IMAGE_BASE_URL', defaultValue: 'https://image.tmdb.org/t/p');

  static const API_KEY = String.fromEnvironment('API_KEY', defaultValue: 'daf6fa0753d2304c156a21ac5b83c1c6');

  static const API_TOKEN = String.fromEnvironment('API_TOKEN',
      defaultValue:
          'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYWY2ZmEwNzUzZDIzMDRjMTU2YTIxYWM1YjgzYzFjNiIsInN1YiI6IjYxNTQ3YTQzZmU2YzE4MDA0MjhlNGM5MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xeX0VvlCbDqavJ1J2DX_Y_Sktd_jq-blEPTt58jELvs');
}
