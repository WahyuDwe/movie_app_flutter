part of 'trending_movies_bloc.dart';

sealed class TrendingMoviesState extends Equatable {
  const TrendingMoviesState();

  @override
  List<Object> get props => [];
}

final class TrendingMoviesInitial extends TrendingMoviesState {}

final class TrendingMoviesLoading extends TrendingMoviesState {}

final class TrendingMoviesLoaded extends TrendingMoviesState {
  final List<Movie> movies;

  const TrendingMoviesLoaded(this.movies);
}

final class TrendingMoviesError extends TrendingMoviesState {
  final String? msg;
  final int? code;

  const TrendingMoviesError(this.msg, this.code);
}
