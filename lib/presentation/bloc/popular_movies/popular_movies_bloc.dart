import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/core/errors/server_failure.dart';
import 'package:movie_apps/domain/entities/movie.dart';
import 'package:movie_apps/domain/usecases/movie_usecase.dart';

part 'popular_movies_event.dart';

part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final MovieUseCase movieUseCase;

  PopularMoviesBloc({required this.movieUseCase}) : super(PopularMoviesInitial()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularMoviesLoading());
      final failureOrMovies = await movieUseCase.getPopularMovies();
      failureOrMovies.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(PopularMoviesError(failure.message, failure.code));
          } else {
            emit(const PopularMoviesError('Server Failure', null));
          }
        },
        (movies) => emit(PopularMoviesLoaded(movies)),
      );
    });
  }
}
