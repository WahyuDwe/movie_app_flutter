import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_apps/domain/entities/movie.dart';
import 'package:movie_apps/domain/repositories/movie_repository.dart';
import 'package:movie_apps/domain/usecases/get_trending_movies.dart';

import 'get_trending_movie_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])
void main() {
  late GetTrendingMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTrendingMovies(mockMovieRepository);
  });

  final tMoviesList = [
    const Movie(
        id: 1,
        title: 'Test Movie 1',
        overview: 'Desc 1',
        posterPath: '/image1'),
    const Movie(
      id: 2,
      title: 'Test Movie 2',
      overview: 'Desc 2',
      posterPath: '/image2',
    )
  ];

  test('should get trending movies from the repository', () async {
    // arrange
    when(mockMovieRepository.getTrendingMovie())
        .thenAnswer((_) async => Right(tMoviesList));

    // act
    final result = await usecase();

    // assert
    expect(result, Right(tMoviesList));
    verify(mockMovieRepository.getTrendingMovie());
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
