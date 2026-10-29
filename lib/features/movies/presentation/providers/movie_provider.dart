import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netfilx/core/network/dio_client.dart';
import 'package:netfilx/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:netfilx/features/movies/domain/repositories/movie_repository.dart';
import 'package:netfilx/features/movies/data/repositories/movie_repository_implementation.dart';
import 'package:netfilx/features/movies/domain/entities/movie.dart';
import 'package:netfilx/features/movies/domain/usecases/get_movie_details.dart';
import 'package:netfilx/features/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:netfilx/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:netfilx/features/movies/domain/usecases/get_search_movies.dart';
import 'package:netfilx/features/movies/domain/usecases/get_upcoming_movies.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

final movieRemoteDataSourceProvider = Provider<MovieRemoteDataSource>((ref) {
  final dioClient = ref.read(dioClientProvider);

  return MovieRemoteDataSource(dioClient);
});

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final remoteDataSource = ref.read(movieRemoteDataSourceProvider);

  return MovieRepositoryImplementation(remoteDataSource);
});

final getPopularMoviesProvider = Provider<GetPopularMovies>((ref) {
  final repository = ref.read(movieRepositoryProvider);

  return GetPopularMovies(repository);
});

final popularMoviesProvider = FutureProvider((ref) async {
  final getPopularMovies = ref.read(getPopularMoviesProvider);
  return getPopularMovies();
});

final getNowPlayingMoviesProvider = Provider<GetNowPlayingMovies>((ref) {
  final repository = ref.read(movieRepositoryProvider);

  return GetNowPlayingMovies(repository);
});
final nowPlayingMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final getNowPlayingMovies = ref.read(getNowPlayingMoviesProvider);

  return getNowPlayingMovies();
});

final getUpcomingMoviesProvider = Provider<GetUpcomingMovies>((ref) {
  final repository = ref.read(movieRepositoryProvider);

  return GetUpcomingMovies(repository);
});
final upcomingMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final getUpcomingMovies = ref.read(getUpcomingMoviesProvider);

  return getUpcomingMovies();
});

final getSearchMoviesProvider = Provider<GetSearchMovies>((ref) {
  final repository = ref.read(movieRepositoryProvider);
  return GetSearchMovies(repository);
});

final searchMoviesProvider = FutureProvider.family<List<Movie>, String>((
  ref,
  query,
) async {
  final getSearchMovies = ref.read(getSearchMoviesProvider);

  return getSearchMovies(query);
});

final getMovieDetailsProvider = Provider<GetMovieDetails>((ref) {
  final repository = ref.read(movieRepositoryProvider);

  return GetMovieDetails(repository);
});
final movieDetailsProvider = FutureProvider.family<Movie, int>((
  ref,
  movieId,
) async {
  final getMovieDetails = ref.read(getMovieDetailsProvider);
  return getMovieDetails(movieId);
});
