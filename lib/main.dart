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
import 'widgets/fp_text.dart';
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
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ko'),
              Locale('en'),
              Locale('ja'),
              Locale('zh'),
            ],
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
      // 모바일 뷰로 전환
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
              // 모바일 뷰 모드
              if (state.viewMode == ViewMode.mobile) {
                return _buildMobileView(state);
              }
              
              // 키오스크 모드
              return Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    _buildViewModeSwitcher(),
                    const SizedBox(height: 24),
                    Expanded(
                      child: Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: _buildStep(state.step, state.viewMode),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildViewModeSwitcher() {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ViewModeButton(
                label: '키오스크 모드',
                icon: Icons.desktop_windows,
                isSelected: state.viewMode == ViewMode.kiosk,
                onTap: () => context.read<AppBloc>().add(const SetViewMode(ViewMode.kiosk)),
              ),
              const SizedBox(width: 8),
              _ViewModeButton(
                label: '모바일 미리보기',
                icon: Icons.smartphone,
                isSelected: state.viewMode == ViewMode.mobile,
                onTap: () => context.read<AppBloc>().add(const SetViewMode(ViewMode.mobile)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileView(AppState state) {
    if (state.viewMode == ViewMode.mobile && 
        state.userProfile.language != null &&
        state.userProfile.gender != null &&
        state.userProfile.ageGroup != null &&
        state.userProfile.concern != null) {
      return Center(
        child: Container(
          width: 375,
          height: 667,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(color: Colors.grey.shade800, width: 8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: MobileResultPage(userProfile: state.userProfile),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildStep(AppStep step, ViewMode viewMode) {
    if (viewMode == ViewMode.mobile) {
      return BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state.userProfile.language != null &&
              state.userProfile.gender != null &&
              state.userProfile.ageGroup != null &&
              state.userProfile.concern != null) {
            return Center(
              child: Container(
                width: 375,
                height: 667,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade800, width: 8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: MobileResultPage(userProfile: state.userProfile),
                ),
              ),
            );
          }
          return const SelectionStep();
        },
      );
    }

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

class _ViewModeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ViewModeButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? FpColor.green : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            const SizedBox(width: 8),
            FpText(
              label,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
