import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_test/l10n/app_localizations.dart';
import 'dart:html' as html;
import 'bloc/app_bloc.dart';
import 'bloc/app_event.dart';
import 'bloc/app_state.dart';
import 'widgets/selection_step.dart';
import 'widgets/loading_step.dart';
import 'widgets/results_step.dart';
import 'widgets/mobile_result_page.dart';
import 'widgets/fp_color.dart';
import 'models/user_profile.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Locale _getLocale(Language language) {
    switch (language) {
      case Language.korean:
        return const Locale('ko');
      case Language.english:
        return const Locale('en');
      case Language.japanese:
        return const Locale('ja');
      case Language.chinese:
        return const Locale('zh');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          final language = state.userProfile.language ?? Language.korean;
          final locale = _getLocale(language);

          return MaterialApp(
            title: '건강 추천 앱',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.green, scaffoldBackgroundColor: FpColor.emerald50),
            locale: locale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('ko'), Locale('en'), Locale('ja'), Locale('zh')],
            home: const AppView(),
          );
        },
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  void initState() {
    super.initState();
    _checkUrlParams();
  }

  void _checkUrlParams() {
    final uri = Uri.parse(html.window.location.href);
    final params = uri.queryParameters;

    if (params['view'] == 'mobile') {
      // URL 파라미터로 모바일 뷰 요청 시
      final language = _parseLanguage(params['lang']);
      final gender = _parseGender(params['gender']);
      final ageGroup = _parseAgeGroup(params['age']);
      final concern = _parseConcern(params['concern']);

      if (language != null && gender != null && ageGroup != null && concern != null) {
        context.read<AppBloc>().add(LanguageSelected(language));
        context.read<AppBloc>().add(GenderSelected(gender));
        context.read<AppBloc>().add(AgeSelected(ageGroup));
        context.read<AppBloc>().add(ConcernSelected(concern));
        context.read<AppBloc>().add(const SetViewMode(ViewMode.mobile));
      }
    }
  }

  Language? _parseLanguage(String? lang) {
    switch (lang?.toLowerCase()) {
      case 'korean':
      case 'ko':
        return Language.korean;
      case 'english':
      case 'en':
        return Language.english;
      case 'japanese':
      case 'ja':
        return Language.japanese;
      case 'chinese':
      case 'zh':
        return Language.chinese;
      default:
        return null;
    }
  }

  Gender? _parseGender(String? gender) {
    switch (gender?.toLowerCase()) {
      case 'male':
      case 'm':
        return Gender.male;
      case 'female':
      case 'f':
        return Gender.female;
      default:
        return null;
    }
  }

  AgeGroup? _parseAgeGroup(String? age) {
    switch (age) {
      case '10s':
        return AgeGroup.teens;
      case '20s':
        return AgeGroup.twenties;
      case '30s':
        return AgeGroup.thirties;
      case '40s':
        return AgeGroup.forties;
      case '50s+':
        return AgeGroup.fiftiesPlus;
      default:
        return null;
    }
  }

  Concern? _parseConcern(String? concern) {
    switch (concern?.toLowerCase()) {
      case 'immune':
        return Concern.immune;
      case 'digestive':
        return Concern.digestive;
      case 'joint':
        return Concern.joint;
      case 'skin':
        return Concern.skin;
      case 'eye':
        return Concern.eye;
      case 'energy':
        return Concern.energy;
      default:
        return null;
    }
  }

  bool _isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = _isMobile(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [FpColor.emerald50, FpColor.teal50]),
        ),
        child: SafeArea(
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              // URL 파라미터로 모바일 뷰 요청 시
              if (state.viewMode == ViewMode.mobile &&
                  state.userProfile.language != null &&
                  state.userProfile.gender != null &&
                  state.userProfile.ageGroup != null &&
                  state.userProfile.concern != null) {
                return MobileResultPage(userProfile: state.userProfile);
              }

              // 모바일 기기인 경우
              if (isMobile) {
                return _buildMobileLayout(context, state);
              }

              // 데스크톱 기기인 경우
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

  Widget _buildMobileLayout(BuildContext context, AppState state) {
    switch (state.step) {
      case AppStep.selection:
        return const SelectionStep();
      case AppStep.loading:
        return const LoadingStep();
      case AppStep.results:
        if (state.userProfile.language != null && state.userProfile.gender != null && state.userProfile.ageGroup != null && state.userProfile.concern != null) {
          return MobileResultPage(userProfile: state.userProfile);
        }
        return const ResultsStep();
    }
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
