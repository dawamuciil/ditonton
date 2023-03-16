import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;

  const MovieDetailPage({
    required this.id,
    super.key,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<MovieBloc>(context)
      ..add(DetailMovieEvent(widget.id))
      ..add(WatchlistStatusEvent(widget.id)));
  }

  @override
  Widget build(BuildContext context) {
    closeAlertDialog(context);

    return Scaffold(
      body: BlocConsumer<MovieBloc, MovieState>(
        listener: (context, state) {
          _showMessage(state);
        },
        builder: (context, state) {
          if (state.detailState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.detailState == RequestState.success) {
            return SafeArea(
              child: DetailContent(
                state.detailMovie!,
                state.recommendationList,
                state.watchlistStatus,
              ),
            );
          } else {
            return Center(
              child: Text(state.message),
            );
          }
        },
      ),
    );
  }

  void _showMessage(MovieState state) {
    final msg = state.message;

    if (msg == watchlistAddSuccess || msg == watchlistRemoveSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          duration: const Duration(milliseconds: 700),
        ),
      );
    } else if (msg != '') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(state.message),
          );
        },
      );
    }
  }
}