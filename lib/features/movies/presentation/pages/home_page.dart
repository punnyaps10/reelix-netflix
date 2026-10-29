import 'package:flutter/material.dart';
import 'package:netfilx/core/theme/app_colors.dart';
import 'package:netfilx/features/movies/presentation/widgets/now_playing_widget.dart';
import 'package:netfilx/features/movies/presentation/widgets/popular_movies_widget.dart';
import 'package:netfilx/features/movies/presentation/widgets/upcoming_movies.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,

        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.black,

          title: Image.asset(
            'assets/Netflix-Logo.png',
            height: 80,
          ),

          bottom: const TabBar(
            indicatorColor: AppColors.netflixRed,
             dividerColor: Colors.transparent,
            labelColor: AppColors.netflixRed,
             
            tabs: [
              
              Tab(text: 'Home'),
              Tab(text: 'TV Shows'),
              Tab(text: 'Movies'),
            ],
          ),
        ),

        body: Container(
            padding: const EdgeInsets.only(top: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                PopularMoviesWidget(),

                const SizedBox(height: 30),

                NowPlayingWidget(),
                const SizedBox(height: 30),

                UpcomingMovies(),
            
                  
              ],
            ),
          ),
          


        ),


      ),
    );
  }
}