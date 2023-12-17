import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_api_11_12/model/newsApiModel/news%20_api_model.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CategoryController with ChangeNotifier {
  List<String> categoryList = [
    "General",
    "Business",
    "Entertainment",
    "Sports",
    "Health",
    "Science",
    "Technology",
  ];
  NewsApiModel newsApiResponce = NewsApiModel();
  Map<String, dynamic> decodedData = {};
  bool isLoading = false;
  String category = "general";

  onTap({required int index}) {
    category = categoryList[index].toLowerCase();
    fetchData();
    print(category);
    notifyListeners();
  }

  Future fetchData() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$category&from=2023-12-16&to=2023-12-16&sortBy=popularity&apiKey=d278cc456b9043a79eb329ef72fd7532");
    final response = await http.get(url);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      decodedData = jsonDecode(response.body);
      newsApiResponce = NewsApiModel.fromJson(decodedData);
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> launchURL(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
    notifyListeners();
  }
}
