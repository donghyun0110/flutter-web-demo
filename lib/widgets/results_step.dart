import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_test/l10n/app_localizations.dart';
import 'dart:html' as html;
import '../bloc/app_bloc.dart';
import '../bloc/app_event.dart';
import '../bloc/app_state.dart';
import '../models/user_profile.dart';
import 'fp_text.dart';
import 'fp_color.dart';

class ResultsStep extends StatelessWidget {
  const ResultsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, UserProfile>(
      selector: (state) => state.userProfile,
      builder: (context, userProfile) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _RecommendationsSection(userProfile: userProfile)),
              const SizedBox(width: 24),
              Expanded(flex: 1, child: _ActionsSection(userProfile: userProfile)),
            ],
          ),
        );
      },
    );
  }
}

class _RecommendationsSection extends StatelessWidget {
  final UserProfile userProfile;

  const _RecommendationsSection({required this.userProfile});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    String profileText = l10n.profileTextEnergy;
    if (userProfile.concern == Concern.immune) {
      profileText = l10n.profileTextImmune;
    } else if (userProfile.concern == Concern.digestive) {
      profileText = l10n.profileTextDigestive;
    }

    String languageText = '';
    if (userProfile.language != null) {
      switch (userProfile.language!) {
        case Language.korean:
          languageText = l10n.languageKorean;
          break;
        case Language.english:
          languageText = l10n.languageEnglish;
          break;
        case Language.japanese:
          languageText = l10n.languageJapanese;
          break;
        case Language.chinese:
          languageText = l10n.languageChinese;
          break;
      }
    }

    String genderText = '';
    if (userProfile.gender != null) {
      genderText = userProfile.gender == Gender.male ? l10n.genderMale : l10n.genderFemale;
    }

    String ageText = '';
    if (userProfile.ageGroup != null) {
      switch (userProfile.ageGroup!) {
        case AgeGroup.teens:
          ageText = l10n.ageTeens;
          break;
        case AgeGroup.twenties:
          ageText = l10n.ageTwenties;
          break;
        case AgeGroup.thirties:
          ageText = l10n.ageThirties;
          break;
        case AgeGroup.forties:
          ageText = l10n.ageForties;
          break;
        case AgeGroup.fiftiesPlus:
          ageText = l10n.ageFiftiesPlus;
          break;
      }
    }

    String concernText = '';
    if (userProfile.concern != null) {
      switch (userProfile.concern!) {
        case Concern.immune:
          concernText = l10n.concernImmune;
          break;
        case Concern.digestive:
          concernText = l10n.concernDigestive;
          break;
        case Concern.joint:
          concernText = l10n.concernJoint;
          break;
        case Concern.skin:
          concernText = l10n.concernSkin;
          break;
        case Concern.eye:
          concernText = l10n.concernEye;
          break;
        case Concern.energy:
          concernText = l10n.concernEnergy;
          break;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FpText(l10n.recommendedIngredients, fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
        const SizedBox(height: 24),
        FpText(profileText, fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black87),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if (languageText.isNotEmpty) _TagChip(languageText),
            if (genderText.isNotEmpty) _TagChip(genderText),
            if (ageText.isNotEmpty) _TagChip(ageText),
            if (concernText.isNotEmpty) _TagChip(concernText),
          ],
        ),
        const SizedBox(height: 32),
        Column(
          children: [
            _IngredientCard(
              title: l10n.vitaminBComplexTitle,
              icon: '💊',
              description: l10n.vitaminBComplexDescription,
              benefits: [l10n.vitaminBComplexBenefit1, l10n.vitaminBComplexBenefit2, l10n.vitaminBComplexBenefit3],
              location: '${l10n.area} G',
              shelf: '${l10n.shelf} 1-5',
            ),
            const SizedBox(height: 16),
            _IngredientCard(
              title: l10n.coenzymeQ10Title,
              icon: '❤️',
              description: l10n.coenzymeQ10Description,
              benefits: [l10n.coenzymeQ10Benefit1, l10n.coenzymeQ10Benefit2, l10n.coenzymeQ10Benefit3],
              location: '${l10n.area} G',
              shelf: '${l10n.shelf} 6-9',
            ),
            const SizedBox(height: 16),
            _IngredientCard(
              title: l10n.ironTitle,
              icon: '🩸',
              description: l10n.ironDescription,
              benefits: [l10n.ironBenefit1, l10n.ironBenefit2, l10n.ironBenefit3],
              location: '${l10n.area} B',
              shelf: '${l10n.shelf} 5-7',
            ),
          ],
        ),
      ],
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;

