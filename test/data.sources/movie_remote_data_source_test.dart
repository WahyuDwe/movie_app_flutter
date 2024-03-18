import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_apps/core/errors/server_exception.dart';
import 'package:movie_apps/data/datasources/movie_remote_data_source.dart';
import 'package:movie_apps/data/datasources/remote/movie_remote_data_source_impl.dart';

import 'movie_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockHttpClient;
  late MovieRemotedataSource dataSource;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = MovieRemoteDatasourceImpl(client: mockHttpClient);
  });

  const sQuery = 'Interstellar';

  const tUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=8bdb4d221b7ca95aa2c0ea30b6a3dda4';
  const pUrl =
      'https://api.themoviedb.org/3/movie/popular?api_key=8bdb4d221b7ca95aa2c0ea30b6a3dda4';
  const sUrl =
      'https://api.themoviedb.org/3/search/movie?query=$sQuery?api_key=8bdb4d221b7ca95aa2c0ea30b6a3dda4';

  const String sampleApiResponse = '''
{
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/path.jpg",
      "id": 1,
      "title": "Sample Movie",
      "original_language": "en",
      "original_title": "Sample Movie",
      "overview": "Overview here",
      "poster_path": "/path2.jpg",
      "media_type": "movie",
      "genre_ids": [1, 2, 3],
      "popularity": 100.0,
      "release_date": "2020-01-01",
      "video": false,
      "vote_average": 7.5,
      "vote_count": 100
    }
  ],
  "total_pages": 1,
  "total_results": 1
}
''';

  group('should perform test for TMDB api', () {
    test('should perfom a GET request on an url to get trending movies',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(tUrl)))
          .thenAnswer((_) async => http.Response(sampleApiResponse, 200));

      // act
      await dataSource.getTrendingMovies();

      // assert
      verify(mockHttpClient.get(Uri.parse(tUrl)));
    });

    test('should perform a GET request on an url to get popular movies',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(pUrl)))
          .thenAnswer((_) async => http.Response(sampleApiResponse, 200));

      // act
      await dataSource.getPopularMovies();

      // assert
      verify(mockHttpClient.get(Uri.parse(pUrl)));
    });

    test('should perform a GET request on an url to get searcher movies',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(sUrl)))
          .thenAnswer((_) async => http.Response(sampleApiResponse, 200));

      // act
      await dataSource.searchMovies(sQuery);

      // assert
      verify(mockHttpClient.get(Uri.parse(sUrl)));
    });

    test('should throw a ServerException when the response code is 404',
        () async {
      // arrange
      when(mockHttpClient.get(any))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));

      // act
      final call = dataSource.getTrendingMovies;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });
}
