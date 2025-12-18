import 'package:calorie_calculator/screens/home/controller/main_page_controller.dart';
import 'package:calorie_calculator/screens/home/home_view.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  late String currentPage;
  late final MainPageController mainPageController;

  @override
  void initState() {
    super.initState();
    mainPageController = MainPageController();
    currentPage = 'home';
  }

  void onPageChanged(String page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomeView(this);
  }
}
