import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netfilx/core/theme/app_colors.dart';
import 'package:netfilx/features/movies/presentation/providers/download_provider.dart';

class DownloadPage extends ConsumerWidget {
  const DownloadPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloads = ref.watch(downloadsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Downloads',style: TextStyle(fontWeight: .bold),),
        backgroundColor: AppColors.background,
      ),
      body: downloads.when(
        data: (movies) {
          if (movies.isEmpty) {
            return const Center(
              child: Text(
                'No downloads yet',
                style: TextStyle(color: Colors.white,fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];

              return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: movie.posterPath != null
                      ? NetworkImage(
                          'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                        )
                      : null,
                  child: movie.posterPath == null
                      ? const Icon(Icons.movie)
                      : null,
                ),
                title: Text(
                  movie.title,
                  style: const TextStyle(color: Colors.white),
                ),

                trailing: IconButton(
                  onPressed: () async {
                    await ref.read(removeDownloadProvider)(movie.id);
                    ref.invalidate(downloadsProvider);
                  },
                  icon: Icon(Icons.delete, color: AppColors.netflixRed),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'Error: $error',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
