import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_apps/core/errors/server_exception.dart';
import 'package:movie_apps/core/errors/server_failure.dart';
import 'package:movie_apps/data/datasources/movie_remote_data_source.dart';
import 'package:movie_apps/data/models/movie_model.dart';
import 'package:movie_apps/data/repositories/movie_repositoriy_impl.dart';
import 'package:movie_apps/domain/entities/movie.dart';

import 'movie_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRemoteDataSource>()])
void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;

  setUp(() {
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    repository =
        MovieRepositoryImpl(remoteDataSource: mockMovieRemoteDataSource);
  });

  const tQuery = 'Interstellar';

  final tMovieModelList = [
    MovieModel(
      id: 1,
      title: 'Test Movie 1',
      overview: 'Desc 1',
      posterPath: '/image1',
    ),
    MovieModel(
      id: 2,
      title: 'Test Movie 2',
      overview: 'Desc 2',
      posterPath: '/image2',
    )
  ];

  test('should get trending movies from the remote data source', () async {
    when(mockMovieRemoteDataSource.getTrendingMovies())
        .thenAnswer((_) async => tMovieModelList);

    final result = await repository.getTrendingMovie();

    verify(mockMovieRemoteDataSource.getTrendingMovies());
    expect(result, isA<Right<Failure, List<Movie>>>());
  });

  test('should get popular movies from the remote data source', () async {
    when(mockMovieRemoteDataSource.getPopularMovies())
        .thenAnswer((_) async => tMovieModelList);

    final result = await repository.getPopularMovies();

    verify(mockMovieRemoteDataSource.getPopularMovies());
    expect(result, isA<Right<Failure, List<Movie>>>());
  });

  test('should get searches movies from the remote data source', () async {
    when(mockMovieRemoteDataSource.searchMovies(tQuery))
        .thenAnswer((_) async => tMovieModelList);

    final result = await repository.searchMovies(tQuery);

    verify(mockMovieRemoteDataSource.searchMovies(tQuery));
    expect(result, isA<Right<Failure, List<Movie>>>());
  });

  test(
      'should return ServerFailure when the call trending movie to remote data source is unsuccessfully',
      () async {
    when(mockMovieRemoteDataSource.getTrendingMovies())
        .thenThrow(ServerException(msg: '', code: null));

    final result = await repository.getTrendingMovie();

    expect(result, isA<Left<ServerFailure, List<Movie>>>());
  });

  test(
      'should return ServerFailure when the call search movie to remote data source is unsuccessfully',
      () async {
    when(mockMovieRemoteDataSource.searchMovies(tQuery))
        .thenThrow(ServerException(msg: '', code: null));

    final result = await repository.searchMovies(tQuery);

    expect(result, isA<Left<ServerFailure, List<Movie>>>());
  });

  test(
      'should return ServerFailure when the call to remote data source is unsuccessfully',
      () async {
    when(mockMovieRemoteDataSource.getPopularMovies())
        .thenThrow(ServerException(msg: '', code: null));

    final result = await repository.getPopularMovies();

    expect(result, isA<Left<ServerFailure, List<Movie>>>());
  });
}
