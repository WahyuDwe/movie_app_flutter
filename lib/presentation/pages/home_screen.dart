import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie_apps/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:movie_apps/presentation/pages/movies_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final bckImage =
      'https://w0.peakpx.com/wallpaper/732/875/HD-wallpaper-anonymous-black-cool-dark-guy-foux-hacker-scary-tech.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi Fabrice 👋',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'TDD - Movie App',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(20),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Trending Movies',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              BlocBuilder<TrendingMoviesBloc, TrendingMoviesState>(
                builder: (context, state) {
                  if (state is TrendingMoviesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is TrendingMoviesLoaded) {
                    return MoviesList(movies: state.movies);
                  }

                  if (state is TrendingMoviesError) {
                    return Center(
                      child: Text(
                        state.msg,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return Container();
                },
              ),

              const SizedBox(height: 20),
              // Popular Movies
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Popular Movies',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                builder: (context, state) {
                  if (state is PopularMoviesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PopularMoviesLoaded) {
                    return MoviesList(movies: state.movies);
                  } else if (state is PopularMoviesError) {
                    return Text(state.message);
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
