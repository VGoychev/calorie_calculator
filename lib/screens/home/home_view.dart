import 'package:calorie_calculator/widgets/home_bottom_app_bar/bottom_app_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(Icons.add, size: 36),
      ),
      floatingActionButtonLocation: _CustomFabLocation(),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }
}

class _CustomFabLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = (scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width) /
        2;
    final double fabY = scaffoldGeometry.scaffoldSize.height -
        scaffoldGeometry.floatingActionButtonSize.height / 2 -
        75;

    return Offset(fabX, fabY);
  }
}
