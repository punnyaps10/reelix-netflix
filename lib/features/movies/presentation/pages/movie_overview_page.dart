import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netfilx/core/theme/app_colors.dart';
import 'package:netfilx/features/movies/domain/entities/download_movie.dart';
import 'package:netfilx/features/movies/domain/entities/movie.dart';
import 'package:netfilx/features/movies/presentation/pages/download_page.dart';
import 'package:netfilx/features/movies/presentation/providers/download_provider.dart';
import 'package:netfilx/features/movies/presentation/providers/movie_provider.dart';

class MovieOverviewPage extends ConsumerWidget {
  final Movie movie;
  const MovieOverviewPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetails = ref.watch(movieDetailsProvider(movie.id));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: Text(movie.title),
      ),

      body: movieDetails.when(
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },

        error: (error, stackTrace) {
          return Center(
            child: Text(
              error.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          );
        },

        data: (movieDetails) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    if (movieDetails.backdropPath != null)
                      Image.network(
                        'https://image.tmdb.org/t/p/w780${movieDetails.backdropPath}',
                        width: double.infinity,
                        height: 280,
                        fit: BoxFit.cover,
                      ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movieDetails.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: .bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 5),
                          Text(
                            movieDetails.voteAverage.toStringAsFixed(1),
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(width: 20),

                          Text(
                            movieDetails.releaseDate,
                            style: const TextStyle(
                              color: AppColors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Overview',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        movieDetails.overview,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.netflixRed,
                          ),
                         
onPressed: () async {
  final downloadMovie = DownloadMovie(
    id: movieDetails.id,
    title: movieDetails.title,
    posterPath: movieDetails.posterPath,
  );

  await ref.read(addDownloadProvider)(downloadMovie);

  if (!context.mounted) return;

  ref.invalidate(downloadsProvider);

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Added to Downloads'),
    ),
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DownloadPage(),
    ),
  );
},

                          child: const Text(
                            'Download',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
