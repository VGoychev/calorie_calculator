import 'package:calorie_calculator/models/added_meal_item.dart';
import 'package:calorie_calculator/screens/add_meal_manually/add_meal_manually.dart';
import 'package:calorie_calculator/screens/home/controller/main_page_controller.dart';
import 'package:calorie_calculator/screens/home/home.dart';
import 'package:calorie_calculator/widgets/add_meal_bottom_sheet/add_meal_bottom_sheet.dart';
import 'package:calorie_calculator/widgets/home_bottom_app_bar/bottom_app_bar_widget.dart';
import 'package:calorie_calculator/widgets/home_bottom_app_bar/floating_button.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final HomeState state;
  const HomeView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainPageController.getPage(state.currentPage, state.onPageChanged),
      floatingActionButton: FloatingButton(
        onPressed: () {
          AddMealBottomSheet.show(
            context,
            onAddManually: () async {
              final result = await Navigator.push<AddedMealItem>(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddMealManually(),
                ),
              );

              if (result != null && context.mounted) {
                // TODO: Handle the added meal item (save to database, update UI, etc.)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${result.name} added successfully!'),
                  ),
                );
              }
            },
            onTakePhoto: () {},
          );
        },
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
