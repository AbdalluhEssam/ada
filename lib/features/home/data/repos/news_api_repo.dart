import 'package:ada/features/home/data/models/news_model.dart';

import '../../../../core/constants/endpoint_constants.dart';
import '../../../../core/network/dio_client.dart';

class NewsApiRepo {
  final dio = DioClient();
  String apiKey = "a08b245643ce47d593f266a2b3bc7c4f";

  Future<List<NewsModel>> fetchNews(String query) async {
    final response = await dio.get(
      EndpointConstants.everything,
      queryParameters: {
        "q": query,
        "from": "2025-06-16",
        "sortBy": "publishedAt",
        "apiKey": apiKey,
      },
    );
    return (response.data['articles'] as List)
        .map((e) => NewsModel.fromJson(e))
        .toList();
  }


  Future<List<NewsModel>> fetchNewsByCategory(String category) async {
    final response = await dio.get(
      EndpointConstants.topHeadlines,
      queryParameters: {
        "country": "us",
        "category": category,
        "apiKey": apiKey,
      },
    );
    return (response.data['articles'] as List)
        .map((e) => NewsModel.fromJson(e))
        .toList();
  }
}
