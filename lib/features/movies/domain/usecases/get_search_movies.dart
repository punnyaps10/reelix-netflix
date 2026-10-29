import 'package:netfilx/features/movies/domain/entities/movie.dart';
import 'package:netfilx/features/movies/domain/repositories/movie_repository.dart';

class GetSearchMovies {
  final MovieRepository repository;
  GetSearchMovies(this.repository);
  Future<List<Movie>> call(String query) {
    return repository.searchMovies(query);
  }
}
