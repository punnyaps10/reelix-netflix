
import 'package:netfilx/features/movies/domain/repositories/download_repository.dart';
import 'package:netfilx/features/movies/domain/entities/download_movie.dart';

class GetDownloads {
  final DownloadRepository repository;

  GetDownloads(this.repository);

  Future<List<DownloadMovie>> call() {
    return repository.getDownloads();
  }
}
