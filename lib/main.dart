import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/symptom_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const SickBayApp());
}

class SickBayApp extends StatelessWidget {
  const SickBayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SymptomProvider()),
      ],
      child: MaterialApp(
        title: 'Sick Bay',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
