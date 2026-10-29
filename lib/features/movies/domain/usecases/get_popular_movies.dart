import 'package:netfilx/features/movies/domain/repositories/movie_repository.dart';
import 'package:netfilx/features/movies/domain/entities/movie.dart';

class GetPopularMovies {
  final MovieRepository repository;
  GetPopularMovies(this.repository);

  Future<List<Movie>> call() {
    return repository.getPopularMovies();
  }
}
