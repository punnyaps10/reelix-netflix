
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netfilx/features/movies/data/datasources/download_local_data_source.dart';
import 'package:netfilx/features/movies/data/repositories/download_repository_implementation.dart';
import 'package:netfilx/features/movies/domain/repositories/download_repository.dart';
import 'package:netfilx/features/movies/domain/usecases/add_download.dart';
import 'package:netfilx/features/movies/domain/usecases/get_downloads.dart';
import 'package:netfilx/features/movies/domain/usecases/remove_download.dart';
import 'package:netfilx/features/movies/domain/entities/download_movie.dart';

final downloadLocalDataSourceProvider =
    Provider<DownloadLocalDataSource>((ref) {
  return DownloadLocalDataSource();
});

final downloadRepositoryProvider = Provider<DownloadRepository>((ref) {
  final localDataSource = ref.read(downloadLocalDataSourceProvider);

  return DownloadRepositoryImplementation(localDataSource);
});

final getDownloadsProvider = Provider<GetDownloads>((ref) {
  final repository = ref.read(downloadRepositoryProvider);

  return GetDownloads(repository);
});

final addDownloadProvider = Provider<AddDownload>((ref) {
  final repository = ref.read(downloadRepositoryProvider);

  return AddDownload(repository);
});

final removeDownloadProvider = Provider<RemoveDownload>((ref) {
  final repository = ref.read(downloadRepositoryProvider);

  return RemoveDownload(repository);
});


final downloadsProvider =
    FutureProvider<List<DownloadMovie>>((ref) async {
  final getDownloads = ref.read(getDownloadsProvider);

  return getDownloads();
});
