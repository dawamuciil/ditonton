import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

class WatchlistTvPage extends StatefulWidget {
  const WatchlistTvPage({
    super.key,
  });

  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<TvBloc>().add(WatchlistTvEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<TvBloc>().add(WatchlistTvEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvBloc, TvState>(
          builder: (context, state) {
            if (state.watchlistState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.watchlistState == RequestState.success) {
              return ListView.builder(
                itemCount: state.watchlistList.length,
                itemBuilder: (context, index) {
                  final tv = state.watchlistList[index];
                  return TvCardList(tv);
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