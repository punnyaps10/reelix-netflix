import 'package:netfilx/features/movies/domain/repositories/movie_repository.dart';
import 'package:netfilx/features/movies/domain/entities/movie.dart';

class GetUpcomingMovies {
  final MovieRepository repository;
  GetUpcomingMovies(this.repository);

  Future<List<Movie>> call() {
    return repository.getUpcomingMovies();
  }
}
