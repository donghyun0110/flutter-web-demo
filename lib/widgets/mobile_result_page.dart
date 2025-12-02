import 'package:flutter/material.dart';
import 'package:flutter_web_test/l10n/app_localizations.dart';
import 'package:flutter_web_test/models/user_profile.dart';
import 'fp_text.dart';
import 'fp_color.dart';

class MobileResultPage extends StatelessWidget {
  final UserProfile userProfile;
  final Function(Map<String, dynamic>)? onProfileUpdate;

  const MobileResultPage({
    super.key,
    required this.userProfile,
    this.onProfileUpdate,
  });

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

    return Scaffold(
      backgroundColor: FpColor.emerald50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              FpText(
                l10n.recommendedIngredients,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              const SizedBox(height: 16),
              FpText(
                profileText,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              const SizedBox(height: 16),
              // Tags
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
              const SizedBox(height: 24),
              // Ingredient Cards
              _MobileIngredientCard(
                title: l10n.vitaminBComplexTitle,
                icon: '💊',
                description: l10n.vitaminBComplexDescription,
                benefits: [
                  l10n.vitaminBComplexBenefit1,
                  l10n.vitaminBComplexBenefit2,
                  l10n.vitaminBComplexBenefit3,
                ],
                location: '${l10n.area} G',
                shelf: '${l10n.shelf} 1-5',
              ),
              const SizedBox(height: 16),
              _MobileIngredientCard(
                title: l10n.coenzymeQ10Title,
                icon: '❤️',
                description: l10n.coenzymeQ10Description,
                benefits: [
                  l10n.coenzymeQ10Benefit1,
                  l10n.coenzymeQ10Benefit2,
                  l10n.coenzymeQ10Benefit3,
                ],
                location: '${l10n.area} G',
                shelf: '${l10n.shelf} 6-9',
              ),
              const SizedBox(height: 16),
              _MobileIngredientCard(
                title: l10n.ironTitle,
                icon: '🩸',
                description: l10n.ironDescription,
                benefits: [
                  l10n.ironBenefit1,
                  l10n.ironBenefit2,
                  l10n.ironBenefit3,
                ],
                location: '${l10n.area} B',
                shelf: '${l10n.shelf} 5-7',
              ),
            ],
          ),
        ),
      ),
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

class _MobileIngredientCard extends StatelessWidget {
  final String title;
  final String icon;
  final String description;
  final List<String> benefits;
  final String location;
  final String shelf;

  const _MobileIngredientCard({
    required this.title,
    required this.icon,
    required this.description,
    required this.benefits,
    required this.location,
    required this.shelf,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
                child: FpText(title, fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: FpColor.green, borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    FpText(location, fontSize: 11, color: Colors.white),
                    FpText(shelf, fontSize: 11, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          FpText(description, fontSize: 14, color: Colors.black87),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: FpColor.lightGreen, borderRadius: BorderRadius.circular(8)),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: benefits.map((benefit) => FpText(benefit, fontSize: 12, color: FpColor.green)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

