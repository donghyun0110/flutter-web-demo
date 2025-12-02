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

enum ViewMode {
  kiosk,
  mobile,
}

class AppState extends Equatable {
  final AppStep step;
  final CurrentQuestion currentQuestion;
  final UserProfile userProfile;
  final ViewMode viewMode;

  const AppState({
    this.step = AppStep.selection,
    this.currentQuestion = CurrentQuestion.language,
    this.userProfile = const UserProfile(),
    this.viewMode = ViewMode.kiosk,
  });

  AppState copyWith({
    AppStep? step,
    CurrentQuestion? currentQuestion,
    UserProfile? userProfile,
    ViewMode? viewMode,
  }) {
    return AppState(
      step: step ?? this.step,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      userProfile: userProfile ?? this.userProfile,
      viewMode: viewMode ?? this.viewMode,
    );
  }

  @override
  List<Object?> get props => [step, currentQuestion, userProfile, viewMode];
}

