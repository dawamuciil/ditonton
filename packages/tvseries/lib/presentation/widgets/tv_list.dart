import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;
  final bool isRecommended;

  const TvSeriesList(
    this.tvSeries,
    this.isRecommended, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tvSeries.length,
        itemBuilder: (context, index) {
          final data = tvSeries[index];

          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                if (isRecommended) {
                  Navigator.pushReplacementNamed(
                    context,
                    DETAIL_TV_ROUTE,
                    arguments: data.id,
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    DETAIL_TV_ROUTE,
                    arguments: data.id,
                  );
                }
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${data.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
