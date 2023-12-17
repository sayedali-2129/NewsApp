import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_api_11_12/model/newsApiModel/news%20_api_model.dart';

class ApiController with ChangeNotifier {
  Map<String, dynamic> decodedData = {};
  NewsApiModel newsApiResponce = NewsApiModel();

  Future fetchData() async {
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=general&from=2023-12-17&to=2023-12-17&sortBy=popularity&apiKey=d278cc456b9043a79eb329ef72fd7532");
    final response = await http.get(url);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      decodedData = jsonDecode(response.body);
      newsApiResponce = NewsApiModel.fromJson(decodedData);
      notifyListeners();
    }
  }
}
