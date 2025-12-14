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
      bottomNavigationBar: Container(
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
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: const SizedBox(
                    height: 50,
                    child: Icon(Icons.home_outlined, size: 26),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: const SizedBox(
                    height: 50,
                    child: Icon(Icons.list_alt, size: 26),
                  ),
                ),
              ),
              const SizedBox(width: 60),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: const SizedBox(
                    height: 50,
                    child: Icon(Icons.restaurant_menu, size: 26),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: const SizedBox(
                    height: 50,
                    child: Icon(Icons.person_outline, size: 26),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
