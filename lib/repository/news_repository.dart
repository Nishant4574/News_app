import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;
import 'package:news_app/model/Categories_News.dart';
import 'package:news_app/model/newsheadlines.dart';

import '../model/Topheadlines.dart';
class NewsRepository {


  Future<Newsheadlinesmodels> fetchNewsChannelHeadlinesApi(
      String newsChannel) async {
    String newsUrl = 'https://newsapi.org/v2/top-headlines?sources=${newsChannel}&apiKey=8a5ec37e26f845dcb4c2b78463734448';
    print(newsUrl);
    final response = await http.get(Uri.parse(newsUrl));
    print(response.statusCode.toString());
    print(response);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return Newsheadlinesmodels.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsapi(String Categorty) async {
    String newsUrl = "https://newsapi.org/v2/everything?q=${Categorty}&apiKey=b0194cb909ef4f89a210de4eeeed22b1";
    print(newsUrl);
    final response = await http.get(Uri.parse(newsUrl));
    print(response.statusCode.toString());
    print(response);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }
  Future<TophealinesinUS> fetchTopheadlinesApi() async {
    String newsUrl = 'https://newsapi.org/v2/top-headlines?q=trump&apiKey=b0194cb909ef4f89a210de4eeeed22b1';
    print(newsUrl);
    final response = await http.get(Uri.parse(newsUrl));
    print(response.statusCode.toString());
    print(response);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return TophealinesinUS.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }
}