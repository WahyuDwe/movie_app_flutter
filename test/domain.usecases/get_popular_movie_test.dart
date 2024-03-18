import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_apps/domain/entities/movie.dart';
import 'package:movie_apps/domain/usecases/get_popular_movie.dart';
import 'get_trending_movie_test.mocks.dart';

void main() {
  late GetPopularMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetPopularMovies(mockMovieRepository);
  });

  final tMoviesList = [
    const Movie(
      id: 1,
      title: 'Test Movie 1',
      overview: 'Desc 1',
      posterPath: '/image1',
    ),
    const Movie(
      id: 2,
      title: 'Test Movie 2',
      overview: 'Desc 2',
      posterPath: '/image2',
    )
  ];

  test('should get popular movies from the repository', () async {
    // arrange
    when(mockMovieRepository.getPopularMovies())
        .thenAnswer((_) async => Right(tMoviesList));

    // act
    final result = await usecase();

    // assert
    expect(result, tMoviesList);
    verify(mockMovieRepository.getPopularMovies());
  });
}
