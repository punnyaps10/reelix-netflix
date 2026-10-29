import 'package:netfilx/features/movies/domain/repositories/movie_repository.dart';
import 'package:netfilx/features/movies/domain/entities/movie.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;
  GetNowPlayingMovies(this.repository);
  
  Future<List<Movie>> call() async {
    return repository.getNowPlayingMovies();
  }
}
