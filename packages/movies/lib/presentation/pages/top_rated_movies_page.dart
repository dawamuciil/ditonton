import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

class TopRatedMoviesPage extends StatefulWidget {
  const TopRatedMoviesPage({
    super.key,
  });

  @override
  State<TopRatedMoviesPage> createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieBloc>(context).add(TopRatedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state.topRatedState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.topRatedState == RequestState.success) {
              return ListView.builder(
                itemCount: state.topRatedList.length,
                itemBuilder: (context, index) {
                  final movie = state.topRatedList[index];
                  return MovieCard(movie);
                },
              );
            } else if (state.topRatedState == RequestState.empty) {
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