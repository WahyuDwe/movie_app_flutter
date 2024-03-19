import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_apps/domain/entities/movie.dart';
import 'package:movie_apps/domain/usecases/search_movie.dart';
import 'get_trending_movie_test.mocks.dart';

void main() {
  late SearchMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMovies(mockMovieRepository);
  });

  const tQuery = 'Inception';

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

  test('should get movies from the query repository', () async {
    // arrange
    when(mockMovieRepository.searchMovies(any))
        .thenAnswer((_) async => Right(tMoviesList));

    // act
    final result = await usecase(tQuery);

    // assert
    expect(result, Right(tMoviesList));
    verify(mockMovieRepository.searchMovies(tQuery));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
