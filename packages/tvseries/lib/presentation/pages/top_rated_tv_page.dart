import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

class TopRatedTvPage extends StatefulWidget {
  const TopRatedTvPage({
    super.key,
  });

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TvBloc>(context).add(TopRatedTvEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvBloc, TvState>(
          builder: (context, state) {
            if (state.topRatedState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.topRatedState == RequestState.success) {
              return ListView.builder(
                itemCount: state.topRatedList.length,
                itemBuilder: (context, index) {
                  final tv = state.topRatedList[index];
                  return TvCardList(tv);
                },
              );
            } else if (state.topRatedState == RequestState.empty) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text(state.message),
              );
            }
          },
        ),
      ),
    );
  }
}