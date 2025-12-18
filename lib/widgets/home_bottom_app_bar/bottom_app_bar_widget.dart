import 'package:calorie_calculator/widgets/home_bottom_app_bar/bottom_bar_item.dart';
import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatefulWidget {
  final String currentPage;
  final Function(String) onPageChanged;
  const BottomAppBarWidget(this.currentPage, this.onPageChanged, {super.key});

  @override
  State<BottomAppBarWidget> createState() => _BottomAppBarWidgetState();
}

class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
  bool _isSelected(String page) {
    return widget.currentPage == page;
  }

  void onPageChanged(String page) {
    setState(() {
      widget.onPageChanged(page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black12,
            width: 1,
          ),
        ),
      ),
      child: BottomAppBar(
        height: 60,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            BottomBarItem(
              isSelected: _isSelected('home'),
              onTap: () {
                if (_isSelected('home')) return;
                onPageChanged('home');
              },
              selectedIcon: Icons.home,
              notSelectedIcon: Icons.home_outlined,
            ),
            BottomBarItem(
              isSelected: _isSelected('logs'),
              onTap: () {
                if (_isSelected('logs')) return;
                onPageChanged('logs');
              },
              selectedIcon: Icons.list_alt,
            ),
            const SizedBox(width: 60),
            BottomBarItem(
              isSelected: _isSelected('meals'),
              onTap: () {
                if (_isSelected('meals')) return;
                onPageChanged('meals');
              },
              selectedIcon: Icons.restaurant_menu,
            ),
            BottomBarItem(
              isSelected: _isSelected('profile'),
              onTap: () {
                if (_isSelected('profile')) return;
                onPageChanged('profile');
              },
              selectedIcon: Icons.person,
              notSelectedIcon: Icons.person_outline,
            )
          ],
        ),
      ),
    );
  }
}
