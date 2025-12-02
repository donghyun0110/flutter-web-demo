import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<LanguageSelected>(_onLanguageSelected);
    on<GenderSelected>(_onGenderSelected);
    on<AgeSelected>(_onAgeSelected);
    on<ConcernSelected>(_onConcernSelected);
    on<ResetApp>(_onResetApp);
    on<SetViewMode>(_onSetViewMode);
  }

  void _onLanguageSelected(LanguageSelected event, Emitter<AppState> emit) {
    emit(
      state.copyWith(
        userProfile: state.userProfile.copyWith(language: event.language),
        currentQuestion: CurrentQuestion.gender,
      ),
    );
  }

  void _onGenderSelected(GenderSelected event, Emitter<AppState> emit) {
    emit(
      state.copyWith(
        userProfile: state.userProfile.copyWith(gender: event.gender),
        currentQuestion: CurrentQuestion.age,
      ),
    );
  }

  void _onAgeSelected(AgeSelected event, Emitter<AppState> emit) {
    emit(
      state.copyWith(
        userProfile: state.userProfile.copyWith(ageGroup: event.ageGroup),
        currentQuestion: CurrentQuestion.concern,
      ),
    );
  }

  Future<void> _onConcernSelected(ConcernSelected event, Emitter<AppState> emit) async {
    emit(
      state.copyWith(
        userProfile: state.userProfile.copyWith(concern: event.concern),
        step: AppStep.loading,
      ),
    );

    // 2.5초 후 결과 화면으로 이동
    await Future.delayed(const Duration(milliseconds: 2500));

    if (!emit.isDone && !isClosed) {
      emit(state.copyWith(step: AppStep.results));
    }
  }

  void _onResetApp(ResetApp event, Emitter<AppState> emit) {
    emit(const AppState());
  }

  void _onSetViewMode(SetViewMode event, Emitter<AppState> emit) {
    emit(state.copyWith(viewMode: event.viewMode));
  }
}
