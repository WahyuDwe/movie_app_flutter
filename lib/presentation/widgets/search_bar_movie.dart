import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/presentation/bloc/search_movies/search_movies_bloc.dart';

class SearchBarMovie extends StatefulWidget {
  const SearchBarMovie({super.key});

  @override
  State<SearchBarMovie> createState() => _SearchBarMovieState();
}

class _SearchBarMovieState extends State<SearchBarMovie> {
  final _textController = TextEditingController();
  late SearchMoviesBloc _searchMoviesBloc;

  @override
  void initState() {
    super.initState();
    _searchMoviesBloc = context.read<SearchMoviesBloc>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onClearTapped() {
    _textController.text = '';
    _searchMoviesBloc.add(InitSearchMovies());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      controller: _textController,
      prefixIcon: const Icon(CupertinoIcons.search),
      placeholder: 'Cari filem...',
      suffixIcon: const Icon(CupertinoIcons.clear_thick_circled),
      onChanged: (text) {
        if (text.isEmpty) {
          _searchMoviesBloc.add(InitSearchMovies());
        } else {
          _searchMoviesBloc.add(FetchSearchMovies(query: text));
        }
      },
      onSuffixTap: _onClearTapped,

    );
  }
}
