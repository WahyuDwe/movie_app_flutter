import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/core/errors/server_failure.dart';
import 'package:movie_apps/domain/entities/movie.dart';
import 'package:movie_apps/domain/usecases/get_trending_movies.dart';

part 'trending_movies_event.dart';
part 'trending_movies_state.dart';

class TrendingMoviesBloc
    extends Bloc<TrendingMoviesEvent, TrendingMoviesState> {
  final GetTrendingMovies getTrendingMovies;

  TrendingMoviesBloc({required this.getTrendingMovies})
      : super(TrendingMoviesInitial()) {
    on<FetchTrendingMovies>((event, emit) async {
      emit(TrendingMoviesLoading());
      final failureOrMovies = await getTrendingMovies();
      failureOrMovies.fold(
            (failure) {
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
