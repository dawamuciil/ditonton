import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

class PopularMoviesPage extends StatefulWidget {
  const PopularMoviesPage({
    super.key,
  });

  @override
  State<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieBloc>(context).add(NowPlayingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state.popularState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.popularState == RequestState.success) {
              return ListView.builder(
                itemCount: state.popularList.length,
                itemBuilder: (context, index) {
                  final movie = state.popularList[index];
                  return MovieCard(movie);
                },
              );
            } else if (state.popularState == RequestState.empty) {
              return Center(
                key: const Key('empty_message'),
                child: Text(state.message),
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            }
          },
        ),
      ),
    );
  }
}