import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      right: 20,
      child: Container(
        padding: EdgeInsets.all(6),
        alignment: Alignment.bottomRight,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(30)),
        child: Icon(
          Icons.person_4_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