  const _TagChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: FpColor.lightGreen, borderRadius: BorderRadius.circular(16)),
      child: FpText(label, fontSize: 14, color: FpColor.green),
    );
  }
}

class _IngredientCard extends StatelessWidget {
  final String title;
  final String icon;
  final String description;
  final List<String> benefits;
  final String location;
  final String shelf;

  const _IngredientCard({required this.title, required this.icon, required this.description, required this.benefits, required this.location, required this.shelf});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FpText(icon, fontSize: 24),
              const SizedBox(width: 12),
              Expanded(
                child: FpText(title, fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: FpColor.green, borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    FpText(location, fontSize: 12, color: Colors.white),
                    FpText(shelf, fontSize: 12, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          FpText(description, fontSize: 16, color: Colors.black87),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: FpColor.lightGreen, borderRadius: BorderRadius.circular(8)),
            child: Wrap(spacing: 8, runSpacing: 8, children: benefits.map((benefit) => FpText(benefit, fontSize: 14, color: FpColor.green)).toList()),
          ),
        ],
      ),
    );
  }
}

class _ActionsSection extends StatelessWidget {
  final UserProfile userProfile;

  const _ActionsSection({required this.userProfile});

  String _generateMobileUrl(UserProfile userProfile) {
    final origin = html.window.location.origin;
    final pathname = html.window.location.pathname ?? '/';
    final baseUrl = origin + (pathname.isEmpty ? '/' : pathname);
    final params = <String, String>{'view': 'mobile'};

    if (userProfile.language != null) {
      switch (userProfile.language!) {
        case Language.korean:
          params['lang'] = 'Korean';
          break;
        case Language.english:
          params['lang'] = 'English';
          break;
        case Language.japanese:
          params['lang'] = 'Japanese';
          break;
        case Language.chinese:
          params['lang'] = 'Chinese';
          break;
      }
    }

    if (userProfile.gender != null) {
      params['gender'] = userProfile.gender == Gender.male ? 'Male' : 'Female';
    }

    if (userProfile.ageGroup != null) {
      switch (userProfile.ageGroup!) {
        case AgeGroup.teens:
          params['age'] = '10s';
          break;
        case AgeGroup.twenties:
          params['age'] = '20s';
          break;
        case AgeGroup.thirties:
          params['age'] = '30s';
          break;
        case AgeGroup.forties:
          params['age'] = '40s';
          break;
        case AgeGroup.fiftiesPlus:
          params['age'] = '50s+';
          break;
      }
    }

    if (userProfile.concern != null) {
      switch (userProfile.concern!) {
        case Concern.immune:
          params['concern'] = 'Immune';
          break;
        case Concern.digestive:
          params['concern'] = 'Digestive';
          break;
        case Concern.joint:
          params['concern'] = 'Joint';
          break;
        case Concern.skin:
          params['concern'] = 'Skin';
          break;
        case Concern.eye:
          params['concern'] = 'Eye';
          break;
        case Concern.energy:
          params['concern'] = 'Energy';
          break;
      }
    }

    final queryString = params.entries.map((e) => '${e.key}=${e.value}').join('&');
    return '$baseUrl?$queryString';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            context.read<AppBloc>().add(const ResetApp());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: FpColor.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: FpText(l10n.searchAgain, fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FpText(l10n.curiousAboutProduct, fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              const SizedBox(height: 12),
              FpText(l10n.scanQRCode, fontSize: 14, color: Colors.black87),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FpText(l10n.saveToSmartphone, fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              const SizedBox(height: 12),
              FpText(l10n.scanQRCodeDescription, fontSize: 14, color: Colors.black87),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      color: Colors.black,
                      child: const Center(child: FpText('QR Code', fontSize: 16, color: Colors.white)),
                    ),
                    const SizedBox(height: 12),
                    FpText(l10n.scanWithCamera, fontSize: 12, color: Colors.grey, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        final url = _generateMobileUrl(userProfile);
                        html.window.open(url, '_blank');
                      },
                      icon: const Icon(Icons.open_in_new, size: 16),
                      label: const FpText('모바일 링크 열기', fontSize: 12, color: Colors.white),
                      style: ElevatedButton.styleFrom(backgroundColor: FpColor.blue, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      _generateMobileUrl(userProfile),
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FpText(l10n.saveResults, fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: FpColor.blue, width: 2)),
                      ),
                      child: FpText(l10n.email, fontSize: 14, fontWeight: FontWeight.bold, color: FpColor.blue, textAlign: TextAlign.center),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: FpText(l10n.phoneNumber, fontSize: 14, color: Colors.grey, textAlign: TextAlign.center),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: l10n.enterEmailAddress,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FpColor.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: FpText(l10n.sendResults, fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
