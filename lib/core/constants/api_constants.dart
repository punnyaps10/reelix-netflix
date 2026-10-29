class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3/';
  static const String popularMovies = 'movie/popular';
  static const String nowPlaying = 'movie/now_playing';
  static const String upcoming = 'movie/upcoming';
  static const String searchMovies = 'search/movie';

  static String movieDetails(int movieId) => 'movie/$movieId';

  static const String accessToken = String.fromEnvironment('TMDB_ACCESS_TOKEN');
}
