import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String? label;
  final Color? color;

  const LoadingWidget({Key? key, this.label, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
        semanticsLabel: label,
      ),
    );
  }
}
