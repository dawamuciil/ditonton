import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

class DetailTvPage extends StatefulWidget {
  final int id;

  const DetailTvPage({
    required this.id,
    super.key,
  });

  @override
  State<DetailTvPage> createState() => _DetailTvPageState();
}

class _DetailTvPageState extends State<DetailTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<TvBloc>(context)
      ..add(DetailTvEvent(widget.id))
      ..add(WatchlistStatusTvEvent(widget.id)));
  }

  @override
  Widget build(BuildContext context) {
    closeAlertDialog(context);

    return Scaffold(
      body: BlocConsumer<TvBloc, TvState>(
        listener: (context, state) {
          _showMessage(state);
        },
        builder: (context, state) {
          if (state.detailState == RequestState.loading) {
            return const Center(
              key: Key('loading'),
              child: CircularProgressIndicator(),
            );
          } else if (state.detailState == RequestState.success) {
            return SafeArea(
              child: TvDetailContent(
                state.detailTv!,
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

  void _showMessage(TvState state) {
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