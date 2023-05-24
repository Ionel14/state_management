import 'dart:convert';

import 'package:http/http.dart';

import '../models/index.dart';

class UnsplashApi {
  UnsplashApi(this._apiKey);

  final String _apiKey;

  Future<List<Picture>> getPictures(int page, String searchText) async {
    final Uri uri = Uri(scheme: 'https', host: 'api.unsplash.com', pathSegments: <String>[
      'search',
      'photos'
    ], queryParameters: <String, String>{
      'query': searchText,
      'page': '$page',
      'client_id': _apiKey,
      'per_page': '30',
    });

    final Response response = await get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> map = jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> results = map['results'] as List<dynamic>;

      return (results.cast<Map<dynamic, dynamic>>().map((Map<dynamic, dynamic> json) => Picture.fromJson(json)))
          .toList();
    }
    throw StateError(response.body);
  }
}
