import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({
    super.key,
  });

  @override
  State<WatchlistMoviesPage> createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(WatchlistEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<MovieBloc>().add(WatchlistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state.watchlistState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.watchlistState == RequestState.success) {
              return ListView.builder(
                itemCount: state.watchlistList.length,
                itemBuilder: (context, index) {
                  final movie = state.watchlistList[index];
                  return MovieCard(movie);
                },
              );
            } else if (state.watchlistState == RequestState.empty) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.watchlistState == RequestState.error) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Failed'),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}