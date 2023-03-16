import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tGenreModel = GenreModel(
    id: 1,
    name: "Name",
  );

  const tGenre = Genre(
    id: 1,
    name: "Name",
  );

  test('should return a valid model from JSON', () async {
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/genre.json'));
    final result = GenreModel.fromJson(jsonMap);

    expect(result, tGenreModel);
  });

  test('should return a JSON map containing proper data', () async {
    final result = tGenreModel.toJson();
    final expectedJsonMap = {
      "id": 1,
      "name": "Name",
    };

    expect(result, expectedJsonMap);
  });

  test('should be a subclass of genre entity', () async {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });
}
