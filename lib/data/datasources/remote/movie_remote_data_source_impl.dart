// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:movie_apps/core/errors/server_exception.dart';
import 'package:movie_apps/core/utils/constant.dart';
import 'package:movie_apps/data/datasources/movie_remote_data_source.dart';
import 'package:movie_apps/data/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await client.get(
      Uri.parse("${Constant.BASE_URL}/movie/popular?api_key=${Constant.API_KEY}"),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List<MovieModel> movies = (responseBody['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
      return movies;
    } else {
      log('RemoteDataSource -> getPopularMovies code: ${response.statusCode}');
      throw ServerException(msg: response.reasonPhrase, code: response.statusCode);
    }
  }

  @override
  Future<List<MovieModel>> getTrendingMovies() async {
    final response = await client
        .get(Uri.parse('${Constant.BASE_URL}/trending/movie/day?api_key=${Constant.API_KEY}'));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List<MovieModel> movies = (responseBody['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
      return movies;
    } else {
      log('RemoteDataSource -> getTrendingMovies code: ${response.statusCode}');
      throw ServerException(msg: response.reasonPhrase, code: response.statusCode);
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client
        .get(Uri.parse('${Constant.BASE_URL}/search/movie?query=$query&api_key=${Constant.API_KEY}'));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List<MovieModel> movies = (responseBody['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
      return movies;
    } else {
      log('RemoteDataSource -> searchMovies code: ${response.statusCode}');
      throw ServerException(msg: response.reasonPhrase, code: response.statusCode);
    }
  }
}
