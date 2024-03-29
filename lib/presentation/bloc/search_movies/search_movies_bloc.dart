import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/core/errors/server_failure.dart';
import 'package:movie_apps/domain/entities/movie.dart';
import 'package:movie_apps/domain/usecases/movie_usecase.dart';

part 'search_movies_event.dart';

part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final MovieUseCase movieUseCase;

  SearchMoviesBloc({required this.movieUseCase})
      : super(SearchMoviesInitial()) {
    on<FetchSearchMovies>((event, emit) async {
      emit(SearchMoviesLoading());
      final failureOrMovies = await movieUseCase.searchMovies(event.query);
      log('Searchmovies query: ${event.query}');

      failureOrMovies.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(SearchMoviesError(failure.message, failure.code));
          } else {
            emit(const SearchMoviesError('Server Failure', null));
          }
        },
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
