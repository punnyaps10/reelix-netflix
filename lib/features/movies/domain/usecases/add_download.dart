
import 'package:netfilx/features/movies/domain/repositories/download_repository.dart';
import 'package:netfilx/features/movies/domain/entities/download_movie.dart';

class AddDownload {
  final DownloadRepository repository;

  AddDownload(this.repository);

  Future<void> call(DownloadMovie movie) {
    return repository.addDownload(movie);
  }
}
