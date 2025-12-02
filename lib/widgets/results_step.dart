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
    final isMobile = MediaQuery.of(context).size.width < 768;

    return BlocSelector<AppBloc, AppState, UserProfile>(
      selector: (state) => state.userProfile,
      builder: (context, userProfile) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16 : 24),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _RecommendationsSection(userProfile: userProfile, isMobile: isMobile),
                    const SizedBox(height: 24),
                    _ActionsSection(userProfile: userProfile, isMobile: isMobile),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _RecommendationsSection(userProfile: userProfile, isMobile: isMobile),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 1,
                      child: _ActionsSection(userProfile: userProfile, isMobile: isMobile),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _RecommendationsSection extends StatelessWidget {
  final UserProfile userProfile;
  final bool isMobile;

  const _RecommendationsSection({required this.userProfile, required this.isMobile});

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
        FpText(l10n.recommendedIngredients, fontSize: isMobile ? 24 : 32, fontWeight: FontWeight.bold, color: Colors.black87),
        SizedBox(height: isMobile ? 16 : 24),
        FpText(profileText, fontSize: isMobile ? 18 : 20, fontWeight: FontWeight.w500, color: Colors.black87),
        SizedBox(height: isMobile ? 12 : 16),
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
        SizedBox(height: isMobile ? 24 : 32),
        Column(
          children: [
            _IngredientCard(
              title: l10n.vitaminBComplexTitle,
              icon: '💊',
              description: l10n.vitaminBComplexDescription,
              benefits: [l10n.vitaminBComplexBenefit1, l10n.vitaminBComplexBenefit2, l10n.vitaminBComplexBenefit3],
              location: '${l10n.area} G',
              shelf: '${l10n.shelf} 1-5',
              isMobile: isMobile,
            ),
            SizedBox(height: isMobile ? 12 : 16),
            _IngredientCard(
              title: l10n.coenzymeQ10Title,
              icon: '❤️',
              description: l10n.coenzymeQ10Description,
              benefits: [l10n.coenzymeQ10Benefit1, l10n.coenzymeQ10Benefit2, l10n.coenzymeQ10Benefit3],
              location: '${l10n.area} G',
              shelf: '${l10n.shelf} 6-9',
              isMobile: isMobile,
            ),
            SizedBox(height: isMobile ? 12 : 16),
            _IngredientCard(
              title: l10n.ironTitle,
              icon: '🩸',
              description: l10n.ironDescription,
              benefits: [l10n.ironBenefit1, l10n.ironBenefit2, l10n.ironBenefit3],
              location: '${l10n.area} B',
              shelf: '${l10n.shelf} 5-7',
              isMobile: isMobile,
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
  final bool isMobile;

  const _IngredientCard({
    required this.title,
    required this.icon,
    required this.description,
    required this.benefits,
    required this.location,
    required this.shelf,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
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
              FpText(icon, fontSize: isMobile ? 20 : 24),
              SizedBox(width: isMobile ? 8 : 12),
              Expanded(
                child: FpText(title, fontSize: isMobile ? 18 : 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12, vertical: isMobile ? 4 : 6),
                decoration: BoxDecoration(color: FpColor.green, borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    FpText(location, fontSize: isMobile ? 10 : 12, color: Colors.white),
                    FpText(shelf, fontSize: isMobile ? 10 : 12, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 10 : 12),
          FpText(description, fontSize: isMobile ? 14 : 16, color: Colors.black87),
          SizedBox(height: isMobile ? 10 : 12),
          Container(
            padding: EdgeInsets.all(isMobile ? 10 : 12),
            decoration: BoxDecoration(color: FpColor.lightGreen, borderRadius: BorderRadius.circular(8)),
            child: Wrap(
              spacing: isMobile ? 6 : 8,
              runSpacing: isMobile ? 6 : 8,
              children: benefits.map((benefit) => FpText(benefit, fontSize: isMobile ? 12 : 14, color: FpColor.green)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionsSection extends StatelessWidget {
  final UserProfile userProfile;
  final bool isMobile;

  const _ActionsSection({required this.userProfile, required this.isMobile});

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
        SizedBox(
          width: isMobile ? double.infinity : null,
          child: ElevatedButton(
            onPressed: () {
              context.read<AppBloc>().add(const ResetApp());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: FpColor.green,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 24, vertical: isMobile ? 14 : 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: FpText(l10n.searchAgain, fontSize: isMobile ? 16 : 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(height: isMobile ? 24 : 32),
        Container(
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FpText(l10n.curiousAboutProduct, fontSize: isMobile ? 16 : 18, fontWeight: FontWeight.bold, color: Colors.black87),
              SizedBox(height: isMobile ? 10 : 12),
              FpText(l10n.scanQRCode, fontSize: isMobile ? 13 : 14, color: Colors.black87),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 16 : 24),
        Container(
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FpText(l10n.saveToSmartphone, fontSize: isMobile ? 16 : 18, fontWeight: FontWeight.bold, color: Colors.black87),
              SizedBox(height: isMobile ? 10 : 12),
              FpText(l10n.scanQRCodeDescription, fontSize: isMobile ? 13 : 14, color: Colors.black87),
              SizedBox(height: isMobile ? 16 : 20),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: isMobile ? 150 : 200,
                      height: isMobile ? 150 : 200,
                      color: Colors.black,
                      child: Center(
                        child: FpText('QR Code', fontSize: isMobile ? 14 : 16, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: isMobile ? 10 : 12),
                    FpText(l10n.scanWithCamera, fontSize: isMobile ? 11 : 12, color: Colors.grey, textAlign: TextAlign.center),
                    SizedBox(height: isMobile ? 12 : 16),
                    SizedBox(
                      width: isMobile ? double.infinity : null,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final url = _generateMobileUrl(userProfile);
                          html.window.open(url, '_blank');
                        },
                        icon: Icon(Icons.open_in_new, size: isMobile ? 14 : 16),
                        label: FpText('모바일 링크 열기', fontSize: isMobile ? 11 : 12, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: FpColor.blue,
                          padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 12, vertical: isMobile ? 10 : 8),
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 6 : 8),
                    SelectableText(
                      _generateMobileUrl(userProfile),
                      style: TextStyle(fontSize: isMobile ? 9 : 10, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 16 : 24),
        Container(
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FpText(l10n.saveResults, fontSize: isMobile ? 16 : 18, fontWeight: FontWeight.bold, color: Colors.black87),
              SizedBox(height: isMobile ? 12 : 16),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: FpColor.blue, width: 2)),
                      ),
                      child: FpText(l10n.email, fontSize: isMobile ? 13 : 14, fontWeight: FontWeight.bold, color: FpColor.blue, textAlign: TextAlign.center),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: FpText(l10n.phoneNumber, fontSize: isMobile ? 13 : 14, color: Colors.grey, textAlign: TextAlign.center),
                    ),
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 12 : 16),
              TextField(
                decoration: InputDecoration(
                  hintText: l10n.enterEmailAddress,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 12, vertical: isMobile ? 14 : 12),
                ),
              ),
              SizedBox(height: isMobile ? 12 : 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FpColor.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: isMobile ? 14 : 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: FpText(l10n.sendResults, fontSize: isMobile ? 15 : 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
