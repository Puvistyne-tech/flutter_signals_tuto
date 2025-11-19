import 'package:flutter/material.dart';
import 'package:flutter_signals_tuto/stateless_complex_counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.green),
      ),
      home: const StatelessComplexCounter(title: 'Signals Counter App'),
    );
  }
}
