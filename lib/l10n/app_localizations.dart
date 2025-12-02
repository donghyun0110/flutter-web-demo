import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('ko'),
    Locale('zh'),
  ];

  /// No description provided for @selectLanguage.
  ///
  /// In ko, this message translates to:
  /// **'언어를 선택하세요'**
  String get selectLanguage;

  /// No description provided for @selectGender.
  ///
  /// In ko, this message translates to:
  /// **'성별을 선택하세요'**
  String get selectGender;

  /// No description provided for @selectAge.
  ///
  /// In ko, this message translates to:
  /// **'연령대를 선택하세요'**
  String get selectAge;

  /// No description provided for @selectConcern.
  ///
  /// In ko, this message translates to:
  /// **'관심사를 선택하세요'**
  String get selectConcern;

  /// No description provided for @languageKorean.
  ///
  /// In ko, this message translates to:
  /// **'한국어'**
  String get languageKorean;

  /// No description provided for @languageEnglish.
  ///
  /// In ko, this message translates to:
  /// **'영어'**
  String get languageEnglish;

  /// No description provided for @languageJapanese.
  ///
  /// In ko, this message translates to:
  /// **'일본어'**
  String get languageJapanese;

  /// No description provided for @languageChinese.
  ///
  /// In ko, this message translates to:
  /// **'중국어'**
  String get languageChinese;

  /// No description provided for @genderMale.
  ///
  /// In ko, this message translates to:
  /// **'남성'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In ko, this message translates to:
  /// **'여성'**
  String get genderFemale;

  /// No description provided for @ageTeens.
  ///
  /// In ko, this message translates to:
  /// **'10대'**
  String get ageTeens;

  /// No description provided for @ageTwenties.
  ///
  /// In ko, this message translates to:
  /// **'20대'**
  String get ageTwenties;

  /// No description provided for @ageThirties.
  ///
  /// In ko, this message translates to:
  /// **'30대'**
  String get ageThirties;

  /// No description provided for @ageForties.
  ///
  /// In ko, this message translates to:
  /// **'40대'**
  String get ageForties;

  /// No description provided for @ageFiftiesPlus.
  ///
  /// In ko, this message translates to:
  /// **'50대+'**
  String get ageFiftiesPlus;

  /// No description provided for @concernImmune.
  ///
  /// In ko, this message translates to:
  /// **'면역'**
  String get concernImmune;

  /// No description provided for @concernDigestive.
  ///
  /// In ko, this message translates to:
  /// **'소화'**
  String get concernDigestive;

  /// No description provided for @concernJoint.
  ///
  /// In ko, this message translates to:
  /// **'관절'**
  String get concernJoint;

  /// No description provided for @concernSkin.
  ///
  /// In ko, this message translates to:
  /// **'피부'**
  String get concernSkin;

  /// No description provided for @concernEye.
  ///
  /// In ko, this message translates to:
  /// **'눈'**
  String get concernEye;

  /// No description provided for @concernEnergy.
  ///
  /// In ko, this message translates to:
  /// **'에너지'**
  String get concernEnergy;

  /// No description provided for @recommendedIngredients.
  ///
  /// In ko, this message translates to:
  /// **'추천 성분'**
  String get recommendedIngredients;

  /// No description provided for @profileTextEnergy.
  ///
  /// In ko, this message translates to:
  /// **'넘치는 에너지를 원하는 당신!'**
  String get profileTextEnergy;

  /// No description provided for @profileTextImmune.
  ///
  /// In ko, this message translates to:
  /// **'건강한 면역력을 원하는 당신!'**
  String get profileTextImmune;

  /// No description provided for @profileTextDigestive.
  ///
  /// In ko, this message translates to:
  /// **'편안한 소화를 원하는 당신!'**
  String get profileTextDigestive;

  /// No description provided for @searchAgain.
  ///
  /// In ko, this message translates to:
  /// **'다시 검색'**
  String get searchAgain;

  /// No description provided for @curiousAboutProduct.
  ///
  /// In ko, this message translates to:
  /// **'정확한 제품이 궁금하다면?'**
  String get curiousAboutProduct;

  /// No description provided for @scanQRCode.
  ///
  /// In ko, this message translates to:
  /// **'QR 코드를 스캔하거나 연락처를 입력하여 상세 제품 정보를 받아보세요'**
  String get scanQRCode;

  /// No description provided for @saveToSmartphone.
  ///
  /// In ko, this message translates to:
  /// **'스마트폰에 저장'**
  String get saveToSmartphone;

  /// No description provided for @scanQRCodeDescription.
  ///
  /// In ko, this message translates to:
  /// **'이 QR 코드를 스캔하여 모바일에서 맞춤 추천 결과를 확인하세요'**
  String get scanQRCodeDescription;

  /// No description provided for @scanWithCamera.
  ///
  /// In ko, this message translates to:
  /// **'카메라 앱으로 스캔하세요'**
  String get scanWithCamera;

  /// No description provided for @saveResults.
  ///
  /// In ko, this message translates to:
  /// **'결과 저장하기'**
  String get saveResults;

  /// No description provided for @email.
  ///
  /// In ko, this message translates to:
  /// **'이메일'**
  String get email;

  /// No description provided for @phoneNumber.
  ///
  /// In ko, this message translates to:
  /// **'전화번호'**
  String get phoneNumber;

  /// No description provided for @enterEmailAddress.
  ///
  /// In ko, this message translates to:
  /// **'이메일 주소 입력'**
  String get enterEmailAddress;

  /// No description provided for @sendResults.
  ///
  /// In ko, this message translates to:
  /// **'결과 보내기'**
  String get sendResults;

  /// No description provided for @vitaminBComplexTitle.
  ///
  /// In ko, this message translates to:
  /// **'비타민 B 복합체'**
  String get vitaminBComplexTitle;

  /// No description provided for @vitaminBComplexDescription.
  ///
  /// In ko, this message translates to:
  /// **'음식을 에너지로 전환하는 비타민 B군입니다'**
  String get vitaminBComplexDescription;

  /// No description provided for @vitaminBComplexBenefit1.
  ///
  /// In ko, this message translates to:
  /// **'에너지 생산'**
  String get vitaminBComplexBenefit1;

  /// No description provided for @vitaminBComplexBenefit2.
  ///
  /// In ko, this message translates to:
  /// **'신진대사'**
  String get vitaminBComplexBenefit2;

  /// No description provided for @vitaminBComplexBenefit3.
  ///
  /// In ko, this message translates to:
  /// **'정신 명료'**
  String get vitaminBComplexBenefit3;

  /// No description provided for @coenzymeQ10Title.
  ///
  /// In ko, this message translates to:
  /// **'코엔자임 Q10'**
  String get coenzymeQ10Title;

  /// No description provided for @coenzymeQ10Description.
  ///
  /// In ko, this message translates to:
  /// **'세포 에너지 생산을 돕고 피로를 줄입니다'**
  String get coenzymeQ10Description;

  /// No description provided for @coenzymeQ10Benefit1.
  ///
  /// In ko, this message translates to:
  /// **'에너지 증진'**
  String get coenzymeQ10Benefit1;

  /// No description provided for @coenzymeQ10Benefit2.
  ///
  /// In ko, this message translates to:
  /// **'심장 건강'**
  String get coenzymeQ10Benefit2;

  /// No description provided for @coenzymeQ10Benefit3.
  ///
  /// In ko, this message translates to:
  /// **'항산화'**
  String get coenzymeQ10Benefit3;

  /// No description provided for @ironTitle.
  ///
  /// In ko, this message translates to:
  /// **'철분'**
  String get ironTitle;

  /// No description provided for @ironDescription.
  ///
  /// In ko, this message translates to:
  /// **'산소 운반과 에너지 수준에 필수적인 미네랄입니다'**
  String get ironDescription;

  /// No description provided for @ironBenefit1.
  ///
  /// In ko, this message translates to:
  /// **'에너지 수준'**
  String get ironBenefit1;

  /// No description provided for @ironBenefit2.
  ///
  /// In ko, this message translates to:
  /// **'산소 운반'**
  String get ironBenefit2;

  /// No description provided for @ironBenefit3.
  ///
  /// In ko, this message translates to:
  /// **'피로 감소'**
  String get ironBenefit3;

  /// No description provided for @area.
  ///
  /// In ko, this message translates to:
  /// **'구역'**
  String get area;

  /// No description provided for @shelf.
  ///
  /// In ko, this message translates to:
  /// **'번 선반'**
  String get shelf;

  /// No description provided for @loading.
  ///
  /// In ko, this message translates to:
  /// **'로딩 중...'**
  String get loading;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'ko', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
