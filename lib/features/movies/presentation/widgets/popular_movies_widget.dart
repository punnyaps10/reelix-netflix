import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netfilx/core/theme/app_colors.dart';
import 'package:netfilx/features/movies/presentation/pages/movie_overview_page.dart';
import 'package:netfilx/features/movies/presentation/providers/movie_provider.dart';
import 'package:netfilx/features/movies/presentation/widgets/shimmer.dart';

class PopularMoviesWidget extends ConsumerWidget {
  const PopularMoviesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(popularMoviesProvider);
    return data.when(
      data: (movielist) {
        return CarouselSlider(
          options: CarouselOptions(
            height: 390,
            autoPlayAnimationDuration: Duration(seconds: 2),
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.8,
          ),

          items: movielist.map((e) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieOverviewPage(movie: e),
                        ),
                      );
                    },
                    child: Image.network(
                      'https://image.tmdb.org/t/p/original${e.backdropPath}',
                      width: double.infinity,
                      height: 390,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 0, 0, 0.4),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),

                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            e.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),

                              const SizedBox(width: 5),
                              Text(
                                e.voteAverage.toStringAsFixed(1),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(width: 15),

                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.netflixRed,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Watch Now',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },

      error: (error, _) {
        return Center(child: Text(error.toString()));
      },
      loading: () => const MovieShimmer(),
    );
  }
}
