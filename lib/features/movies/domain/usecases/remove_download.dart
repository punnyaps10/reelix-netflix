
import 'package:netfilx/features/movies/domain/repositories/download_repository.dart';

class RemoveDownload {
  final DownloadRepository repository;

  RemoveDownload(this.repository);

  Future<void> call(int movieId) {
    return repository.removeDownload(movieId);
  }
}
