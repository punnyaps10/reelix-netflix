
import 'package:netfilx/features/movies/domain/entities/download_movie.dart';

abstract class DownloadRepository {
  Future<List<DownloadMovie>> getDownloads();

  Future<void> addDownload(DownloadMovie movie);

  Future<void> removeDownload(int movieId);
}

