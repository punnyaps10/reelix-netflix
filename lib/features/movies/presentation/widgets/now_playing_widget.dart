import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netfilx/core/theme/app_colors.dart';
import 'package:netfilx/features/movies/presentation/pages/movie_overview_page.dart';
import 'package:netfilx/features/movies/presentation/providers/movie_provider.dart';
import 'package:netfilx/features/movies/presentation/widgets/shimmer.dart';

class NowPlayingWidget extends ConsumerWidget {
  const NowPlayingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(nowPlayingMoviesProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Text(
            'Now Playing',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
        ),

        const SizedBox(height: 15),
        data.when(
          data: (movies) {
            return SizedBox(
              height: 200,

              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];

                  return Container(
                    width: 130,
                    margin: EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.grey,
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieOverviewPage(movie: movie),
                                ),
                              );
                            },
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              width: 130,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },

          error: (error, _) {
            return Center(child: Text(error.toString()));
          },
            loading: () => const MovieShimmer(),
        ),
      ],
    );
  }
}
