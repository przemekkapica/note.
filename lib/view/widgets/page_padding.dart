import 'package:flutter/material.dart';

class PagePadding extends StatelessWidget {
  const PagePadding({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: child,
    );
  }
}
