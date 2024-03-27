import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_apps/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movie_apps/presentation/pages/movies_list.dart';
import 'package:movie_apps/presentation/widgets/movie_trending.dart';
import 'package:movie_apps/presentation/widgets/search_bar_movie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final bckImage =
      'https://w0.peakpx.com/wallpaper/732/875/HD-wallpaper-anonymous-black-cool-dark-guy-foux-hacker-scary-tech.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: false,
        title: const SearchBarMovie(),
      ),
      body: _searchBlocBuilder(),
    );
  }

  BlocBuilder<SearchMoviesBloc, SearchMoviesState> _searchBlocBuilder() {
    return BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
      builder: (context, state) {
        return switch (state) {
          SearchMoviesInitial() => const MovieTrending(),
          SearchMoviesLoading() => const Center(child: CircularProgressIndicator.adaptive()),
          SearchMoviesLoaded() => state.movies.isEmpty
              ? Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/animations/empty_search.json',
                        width: 250,
                        height: 250,
                      ),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 24,
                            right: 24,
                          ),
                          child: Text(
                            'Yahhh, pilem yang kamu cari tidak ada 😓😓😓',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              )
              : MoviesList(movies: state.movies),
          SearchMoviesError() => Center(child: Text(state.msg ?? '')),
        };
      },
    );
  }
}
