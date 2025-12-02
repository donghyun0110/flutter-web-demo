import 'package:equatable/equatable.dart';
import '../models/user_profile.dart';

enum AppStep {
  selection,
  loading,
  results,
}

enum CurrentQuestion {
  language,
  gender,
  age,
  concern,
}

class AppState extends Equatable {
  final AppStep step;
  final CurrentQuestion currentQuestion;
  final UserProfile userProfile;

  const AppState({
    this.step = AppStep.selection,
    this.currentQuestion = CurrentQuestion.language,
    this.userProfile = const UserProfile(),
  });

  AppState copyWith({
    AppStep? step,
    CurrentQuestion? currentQuestion,
    UserProfile? userProfile,
  }) {
    return AppState(
      step: step ?? this.step,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      userProfile: userProfile ?? this.userProfile,
    );
  }

  @override
  List<Object?> get props => [step, currentQuestion, userProfile];
}

