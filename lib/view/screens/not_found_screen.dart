import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NotFoundScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Page not found'),
        ),
      ),
    );
  }
}
