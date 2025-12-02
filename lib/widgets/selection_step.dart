import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_test/l10n/app_localizations.dart';
import '../bloc/app_bloc.dart';
import '../bloc/app_event.dart';
import '../bloc/app_state.dart';
import '../models/user_profile.dart';
import 'fp_text.dart';
import 'fp_color.dart';

class SelectionStep extends StatelessWidget {
  const SelectionStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        switch (state.currentQuestion) {
          case CurrentQuestion.language:
            return _LanguageSelection();
          case CurrentQuestion.gender:
            return _GenderSelection();
          case CurrentQuestion.age:
            return _AgeSelection();
          case CurrentQuestion.concern:
            return _ConcernSelection();
        }
      },
    );
  }
}

class _LanguageSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Column(
      children: [
        _ProgressIndicator(currentIndex: 0),
        SizedBox(height: isMobile ? 24 : 40),
        FpText(l10n.selectLanguage, fontSize: isMobile ? 24 : 28, fontWeight: FontWeight.bold, color: Colors.black87),
        SizedBox(height: isMobile ? 24 : 40),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: isMobile ? 12 : 16,
            crossAxisSpacing: isMobile ? 12 : 16,
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            childAspectRatio: isMobile ? 1.3 : 1.5,
            children: [
              _LanguageButton(language: Language.korean, color: FpColor.green, flag: '🇰🇷', isMobile: isMobile),
              _LanguageButton(language: Language.english, color: FpColor.blue, flag: '🇺🇸', isMobile: isMobile),
              _LanguageButton(language: Language.japanese, color: FpColor.red, flag: '🇯🇵', isMobile: isMobile),
              _LanguageButton(language: Language.chinese, color: FpColor.yellow, flag: '🇨🇳', isMobile: isMobile),
            ],
          ),
        ),
      ],
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final Language language;
  final Color color;
  final String flag;
  final bool isMobile;

  const _LanguageButton({required this.language, required this.color, required this.flag, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String label;
    switch (language) {
      case Language.korean:
        label = l10n.languageKorean;
        break;
      case Language.english:
        label = l10n.languageEnglish;
        break;
      case Language.japanese:
        label = l10n.languageJapanese;
        break;
      case Language.chinese:
        label = l10n.languageChinese;
        break;
    }

    return ElevatedButton(
      onPressed: () {
        context.read<AppBloc>().add(LanguageSelected(language));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FpText(flag, fontSize: isMobile ? 20 : 24),
          SizedBox(width: isMobile ? 6 : 8),
          Flexible(
            child: FpText(label, fontSize: isMobile ? 16 : 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _GenderSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Column(
      children: [
        _ProgressIndicator(currentIndex: 1),
        SizedBox(height: isMobile ? 24 : 40),
        FpText(l10n.selectGender, fontSize: isMobile ? 24 : 28, fontWeight: FontWeight.bold, color: Colors.black87),
        SizedBox(height: isMobile ? 24 : 40),
        Expanded(
          child: Center(
            child: isMobile
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _GenderButton(gender: Gender.female, isMobile: isMobile),
                      const SizedBox(height: 16),
                      _GenderButton(gender: Gender.male, isMobile: isMobile),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _GenderButton(gender: Gender.female, isMobile: isMobile),
                      const SizedBox(width: 24),
                      _GenderButton(gender: Gender.male, isMobile: isMobile),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}

class _GenderButton extends StatelessWidget {
  final Gender gender;
  final bool isMobile;

  const _GenderButton({required this.gender, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final label = gender == Gender.male ? l10n.genderMale : l10n.genderFemale;

    return SizedBox(
      width: isMobile ? double.infinity : 200,
      height: isMobile ? 80 : 120,
      child: ElevatedButton(
        onPressed: () {
          context.read<AppBloc>().add(GenderSelected(gender));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: FpColor.green,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
        ),
        child: FpText(label, fontSize: isMobile ? 20 : 24, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

class _AgeSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Column(
      children: [
        _ProgressIndicator(currentIndex: 2),
        SizedBox(height: isMobile ? 24 : 40),
        FpText(l10n.selectAge, fontSize: isMobile ? 24 : 28, fontWeight: FontWeight.bold, color: Colors.black87),
        SizedBox(height: isMobile ? 24 : 40),
        Expanded(
          child: GridView.count(
            crossAxisCount: isMobile ? 2 : 3,
            mainAxisSpacing: isMobile ? 12 : 16,
            crossAxisSpacing: isMobile ? 12 : 16,
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            childAspectRatio: isMobile ? 1.1 : 1.2,
            children: [
              _AgeButton(ageGroup: AgeGroup.teens, isMobile: isMobile),
              _AgeButton(ageGroup: AgeGroup.twenties, isMobile: isMobile),
              _AgeButton(ageGroup: AgeGroup.thirties, isMobile: isMobile),
              _AgeButton(ageGroup: AgeGroup.forties, isMobile: isMobile),
              _AgeButton(ageGroup: AgeGroup.fiftiesPlus, isMobile: isMobile),
            ],
          ),
        ),
      ],
    );
  }
}

class _AgeButton extends StatelessWidget {
  final AgeGroup ageGroup;
  final bool isMobile;

  const _AgeButton({required this.ageGroup, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String label;
    switch (ageGroup) {
      case AgeGroup.teens:
        label = l10n.ageTeens;
        break;
      case AgeGroup.twenties:
        label = l10n.ageTwenties;
        break;
      case AgeGroup.thirties:
        label = l10n.ageThirties;
        break;
      case AgeGroup.forties:
        label = l10n.ageForties;
        break;
      case AgeGroup.fiftiesPlus:
        label = l10n.ageFiftiesPlus;
        break;
    }

    return ElevatedButton(
      onPressed: () {
        context.read<AppBloc>().add(AgeSelected(ageGroup));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: FpColor.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 20),
      ),
      child: FpText(label, fontSize: isMobile ? 16 : 18, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}

class _ConcernSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Column(
      children: [
        _ProgressIndicator(currentIndex: 3),
        SizedBox(height: isMobile ? 24 : 40),
        FpText(l10n.selectConcern, fontSize: isMobile ? 24 : 28, fontWeight: FontWeight.bold, color: Colors.black87),
        SizedBox(height: isMobile ? 24 : 40),
        Expanded(
          child: GridView.count(
            crossAxisCount: isMobile ? 2 : 3,
            mainAxisSpacing: isMobile ? 12 : 16,
            crossAxisSpacing: isMobile ? 12 : 16,
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            childAspectRatio: isMobile ? 1.1 : 1.2,
            children: [
              _ConcernButton(concern: Concern.immune, isMobile: isMobile),
              _ConcernButton(concern: Concern.digestive, isMobile: isMobile),
              _ConcernButton(concern: Concern.joint, isMobile: isMobile),
              _ConcernButton(concern: Concern.skin, isMobile: isMobile),
              _ConcernButton(concern: Concern.eye, isMobile: isMobile),
              _ConcernButton(concern: Concern.energy, isMobile: isMobile),
            ],
          ),
        ),
      ],
    );
  }
}

class _ConcernButton extends StatelessWidget {
  final Concern concern;
  final bool isMobile;

  const _ConcernButton({required this.concern, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String label;
    switch (concern) {
      case Concern.immune:
        label = l10n.concernImmune;
        break;
      case Concern.digestive:
        label = l10n.concernDigestive;
        break;
      case Concern.joint:
        label = l10n.concernJoint;
        break;
      case Concern.skin:
        label = l10n.concernSkin;
        break;
      case Concern.eye:
        label = l10n.concernEye;
        break;
      case Concern.energy:
        label = l10n.concernEnergy;
        break;
    }

    return ElevatedButton(
      onPressed: () {
        context.read<AppBloc>().add(ConcernSelected(concern));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: FpColor.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 20),
      ),
      child: FpText(label, fontSize: isMobile ? 16 : 18, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  final int currentIndex;

  const _ProgressIndicator({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Padding(
      padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
      child: Row(
        children: List.generate(4, (index) {
          return Expanded(
            child: Container(
              height: 4,
              margin: EdgeInsets.only(right: index < 3 ? (isMobile ? 6 : 8) : 0),
              decoration: BoxDecoration(color: index <= currentIndex ? FpColor.green : FpColor.lightGray, borderRadius: BorderRadius.circular(2)),
            ),
          );
        }),
      ),
    );
  }
}
