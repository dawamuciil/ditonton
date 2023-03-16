import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tvseries/tvseries.dart';

class SeasonTvPage extends StatefulWidget {
  final String title;
  final List<Season> seasons;

  const SeasonTvPage(
    this.title,
    this.seasons, {
    super.key,
  });

  @override
  State<SeasonTvPage> createState() => _SeasonTvPageState();
}

class _SeasonTvPageState extends State<SeasonTvPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Seasons'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.seasons.length,
          itemBuilder: (context, index) {
            final season = widget.seasons[index];
            return SeasonCardList(widget.title, season);
          },
        ),
      ),
    );
  }
}