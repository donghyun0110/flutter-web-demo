import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/app_bloc.dart';
import '../bloc/app_state.dart';
import '../models/user_profile.dart';
import 'fp_text.dart';
import 'fp_color.dart';

class LoadingStep extends StatelessWidget {
  const LoadingStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, Language?>(
      selector: (state) => state.userProfile.language,
      builder: (context, language) {
        String loadingText = '로딩 중...';
        if (language == Language.english) {
          loadingText = 'Loading...';
        } else if (language == Language.japanese) {
          loadingText = '読み込み中...';
        } else if (language == Language.chinese) {
          loadingText = '加载中...';
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(FpColor.green),
                strokeWidth: 4,
              ),
              const SizedBox(height: 24),
              FpText(
                loadingText,
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ],
          ),
        );
      },
    );
  }
}

