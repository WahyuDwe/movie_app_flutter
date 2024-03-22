part of 'search_movies_bloc.dart';

sealed class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();

  @override
  List<Object> get props => [];
}

final class FetchSearchMovies extends SearchMoviesEvent {
  const FetchSearchMovies({required this.query});

  final String query;

  @override
  List<Object> get props => [query];

  @override
  String toString() => 'FetchSearchMovies { query: $query }';
}

final class InitSearchMovies extends SearchMoviesEvent {}
