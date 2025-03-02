import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_manager/feature/application.dart';
import 'package:task_manager/feature/domain/repositories/task_repository.dart';

class Configurator extends StatefulWidget {
  const Configurator({super.key});

  @override
  State<Configurator> createState() => _ConfiguratorState();
}

class _ConfiguratorState extends State<Configurator> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => TaskRepository())],
      child: Application(),
    );
  }
}
