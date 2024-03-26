import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:movie_apps/presentation/pages/movies_list.dart';

class MovieTrending extends StatelessWidget {
  const MovieTrending({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingMoviesBloc, TrendingMoviesState>(
      builder: (context, state) {
        return switch (state) {
          TrendingMoviesInitial() => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          TrendingMoviesLoading() => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          TrendingMoviesLoaded() =>
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12, top: 12),
                      child: Text(
                          'Lagi Trending',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                    ),
                    MoviesList(movies: state.movies),
                  ],
                ),
              ),
          TrendingMoviesError() => Center(
            child: Text(
              'the message error is ${state.msg} \n and the error code is ${state.code}',
            ),
          ),
        };
      },
    );
  }
}
