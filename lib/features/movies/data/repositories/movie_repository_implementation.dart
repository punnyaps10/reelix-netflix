import 'package:netfilx/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:netfilx/features/movies/data/models/movie_model.dart';
import 'package:netfilx/features/movies/domain/entities/movie.dart';
import 'package:netfilx/features/movies/domain/repositories/movie_repository.dart';

class MovieRepositoryImplementation implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImplementation(this.remoteDataSource);

  @override
  Future<List<Movie>> getPopularMovies() async {
    final response = await remoteDataSource.getPopularMovies();

    final List results = response.data['results'];

    return results.map((json) => MovieModel.fromJson(json).toEntity()).toList();
  }

  @override
  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await remoteDataSource.getNowPlayingMovies();

    final List results = response.data['results'];

    return results.map((json) => MovieModel.fromJson(json).toEntity()).toList();
  }

  @override
  Future<List<Movie>> getUpcomingMovies() async {
    final response = await remoteDataSource.getUpcomingMovies();

    final List results = response.data['results'];

    return results.map((json) => MovieModel.fromJson(json).toEntity()).toList();
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    final response = await remoteDataSource.searchMovies(query);

    final List results = response.data['results'];

    return results.map((json) => MovieModel.fromJson(json).toEntity()).toList();
  }

  @override
  Future<Movie> getMovieDetails(int movieId) async {
    final response = await remoteDataSource.getMovieDetails(movieId);
    return MovieModel.fromJson(response.data).toEntity();
  }
}
