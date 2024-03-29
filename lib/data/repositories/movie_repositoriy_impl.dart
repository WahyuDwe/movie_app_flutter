import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:movie_apps/core/errors/server_exception.dart';
import 'package:movie_apps/core/errors/server_failure.dart';
import 'package:movie_apps/core/utils/mapper.dart';
import 'package:movie_apps/data/datasources/movie_remote_data_source.dart';
import 'package:movie_apps/data/models/movie_model.dart';
import 'package:movie_apps/domain/entities/movie.dart';
import 'package:movie_apps/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ServerFailure, List<Movie>>> getPopularMovies() async {
    try {
      final List<MovieModel> movieModels =
          await remoteDataSource.getPopularMovies();
      final List<Movie> movies = Mapper().toEntityMovie(movieModels);
      return Right(movies);
    } on ServerException catch (e) {
      log('repository ServerException -> TrendingMovies error: $e');
      return Left(ServerFailure(message: e.msg, code: e.code));
    }
    catch (e) {
      return Left(ServerFailure(message: e.toString(), code: null));
    }
  }

  @override
  Future<Either<ServerFailure, List<Movie>>> getTrendingMovie() async {
    try {
      final List<MovieModel> movieModels =
          await remoteDataSource.getTrendingMovies();
      final List<Movie> movies = Mapper().toEntityMovie(movieModels);
      return Right(movies);
    } on ServerException catch (e) {
      log('repository ServerException -> TrendingMovies error: $e');
      return Left(ServerFailure(message: e.msg, code: e.code));
    }
    catch (e) {
      return Left(ServerFailure(message: e.toString(), code: null));
    }
  }

  @override
  Future<Either<ServerFailure, List<Movie>>> searchMovies(String query) async {
    try {
      final List<MovieModel> movieModels =
          await remoteDataSource.searchMovies(query);
      final List<Movie> movies = Mapper().toEntityMovie(movieModels);
      return Right(movies);
    } on ServerException catch (e) {
      log('repository ServerException -> searchMovies error: $e');
      return Left(ServerFailure(message: e.msg, code: e.code));
    }
    catch (e) {
      log('repository -> searchMovies error: $e');
      return Left(ServerFailure(message: e.toString(), code: null));
    }
  }
}
