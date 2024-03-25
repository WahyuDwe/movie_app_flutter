import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/core/errors/server_failure.dart';
import 'package:movie_apps/domain/entities/movie.dart';
import 'package:movie_apps/domain/usecases/movie_usecase.dart';

part 'trending_movies_event.dart';
part 'trending_movies_state.dart';

class TrendingMoviesBloc
    extends Bloc<TrendingMoviesEvent, TrendingMoviesState> {
  final MovieUseCase movieUseCase;

  TrendingMoviesBloc({required this.movieUseCase})
      : super(TrendingMoviesInitial()) {
    on<FetchTrendingMovies>((event, emit) async {
      emit(TrendingMoviesLoading());
      final failureOrMovies = await movieUseCase.getTrendingMovie();
      failureOrMovies.fold((failure) {
          if (failure is ServerFailure) {
            emit(TrendingMoviesError(failure.message, failure.code));
          } else {
            emit(const TrendingMoviesError('Server Failure', null));
          }
        },
        (movies) => emit(TrendingMoviesLoaded(movies)),
      );
    });
  }
}
