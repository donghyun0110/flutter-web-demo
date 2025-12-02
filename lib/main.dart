import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/app_bloc.dart';
import 'bloc/app_state.dart';
import 'widgets/selection_step.dart';
import 'widgets/loading_step.dart';
import 'widgets/results_step.dart';
import 'widgets/fp_color.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(),
      child: MaterialApp(
        title: '건강 추천 앱',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green, scaffoldBackgroundColor: FpColor.emerald50),
        home: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [FpColor.emerald50, FpColor.teal50]),
        ),
        child: SafeArea(
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: Container(constraints: const BoxConstraints(maxWidth: 1200), child: _buildStep(state.step)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStep(AppStep step) {
    switch (step) {
      case AppStep.selection:
        return const SelectionStep();
      case AppStep.loading:
        return const LoadingStep();
      case AppStep.results:
        return const ResultsStep();
    }
  }
}
