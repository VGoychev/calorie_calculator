import 'package:flutter/material.dart';

class LoadingDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return LoadingDialogWidget();
      },
    );
  }

  static void close(BuildContext context) {
    Navigator.pop(context);
  }
}

class LoadingDialogWidget extends StatelessWidget {
  const LoadingDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(
          strokeWidth: 6,
          padding: EdgeInsets.all(10),
        ),
      ),
    );
  }
}
