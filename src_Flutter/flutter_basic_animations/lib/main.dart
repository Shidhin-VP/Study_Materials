import 'package:flutter/material.dart';
import 'package:flutter_basic_animations/pages/explict_examples/list_animation.dart';
import 'package:flutter_basic_animations/pages/explict_examples/loading_animation.dart';
import 'package:flutter_basic_animations/pages/explict_examples/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoadingAnimationPage());
  }
}
