import 'package:netfilx/features/movies/domain/entities/movie.dart';
import 'package:netfilx/features/movies/domain/repositories/movie_repository.dart';

class GetMovieDetails {
  final MovieRepository repository;
  GetMovieDetails(this.repository);
  Future<Movie> call(int movieId) {
    return repository.getMovieDetails(movieId);
  }
}
