import 'package:calorie_calculator/screens/home/home_view.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  late String currentPage;

  @override
  void initState() {
    super.initState();
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
