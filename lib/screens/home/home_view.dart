import 'package:calorie_calculator/screens/home/home.dart';
import 'package:calorie_calculator/widgets/home_bottom_app_bar/bottom_app_bar_widget.dart';
import 'package:calorie_calculator/widgets/home_bottom_app_bar/floating_button.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final HomeState state;
  const HomeView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: state.mainPageController.getPage(state.currentPage),
      floatingActionButton: FloatingButton(
        onPressed: () {},
      ),
      floatingActionButtonLocation: _CustomFabLocation(),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
      bottomNavigationBar:
          BottomAppBarWidget(state.currentPage, state.onPageChanged),
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
