import 'package:netfilx/features/movies/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getPopularMovies();

  Future<List<Movie>> getNowPlayingMovies();

  Future<List<Movie>> getUpcomingMovies();

  Future<List<Movie>> searchMovies(String query);

  Future<Movie> getMovieDetails(int movieId);
}
