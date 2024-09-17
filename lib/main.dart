import 'package:exam_project/bloc/bloc/income_bloc.dart';
import 'package:exam_project/core/services/database_helper.dart';
import 'package:exam_project/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IncomeBloc(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
