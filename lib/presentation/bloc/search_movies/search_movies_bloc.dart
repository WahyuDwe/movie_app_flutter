import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/domain/entities/movie.dart';
import 'package:movie_apps/domain/usecases/search_movie.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies searchMovies;

  SearchMoviesBloc({required this.searchMovies})
      : super(SearchMoviesInitial()) {
    on<FetchSearchMovies>((event, emit) async {
      emit(SearchMoviesLoading());
      final failureOrMovies = await searchMovies(event.query);
      log('Searchmovies query: ${event.query}');

      failureOrMovies.fold(
        (failure) => emit(SearchMoviesError(failure.message)),
        (movies) => emit(SearchMoviesLoaded(movies)),
      );
    });

    on<InitSearchMovies>((event, emit) async {
      emit(SearchMoviesInitial());
    });
  }

  @override
  void onChange(Change<SearchMoviesState> change) {
    log('SearchMoviesBloc: $change');
    super.onChange(change);
  }
}
