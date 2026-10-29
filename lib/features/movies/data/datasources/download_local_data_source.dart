import 'package:netfilx/features/movies/domain/entities/download_movie.dart';

class DownloadLocalDataSource {
  final List<DownloadMovie> _downloads = [];

  Future<List<DownloadMovie>> getDownloads() async {
    return _downloads;
  }

  Future<void> addDownload(DownloadMovie movie) async {
    final alreadyDownloaded = _downloads.any(
      (download) => download.id == movie.id,
    );
     if (!alreadyDownloaded) {
    _downloads.add(movie);
  }
}
  Future<void> removeDownload(int movieId) async {
    _downloads.removeWhere((movie) => movie.id == movieId);
  }
}
