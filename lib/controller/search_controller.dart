import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_api_11_12/model/newsApiModel/news%20_api_model.dart';
import 'package:http/http.dart' as http;

class SearchScreenController with ChangeNotifier {
  Map<String, dynamic> decodedData = {};
  NewsApiModel? searchResponce = NewsApiModel();
  bool isLoading = false;

  Future SearchData({required String searchData}) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$searchData&from=2023-12-10&to=2023-12-10&sortBy=popularity&apiKey=d278cc456b9043a79eb329ef72fd7532");
    final response = await http.get(url);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      decodedData = jsonDecode(response.body);
      searchResponce = NewsApiModel.fromJson(decodedData);
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }
}
