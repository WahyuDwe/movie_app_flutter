import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_apps/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movie_apps/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:movie_apps/presentation/pages/movies_list.dart';
import 'package:movie_apps/presentation/widgets/search_bar_movie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final bckImage =
      'https://w0.peakpx.com/wallpaper/732/875/HD-wallpaper-anonymous-black-cool-dark-guy-foux-hacker-scary-tech.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const SearchBarMovie(),
      ),
      body: _searchBlocBuilder(),
    );
  }

  _buildTrending() {
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

  BlocBuilder<SearchMoviesBloc, SearchMoviesState> _searchBlocBuilder() {
    return BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
      builder: (context, state) {
        return switch (state) {
          SearchMoviesInitial() => _buildTrending(),
          SearchMoviesLoading() =>
            const Center(child: CircularProgressIndicator.adaptive()),
          SearchMoviesLoaded() => state.movies.isEmpty
              ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Yahhh, filem yang kamu cari tidak ditemukan 😓😓😓',
                    ),
                  ),
                ],
              )
              : MoviesList(movies: state.movies),
          SearchMoviesError() => Center(
              child: Text(state.msg ?? ''),
            ),
        };
      },
    );
  }
}
