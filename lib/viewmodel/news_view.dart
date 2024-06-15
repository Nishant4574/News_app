import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:news_app/model/Categories_News.dart';
import 'package:news_app/model/newsheadlines.dart';
import 'package:news_app/repository/news_repository.dart';

import '../model/Topheadlines.dart';

class NewsviewModel{
  final _rep= NewsRepository(

  );

  Future<Newsheadlinesmodels> fetchNewChannelHeadlinesApias(String channelName)async{
final response = await _rep.fetchNewsChannelHeadlinesApi(channelName);
return response;

}
  Future<CategoriesNewsModel> fetchCategoriesNewsapi(String Categorty) async {
    final response = await _rep.fetchCategoriesNewsapi(Categorty);
    return response;

  }
  Future<TophealinesinUS> fetchTopheadlinesApi() async {
    final response = await _rep.fetchTopheadlinesApi();
    return response;

  }
}
