import 'package:equatable/equatable.dart';
import '../models/user_profile.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class LanguageSelected extends AppEvent {
  final Language language;

  const LanguageSelected(this.language);

  @override
  List<Object?> get props => [language];
}

class GenderSelected extends AppEvent {
  final Gender gender;

  const GenderSelected(this.gender);

  @override
  List<Object?> get props => [gender];
}

class AgeSelected extends AppEvent {
  final AgeGroup ageGroup;

  const AgeSelected(this.ageGroup);

  @override
  List<Object?> get props => [ageGroup];
}

class ConcernSelected extends AppEvent {
  final Concern concern;

  const ConcernSelected(this.concern);

  @override
  List<Object?> get props => [concern];
}

class ResetApp extends AppEvent {
  const ResetApp();
}

