import 'package:flutter/material.dart';
import 'package:flutter_web_test/l10n/app_localizations.dart';
import 'fp_text.dart';
import 'fp_color.dart';

class LoadingStep extends StatelessWidget {
  const LoadingStep({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
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
            l10n.loading,
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ],
      ),
    );
  }
}

