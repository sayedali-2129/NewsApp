import 'package:flutter/material.dart';
import 'package:news_api_11_12/controller/api_controller.dart';
import 'package:news_api_11_12/controller/category_controller.dart';
import 'package:news_api_11_12/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

import 'controller/search_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ApiController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: homeScreen(),
      ),
    );
  }
}
