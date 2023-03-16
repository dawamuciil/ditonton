import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class SeasonCardList extends StatelessWidget {
  final String title;
  final Season season;

  const SeasonCardList(
    this.title,
    this.season, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Card(
            child: Container(
              width: screenWidth,
              margin: const EdgeInsets.only(
                left: 16 + 80 + 16,
                bottom: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    season.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kSubtitle,
                  ),
                  Text(
                    '${getFormatYear(season.airDate)} | ${season.episodeCount} Episodes',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: kBodyBoldText,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Season ${season.seasonNumber} of $title on ${getFormatDate(season.airDate)}',
                    style: kBodySmallText,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 16,
              bottom: 16,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: CachedNetworkImage(
                imageUrl: season.posterPath != null
                    ? '$BASE_IMAGE_URL${season.posterPath}'
                    : BASE_IMAGE_URL,
                width: 80,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ],
      ),
    );
  }
}