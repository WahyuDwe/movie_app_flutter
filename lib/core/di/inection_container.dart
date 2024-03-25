import 'package:get_it/get_it.dart';
import 'package:movie_apps/data/datasources/movie_remote_data_source.dart';
import 'package:movie_apps/data/datasources/remote/movie_remote_data_source_impl.dart';
import 'package:movie_apps/data/repositories/movie_repositoriy_impl.dart';
import 'package:movie_apps/domain/repositories/movie_repository.dart';
import 'package:movie_apps/domain/usecases/movie_usecase.dart';
import 'package:movie_apps/domain/usecases/movie_usecase_impl.dart';
import 'package:movie_apps/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie_apps/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movie_apps/presentation/bloc/trending_movies/trending_movies_bloc.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

void init() {
  // bloc
  getIt.registerFactory(() => PopularMoviesBloc(movieUseCase: getIt()));
  getIt.registerFactory(() => TrendingMoviesBloc(movieUseCase: getIt()));
  getIt.registerFactory(() => SearchMoviesBloc(movieUseCase: getIt()));

  // useCases
  getIt.registerLazySingleton<MovieUseCase>(() => MovieUseCaseImpl(repository: getIt()));

  // repository
  getIt.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(remoteDataSource: getIt()));

  // data sources
  getIt.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(client: getIt()));

  // HttpClient
  getIt.registerLazySingleton(() => http.Client());
}
