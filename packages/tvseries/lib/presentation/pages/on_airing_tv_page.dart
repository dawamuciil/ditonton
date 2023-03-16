import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

class OnAiringTvPage extends StatefulWidget {
  const OnAiringTvPage({
    super.key,
  });

  @override
  State<OnAiringTvPage> createState() => _OnAiringTvPageState();
}

class _OnAiringTvPageState extends State<OnAiringTvPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TvBloc>(context).add(OnAiringEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On Airing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvBloc, TvState>(
          builder: (context, state) {
            if (state.onAiringState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.onAiringState == RequestState.success) {
              return ListView.builder(
                itemCount: state.onAiringList.length,
                itemBuilder: (context, index) {
                  final tv = state.onAiringList[index];
                  return TvCardList(tv);
                },
              );
            } else if (state.onAiringState == RequestState.empty) {
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