import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note/utils/constants.dart';
import 'package:note/utils/route/app_router.dart';
import 'package:note/utils/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  final AppRouter appRouter = AppRouter();
  final AppTheme appTheme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      debugShowCheckedModeBanner: false,
      theme: appTheme.theme(context),
      onGenerateRoute: appRouter.onGenerateRoute,
      onGenerateInitialRoutes: appRouter.onGenerateInitialRoutes,
      onUnknownRoute: appRouter.onUnknownRoute,
    );
  }
}
