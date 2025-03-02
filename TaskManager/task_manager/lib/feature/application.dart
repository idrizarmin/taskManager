import 'package:flutter/material.dart';

import 'package:task_manager/feature/presentation/pages/home_page.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
