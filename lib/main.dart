import 'package:flutter/material.dart';
import 'package:npe_logo_creator/home_page.dart';
import 'package:npe_logo_creator/providers/data_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'Inter'),
      home: ChangeNotifierProvider(
        create: (_) => DataNotifier(),
        child: const HomePage(),
      ),
    );
  }
}
