import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({super.key});

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
    );
  }
}
