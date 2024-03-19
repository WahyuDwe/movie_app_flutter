import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/core/di/inection_container.dart';
import 'package:movie_apps/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie_apps/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movie_apps/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:movie_apps/presentation/pages/home_screen.dart';

void main() {
  init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<PopularMoviesBloc>()),
          BlocProvider(create: (context) => getIt<TrendingMoviesBloc>()),
          BlocProvider(create: (context) => getIt<SearchMoviesBloc>())
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
