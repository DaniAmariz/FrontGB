import 'package:flutter/material.dart';
import 'config/router/appRouter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ecosfera',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}

