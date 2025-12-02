import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Column(
      children: [
        _ProgressIndicator(currentIndex: 0),
        const SizedBox(height: 40),
        FpText(
          '언어를 선택하세요',
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        const SizedBox(height: 40),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            padding: const EdgeInsets.all(24),
            childAspectRatio: 1.5,
            children: [
              _LanguageButton(
                language: Language.korean,
                label: '한국어',
                color: FpColor.green,
                flag: '🇰🇷',
              ),
              _LanguageButton(
                language: Language.english,
                label: 'English',
                color: FpColor.blue,
                flag: '🇺🇸',
              ),
              _LanguageButton(
                language: Language.japanese,
                label: '日本語',
                color: FpColor.red,
                flag: '🇯🇵',
              ),
              _LanguageButton(
                language: Language.chinese,
                label: '中文',
                color: FpColor.yellow,
                flag: '🇨🇳',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final Language language;
  final String label;
  final Color color;
  final String flag;

  const _LanguageButton({
    required this.language,
    required this.label,
    required this.color,
    required this.flag,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<AppBloc>().add(LanguageSelected(language));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FpText(flag, fontSize: 24),
          const SizedBox(width: 8),
          FpText(
            label,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class _GenderSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProgressIndicator(currentIndex: 1),
        const SizedBox(height: 40),
        FpText(
          '성별을 선택하세요',
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        const SizedBox(height: 40),
        Expanded(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _GenderButton(
                  gender: Gender.female,
                  label: '여성',
                ),
                const SizedBox(width: 24),
                _GenderButton(
                  gender: Gender.male,
                  label: '남성',
                ),
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
  final String label;

  const _GenderButton({
    required this.gender,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 120,
      child: ElevatedButton(
        onPressed: () {
          context.read<AppBloc>().add(GenderSelected(gender));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: FpColor.green,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: FpText(
          label,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _AgeSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProgressIndicator(currentIndex: 2),
        const SizedBox(height: 40),
        FpText(
          '연령대를 선택하세요',
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        const SizedBox(height: 40),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            padding: const EdgeInsets.all(24),
            childAspectRatio: 1.2,
            children: [
              _AgeButton(ageGroup: AgeGroup.teens, label: '10대'),
              _AgeButton(ageGroup: AgeGroup.twenties, label: '20대'),
              _AgeButton(ageGroup: AgeGroup.thirties, label: '30대'),
              _AgeButton(ageGroup: AgeGroup.forties, label: '40대'),
              _AgeButton(ageGroup: AgeGroup.fiftiesPlus, label: '50대+'),
            ],
          ),
        ),
      ],
    );
  }
}

class _AgeButton extends StatelessWidget {
  final AgeGroup ageGroup;
  final String label;

  const _AgeButton({
    required this.ageGroup,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<AppBloc>().add(AgeSelected(ageGroup));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: FpColor.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
      child: FpText(
        label,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

class _ConcernSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProgressIndicator(currentIndex: 3),
        const SizedBox(height: 40),
        FpText(
          '관심사를 선택하세요',
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        const SizedBox(height: 40),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            padding: const EdgeInsets.all(24),
            childAspectRatio: 1.2,
            children: [
              _ConcernButton(concern: Concern.immune, label: '면역'),
              _ConcernButton(concern: Concern.digestive, label: '소화'),
              _ConcernButton(concern: Concern.joint, label: '관절'),
              _ConcernButton(concern: Concern.skin, label: '피부'),
              _ConcernButton(concern: Concern.eye, label: '눈'),
              _ConcernButton(concern: Concern.energy, label: '에너지'),
            ],
          ),
        ),
      ],
    );
  }
}

class _ConcernButton extends StatelessWidget {
  final Concern concern;
  final String label;

  const _ConcernButton({
    required this.concern,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<AppBloc>().add(ConcernSelected(concern));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: FpColor.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
      child: FpText(
        label,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  final int currentIndex;

  const _ProgressIndicator({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: List.generate(4, (index) {
          return Expanded(
            child: Container(
              height: 4,
              margin: EdgeInsets.only(right: index < 3 ? 8 : 0),
              decoration: BoxDecoration(
                color: index <= currentIndex
                    ? FpColor.green
                    : FpColor.lightGray,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }
}

