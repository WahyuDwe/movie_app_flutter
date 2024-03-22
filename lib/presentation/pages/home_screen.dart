import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filemku',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            SearchBarMovie(),
          ],
        ),
        toolbarHeight: 100,
      ),
      body: _searchBlocBuilder(),
    );
  }

  SingleChildScrollView _buildTrending() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<TrendingMoviesBloc, TrendingMoviesState>(
            builder: (context, state) {
              return switch (state) {
                TrendingMoviesInitial() => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                TrendingMoviesLoading() => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                TrendingMoviesLoaded() => MoviesList(movies: state.movies),
                TrendingMoviesError() => Center(
                    child: Text(state.msg),
                  ),
              };
            },
          ),
        ],
      ),
    );
  }

  BlocBuilder<SearchMoviesBloc, SearchMoviesState> _searchBlocBuilder() {
    return BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
      builder: (context, state) {
        return switch (state) {
          SearchMoviesInitial() => _buildTrending(),
          SearchMoviesLoading() => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          SearchMoviesLoaded() => state.movies.isEmpty
              ? const Center(
                  child: Text('Yahhh, filem yang kamu cari tidak ditemukan'),
                )
              : MoviesList(movies: state.movies),
          SearchMoviesError() => Center(
              child: Text(state.msg),
            ),
        };
      },
    );
  }
}
