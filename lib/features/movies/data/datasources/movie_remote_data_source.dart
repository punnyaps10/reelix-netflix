import 'package:dio/dio.dart';
import 'package:netfilx/core/constants/api_constants.dart';
import 'package:netfilx/core/network/dio_client.dart';

class MovieRemoteDataSource {
  final DioClient dioClient;

  MovieRemoteDataSource(this.dioClient);

  Future<Response> getPopularMovies() async {
    final response = await dioClient.dio.get(ApiConstants.popularMovies);
    return response;
  }

  Future<Response> getNowPlayingMovies() async {
    final response = await dioClient.dio.get(ApiConstants.nowPlaying);
    return response;
  }

  Future<Response> getUpcomingMovies() async {
    final response = await dioClient.dio.get(ApiConstants.upcoming);
    return response;
  }

  Future<Response> searchMovies(String query) async {
    final response = await dioClient.dio.get(
      ApiConstants.searchMovies,
      queryParameters: {'query': query},
    );
    return response;
  }
Future<Response> getMovieDetails(int movieId) async {
  final response = await dioClient.dio.get(
    ApiConstants.movieDetails(movieId),
  );

  return response;
}

}
