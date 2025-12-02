import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          Expanded(
            flex: 2,
            child: _RecommendationsSection(userProfile: userProfile),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 1,
            child: _ActionsSection(),
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

  const _RecommendationsSection({required this.userProfile});

  String _getProfileText() {
    String text = '넘치는 에너지를 원하는 당신!';
    if (userProfile.concern == Concern.energy) {
      text = '넘치는 에너지를 원하는 당신!';
    } else if (userProfile.concern == Concern.immune) {
      text = '건강한 면역력을 원하는 당신!';
    } else if (userProfile.concern == Concern.digestive) {
      text = '편안한 소화를 원하는 당신!';
    }
    return text;
  }

  String _getLanguageText() {
    switch (userProfile.language) {
      case Language.korean:
        return '한국어';
      case Language.english:
        return 'English';
      case Language.japanese:
        return '日本語';
      case Language.chinese:
        return '中文';
      default:
        return '한국어';
    }
  }

  String _getGenderText() {
    switch (userProfile.gender) {
      case Gender.male:
        return '남성';
      case Gender.female:
        return '여성';
      default:
        return '';
    }
  }

  String _getAgeText() {
    switch (userProfile.ageGroup) {
      case AgeGroup.teens:
        return '10대';
      case AgeGroup.twenties:
        return '20대';
      case AgeGroup.thirties:
        return '30대';
      case AgeGroup.forties:
        return '40대';
      case AgeGroup.fiftiesPlus:
        return '50대+';
      default:
        return '';
    }
  }

  String _getConcernText() {
    switch (userProfile.concern) {
      case Concern.energy:
        return '에너지';
      case Concern.immune:
        return '면역';
      case Concern.digestive:
        return '소화';
      case Concern.joint:
        return '관절';
      case Concern.skin:
        return '피부';
      case Concern.eye:
        return '눈';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FpText(
          '추천 성분',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        const SizedBox(height: 24),
        FpText(
          _getProfileText(),
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _TagChip(_getLanguageText()),
            if (userProfile.gender != null) _TagChip(_getGenderText()),
            if (userProfile.ageGroup != null) _TagChip(_getAgeText()),
            if (userProfile.concern != null) _TagChip(_getConcernText()),
          ],
        ),
        const SizedBox(height: 32),
        Column(
          children: [
            _IngredientCard(
              title: '비타민 B 복합체',
              icon: '💊',
              description: '음식을 에너지로 전환하는 비타민 B군입니다',
              benefits: ['에너지 생산', '신진대사', '정신 명료'],
              location: '구역 G',
              shelf: '번 선반 1-5',
            ),
            const SizedBox(height: 16),
            _IngredientCard(
              title: '코엔자임 Q10',
              icon: '❤️',
              description: '세포 에너지 생산을 돕고 피로를 줄입니다',
              benefits: ['에너지 증진', '심장 건강', '항산화'],
              location: '구역 G',
              shelf: '번 선반 6-9',
            ),
            const SizedBox(height: 16),
            _IngredientCard(
              title: '철분',
              icon: '🩸',
              description: '산소 운반과 에너지 수준에 필수적인 미네랄입니다',
              benefits: ['에너지 수준', '산소 운반', '피로 감소'],
              location: '구역 B',
              shelf: '번 선반 5-7',
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
      decoration: BoxDecoration(
        color: FpColor.lightGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: FpText(
        label,
        fontSize: 14,
        color: FpColor.green,
      ),
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

  const _IngredientCard({
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FpText(icon, fontSize: 24),
              const SizedBox(width: 12),
              Expanded(
                child: FpText(
                  title,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: FpColor.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    FpText(
                      location,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                    FpText(
                      shelf,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          FpText(
            description,
            fontSize: 16,
            color: Colors.black87,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: FpColor.lightGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: benefits
                  .map((benefit) => FpText(
                        benefit,
                        fontSize: 14,
                        color: FpColor.green,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const FpText(
            '다시 검색',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FpText(
                '정확한 제품이 궁금하다면?',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              const SizedBox(height: 12),
              FpText(
                'QR 코드를 스캔하거나 연락처를 입력하여 상세 제품 정보를 받아보세요',
                fontSize: 14,
                color: Colors.black87,
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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FpText(
                '스마트폰에 저장',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              const SizedBox(height: 12),
              FpText(
                '이 QR 코드를 스캔하여 모바일에서 맞춤 추천 결과를 확인하세요',
                fontSize: 14,
                color: Colors.black87,
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      color: Colors.black,
                      child: const Center(
                        child: FpText(
                          'QR Code',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const FpText(
                      '카메라 앱으로 스캔하세요',
                      fontSize: 12,
                      color: Colors.grey,
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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FpText(
                '결과 저장하기',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: FpColor.blue, width: 2),
                        ),
                      ),
                      child: const FpText(
                        '이메일',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: FpColor.blue,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const FpText(
                        '전화번호',
                        fontSize: 14,
                        color: Colors.grey,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: '이메일 주소 입력',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const FpText(
                    '결과 보내기',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

