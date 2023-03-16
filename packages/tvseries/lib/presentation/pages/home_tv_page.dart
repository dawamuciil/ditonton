import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => BlocProvider.of<TvBloc>(context)
      ..add(OnAiringEvent())
      ..add(PopularTvEvent())
      ..add(TopRatedTvEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, SEARCH_TV_ROUTE),
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubHeading(
                title: 'On Airing',
                isPressed: true,
                onTap: () => Navigator.pushNamed(context, ON_AIRING_TV_ROUTE),
              ),
              BlocBuilder<TvBloc, TvState>(
                builder: (context, state) {
                  if (state.onAiringState == RequestState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.onAiringState == RequestState.success) {
                    return TvSeriesList(state.onAiringList, false);
                  } else if (state.onAiringState == RequestState.empty) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else if (state.onAiringState == RequestState.error) {
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
              SubHeading(
                title: 'Popular',
                isPressed: true,
                onTap: () => Navigator.pushNamed(context, POPULAR_TV_ROUTE),
              ),
              BlocBuilder<TvBloc, TvState>(
                builder: (context, state) {
                  if (state.popularState == RequestState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.popularState == RequestState.success) {
                    return TvSeriesList(state.popularList, false);
                  } else if (state.popularState == RequestState.empty) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else if (state.popularState == RequestState.error) {
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
              SubHeading(
                title: 'Top Rated',
                isPressed: true,
                onTap: () => Navigator.pushNamed(context, TOP_RATED_TV_ROUTE),
              ),
              BlocBuilder<TvBloc, TvState>(
                builder: (context, state) {
                  if (state.topRatedState == RequestState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.topRatedState == RequestState.success) {
                    return TvSeriesList(state.topRatedList, false);
                  } else if (state.topRatedState == RequestState.empty) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else if (state.topRatedState == RequestState.error) {
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
            ],
          ),
        ),
      ),
    );
  }
}
