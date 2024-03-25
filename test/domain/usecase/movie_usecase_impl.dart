import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_apps/domain/entities/movie.dart';
import 'package:movie_apps/domain/repositories/movie_repository.dart';
import 'package:movie_apps/domain/usecases/movie_usecase.dart';
import 'package:movie_apps/domain/usecases/movie_usecase_impl.dart';

import 'movie_usecase_impl.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])
void main() {
  late MovieUseCase usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = MovieUseCaseImpl(repository: mockMovieRepository);
  });

  const tQuery = 'Inception';

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

  group('should perform test for get data from repository', () {

    test('should get popular from the repository', () async {
      when(mockMovieRepository.getPopularMovies())
          .thenAnswer((_) async => Right(tMoviesList));

      final result = await usecase.getPopularMovies();

      expect(result, equals(Right(tMoviesList)));
      verify(mockMovieRepository.getPopularMovies());
      verifyNoMoreInteractions(mockMovieRepository);
    });

    test('should get trending from the repository', () async {
      when(mockMovieRepository.getTrendingMovie())
          .thenAnswer((_) async => Right(tMoviesList));

      final result = await usecase.getTrendingMovie();

      expect(result, equals(Right(tMoviesList)));
      verify(mockMovieRepository.getTrendingMovie());
      verifyNoMoreInteractions(mockMovieRepository);
    });

    test('should get movies from the query repository', () async {
      when(mockMovieRepository.searchMovies(any))
          .thenAnswer((_) async => Right(tMoviesList));

      final result = await usecase.searchMovies(tQuery);

      expect(result, Right(tMoviesList));
      verify(mockMovieRepository.searchMovies(tQuery));
      verifyNoMoreInteractions(mockMovieRepository);
    });

  });
}
