
import 'package:netfilx/features/movies/data/datasources/download_local_data_source.dart';
import 'package:netfilx/features/movies/domain/repositories/download_repository.dart';
import 'package:netfilx/features/movies/domain/entities/download_movie.dart';

class DownloadRepositoryImplementation implements DownloadRepository {
  final DownloadLocalDataSource localDataSource;

  DownloadRepositoryImplementation(this.localDataSource);

  @override
  Future<List<DownloadMovie>> getDownloads() {
    return localDataSource.getDownloads();
  }

  @override
  Future<void> addDownload(DownloadMovie movie) {
    return localDataSource.addDownload(movie);
  }

  @override
  Future<void> removeDownload(int movieId) {
    return localDataSource.removeDownload(movieId);
  }
}

