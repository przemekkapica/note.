import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  InfoDialog({required this.description});

  final String description;

  _dismissDialog(context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              description,
              softWrap: true,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              child: Text('OK'),
              onPressed: () => _dismissDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}
