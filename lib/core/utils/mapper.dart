import 'package:movie_apps/data/models/movie_model.dart';
import 'package:movie_apps/domain/entities/movie.dart';

class Mapper {
  toEntityMovie(List<MovieModel> movieModels) {
    return movieModels.map((e) => Movie(
          id: e.id,
          title: e.title,
          overview: e.overview,
          posterPath: e.posterPath,
        ),
    ).toList();
  }
}
