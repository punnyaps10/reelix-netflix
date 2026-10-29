import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:netfilx/core/theme/app_colors.dart';
import 'package:netfilx/features/movies/domain/entities/movie.dart';
import 'package:netfilx/features/movies/presentation/providers/movie_provider.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  String searchQuery = '';

  Timer? _debounce;

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchResult = searchQuery.isEmpty
        ? const AsyncValue.data(<Movie>[])
        : ref.watch(searchMoviesProvider(searchQuery));

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Search TextField
            TextField(
              controller: searchController,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Search movies and TV shows',
                hintStyle: const TextStyle(
                  color: AppColors.grey,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.grey,
                ),
                filled: true,
                fillColor: AppColors.chipBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
              ),

              onChanged: (value) {
                if (_debounce?.isActive ?? false) {
                  _debounce!.cancel();
                }

                _debounce = Timer(
                  const Duration(milliseconds: 500),
                  () {
                    setState(() {
                      searchQuery = value.trim();
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 24),

            // Heading
            const Text(
              'Movies & TV Shows',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // Search Results
            Expanded(
              child: searchResult.when(
                data: (movies) {

                  // No results
                  if (movies.isEmpty) {

                    // Search field is empty
                    if (searchQuery.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              color: AppColors.grey,
                              size: 60,
                            ),

                            SizedBox(height: 16),

                            Text(
                              'Search for movies and TV shows',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // Search completed but no movie found
                    return const Center(
                      child: Text(
                        'No movies found',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }

                  // Movies found
                  return GridView.builder(
                    itemCount: movies.length,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.67,
                    ),

                    itemBuilder: (context, index) {
                      final movie = movies[index];

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(6),

                        child: movie.posterPath != null
                            ? Image.network(
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                fit: BoxFit.cover,
                              )
                            : Container(
                                color: AppColors.grey,
                                child: const Center(
                                  child: Icon(
                                    Icons.movie,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                              ),
                      );
                    },
                  );
                },

                // Loading
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },

                // Error
                error: (error, stackTrace) {
                  return Center(
                    child: Text(
                      error.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}