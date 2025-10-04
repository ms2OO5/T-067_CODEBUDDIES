import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_pa.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('pa')
  ];

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get chooseLanguage;

  /// No description provided for @selectPreferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language below.'**
  String get selectPreferredLanguage;

  /// No description provided for @youSelected.
  ///
  /// In en, this message translates to:
  /// **'You Selected'**
  String get youSelected;

  /// No description provided for @availableLanguages.
  ///
  /// In en, this message translates to:
  /// **'Available Languages'**
  String get availableLanguages;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next ->'**
  String get next;

  /// No description provided for @appname.
  ///
  /// In en, this message translates to:
  /// **'MY MITRA'**
  String get appname;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get continueAsGuest;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @mitraAi.
  ///
  /// In en, this message translates to:
  /// **'Mitra AI'**
  String get mitraAi;

  /// No description provided for @financialTools.
  ///
  /// In en, this message translates to:
  /// **'M. Tools'**
  String get financialTools;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get enterEmail;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @loginHeading.
  ///
  /// In en, this message translates to:
  /// **'Your digital banking buddy\nsafe, smart and always by your side.'**
  String get loginHeading;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found in database.'**
  String get userNotFound;

  /// No description provided for @incorrectEmailOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password'**
  String get incorrectEmailOrPassword;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get invalidEmail;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email (Required)'**
  String get emailRequired;

  /// No description provided for @phoneOptional.
  ///
  /// In en, this message translates to:
  /// **'Phone Number (Optional)'**
  String get phoneOptional;

  /// No description provided for @fieldsRequired.
  ///
  /// In en, this message translates to:
  /// **'Name, Email & Password are required'**
  String get fieldsRequired;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get registrationFailed;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get unexpectedError;

  /// No description provided for @alreadyAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyAccount;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered email; we’ll send you a reset link.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailHint;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @resetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'✅ A password‑reset link has been sent to {email}. Check your inbox.'**
  String resetLinkSent(Object email);

  /// No description provided for @noUserFound.
  ///
  /// In en, this message translates to:
  /// **'No user found with that email.'**
  String get noUserFound;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @mshield.
  ///
  /// In en, this message translates to:
  /// **'M-Shield'**
  String get mshield;

  /// No description provided for @vault.
  ///
  /// In en, this message translates to:
  /// **'M.Vault'**
  String get vault;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @fraudInfo.
  ///
  /// In en, this message translates to:
  /// **'Fraud Info'**
  String get fraudInfo;

  /// No description provided for @govtPolicies.
  ///
  /// In en, this message translates to:
  /// **'Govt Policies'**
  String get govtPolicies;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @funZone.
  ///
  /// In en, this message translates to:
  /// **'Fun Zone'**
  String get funZone;

  /// No description provided for @quizSection.
  ///
  /// In en, this message translates to:
  /// **'Quiz Section'**
  String get quizSection;

  /// No description provided for @dailyChallenges.
  ///
  /// In en, this message translates to:
  /// **'Daily Challenges'**
  String get dailyChallenges;

  /// No description provided for @rewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewards;

  /// No description provided for @cashbacks.
  ///
  /// In en, this message translates to:
  /// **'Cashbacks'**
  String get cashbacks;

  /// No description provided for @giftCards.
  ///
  /// In en, this message translates to:
  /// **'Gift Cards'**
  String get giftCards;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @intro.
  ///
  /// In en, this message translates to:
  /// **'👋 Hello {name}! I\'m your banking buddy 🤖. How can I help?'**
  String intro(Object name);

  /// No description provided for @typing.
  ///
  /// In en, this message translates to:
  /// **'Typing...'**
  String get typing;

  /// No description provided for @listening.
  ///
  /// In en, this message translates to:
  /// **'Listening...'**
  String get listening;

  /// No description provided for @refresh_chat.
  ///
  /// In en, this message translates to:
  /// **'🔄 Refresh Chat'**
  String get refresh_chat;

  /// No description provided for @report_problem.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Report Problem'**
  String get report_problem;

  /// No description provided for @report_submitted.
  ///
  /// In en, this message translates to:
  /// **'Report submitted!'**
  String get report_submitted;

  /// No description provided for @ask_something.
  ///
  /// In en, this message translates to:
  /// **'Ask Something... 💬'**
  String get ask_something;

  /// No description provided for @failed_response.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Failed to get response.'**
  String get failed_response;

  /// No description provided for @default_reply.
  ///
  /// In en, this message translates to:
  /// **'Sorry, I didn\'t understand.'**
  String get default_reply;

  /// No description provided for @financeTools.
  ///
  /// In en, this message translates to:
  /// **'Finance Tools'**
  String get financeTools;

  /// No description provided for @currencyConverter.
  ///
  /// In en, this message translates to:
  /// **'Currency Converter'**
  String get currencyConverter;

  /// No description provided for @interestCalculator.
  ///
  /// In en, this message translates to:
  /// **'Interest Calculator'**
  String get interestCalculator;

  /// No description provided for @emiCalculator.
  ///
  /// In en, this message translates to:
  /// **'EMI Calculator'**
  String get emiCalculator;

  /// No description provided for @discountCalculator.
  ///
  /// In en, this message translates to:
  /// **'Discount Calculator'**
  String get discountCalculator;

  /// No description provided for @allLanguages.
  ///
  /// In en, this message translates to:
  /// **'All Languages'**
  String get allLanguages;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @manageAccounts.
  ///
  /// In en, this message translates to:
  /// **'Manage Accounts'**
  String get manageAccounts;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @supportAndAbout.
  ///
  /// In en, this message translates to:
  /// **'Support & About'**
  String get supportAndAbout;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @termsPolicies.
  ///
  /// In en, this message translates to:
  /// **'Terms and Policies'**
  String get termsPolicies;

  /// No description provided for @permissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied. Please enable it in app settings.'**
  String get permissionDenied;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseFromGallery;

  /// No description provided for @removePicture.
  ///
  /// In en, this message translates to:
  /// **'Remove picture'**
  String get removePicture;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @birthdate.
  ///
  /// In en, this message translates to:
  /// **'Birthdate'**
  String get birthdate;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @stateRegion.
  ///
  /// In en, this message translates to:
  /// **'State/Region'**
  String get stateRegion;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @mShield.
  ///
  /// In en, this message translates to:
  /// **'M‑Shield'**
  String get mShield;

  /// No description provided for @activateShield.
  ///
  /// In en, this message translates to:
  /// **'Activate Shield'**
  String get activateShield;

  /// No description provided for @activating.
  ///
  /// In en, this message translates to:
  /// **'Activating...'**
  String get activating;

  /// No description provided for @activated.
  ///
  /// In en, this message translates to:
  /// **'Activated'**
  String get activated;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error'**
  String get serverError;

  /// No description provided for @connectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Connection failed'**
  String get connectionFailed;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknownError;

  /// No description provided for @autoCallDetection.
  ///
  /// In en, this message translates to:
  /// **'Auto Call Detection'**
  String get autoCallDetection;

  /// No description provided for @autoOtpDetection.
  ///
  /// In en, this message translates to:
  /// **'Auto OTP Detection'**
  String get autoOtpDetection;

  /// No description provided for @callBlock.
  ///
  /// In en, this message translates to:
  /// **'Blocks suspicious calls'**
  String get callBlock;

  /// No description provided for @otpBlock.
  ///
  /// In en, this message translates to:
  /// **'Prevents OTP theft'**
  String get otpBlock;

  /// No description provided for @mitraShield.
  ///
  /// In en, this message translates to:
  /// **'Mitra Shield'**
  String get mitraShield;

  /// No description provided for @verifier.
  ///
  /// In en, this message translates to:
  /// **'Verifier'**
  String get verifier;

  /// No description provided for @mitraVault.
  ///
  /// In en, this message translates to:
  /// **'Mitra Vault'**
  String get mitraVault;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @fetchOut.
  ///
  /// In en, this message translates to:
  /// **'Fetch Out'**
  String get fetchOut;

  /// No description provided for @noBankConnected.
  ///
  /// In en, this message translates to:
  /// **'No Bank Connected Yet'**
  String get noBankConnected;

  /// No description provided for @addBankAccount.
  ///
  /// In en, this message translates to:
  /// **'ADD Your Bank Account'**
  String get addBankAccount;

  /// No description provided for @documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documents;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @aadhaarCard.
  ///
  /// In en, this message translates to:
  /// **'Aadhaar Card'**
  String get aadhaarCard;

  /// No description provided for @bankPassbook.
  ///
  /// In en, this message translates to:
  /// **'Bank Passbook'**
  String get bankPassbook;

  /// No description provided for @fds.
  ///
  /// In en, this message translates to:
  /// **'FD\'s'**
  String get fds;

  /// No description provided for @encryptedNote.
  ///
  /// In en, this message translates to:
  /// **'end-to-end encrypted'**
  String get encryptedNote;

  /// No description provided for @noTransactionsYet.
  ///
  /// In en, this message translates to:
  /// **'No transactions available.'**
  String get noTransactionsYet;

  /// No description provided for @onlineComplainForm.
  ///
  /// In en, this message translates to:
  /// **'Online Complain form'**
  String get onlineComplainForm;

  /// No description provided for @cyberCrimeNo.
  ///
  /// In en, this message translates to:
  /// **'Cyber Crime no. 1930'**
  String get cyberCrimeNo;

  /// No description provided for @lockUnlockBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Lock/Unlock Biometrics'**
  String get lockUnlockBiometrics;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @couldNotLaunch.
  ///
  /// In en, this message translates to:
  /// **'Could not launch'**
  String get couldNotLaunch;

  /// No description provided for @savingInvestmentSchemes.
  ///
  /// In en, this message translates to:
  /// **'Savings and Investment Schemes'**
  String get savingInvestmentSchemes;

  /// No description provided for @loanSchemes.
  ///
  /// In en, this message translates to:
  /// **'Loan Schemes'**
  String get loanSchemes;

  /// No description provided for @pmJanDhanYojana.
  ///
  /// In en, this message translates to:
  /// **'Pradhan Mantri Jan Dhan Yojana'**
  String get pmJanDhanYojana;

  /// No description provided for @nationalPensionSystem.
  ///
  /// In en, this message translates to:
  /// **'National Pension System'**
  String get nationalPensionSystem;

  /// No description provided for @kisanVikasPatra.
  ///
  /// In en, this message translates to:
  /// **'Kisan Vikas Patra'**
  String get kisanVikasPatra;

  /// No description provided for @seniorCitizenSavings.
  ///
  /// In en, this message translates to:
  /// **'Senior Citizen Savings Scheme'**
  String get seniorCitizenSavings;

  /// No description provided for @textAudioVideo.
  ///
  /// In en, this message translates to:
  /// **'text , audio , video'**
  String get textAudioVideo;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @phishing.
  ///
  /// In en, this message translates to:
  /// **'PHISHING'**
  String get phishing;

  /// No description provided for @smishing.
  ///
  /// In en, this message translates to:
  /// **'SMISHING'**
  String get smishing;

  /// No description provided for @vishing.
  ///
  /// In en, this message translates to:
  /// **'VISHING'**
  String get vishing;

  /// No description provided for @otpScams.
  ///
  /// In en, this message translates to:
  /// **'OTP Scams'**
  String get otpScams;

  /// No description provided for @skimming.
  ///
  /// In en, this message translates to:
  /// **'Skimming'**
  String get skimming;

  /// No description provided for @websiteSpoofing.
  ///
  /// In en, this message translates to:
  /// **'Website Spoofing'**
  String get websiteSpoofing;

  /// No description provided for @verifierTitle.
  ///
  /// In en, this message translates to:
  /// **'Number & Message Verifier'**
  String get verifierTitle;

  /// No description provided for @enterPhoneOrMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number or message ID'**
  String get enterPhoneOrMessage;

  /// No description provided for @messageId.
  ///
  /// In en, this message translates to:
  /// **'Message ID'**
  String get messageId;

  /// No description provided for @scamScore.
  ///
  /// In en, this message translates to:
  /// **'Scam Score'**
  String get scamScore;

  /// No description provided for @scamDetected.
  ///
  /// In en, this message translates to:
  /// **'🚨 Scam Detected!'**
  String get scamDetected;

  /// No description provided for @safe.
  ///
  /// In en, this message translates to:
  /// **'Safe'**
  String get safe;

  /// No description provided for @saveError.
  ///
  /// In en, this message translates to:
  /// **'Failed to save result'**
  String get saveError;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Phone Number'**
  String get enterPhoneNumber;

  /// No description provided for @enterMessageId.
  ///
  /// In en, this message translates to:
  /// **'Enter Message ID'**
  String get enterMessageId;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @phoneVerifier.
  ///
  /// In en, this message translates to:
  /// **'Phone Number Verifier'**
  String get phoneVerifier;

  /// No description provided for @messageVerifier.
  ///
  /// In en, this message translates to:
  /// **'Message Verifier'**
  String get messageVerifier;

  /// No description provided for @selectState.
  ///
  /// In en, this message translates to:
  /// **'Select Your State'**
  String get selectState;

  /// No description provided for @chooseBankState.
  ///
  /// In en, this message translates to:
  /// **'Choose the state where your bank is located:'**
  String get chooseBankState;

  /// No description provided for @selectYourBank.
  ///
  /// In en, this message translates to:
  /// **'Select Your Bank'**
  String get selectYourBank;

  /// No description provided for @availableBanks.
  ///
  /// In en, this message translates to:
  /// **'Available Banks:'**
  String get availableBanks;

  /// No description provided for @enterNewPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter new phone number'**
  String get enterNewPhone;

  /// No description provided for @enterPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enterPhoneHint;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @okay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get okay;

  /// No description provided for @verifyBankNumber.
  ///
  /// In en, this message translates to:
  /// **'Verify number with your bank'**
  String get verifyBankNumber;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @phoneBankInfo.
  ///
  /// In en, this message translates to:
  /// **'To facilitate your payment transactions, make sure this number is linked to your bank and SIM is on your device.'**
  String get phoneBankInfo;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get enterAmount;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @convert.
  ///
  /// In en, this message translates to:
  /// **'Convert'**
  String get convert;

  /// No description provided for @convertedAmount.
  ///
  /// In en, this message translates to:
  /// **'Converted Amount'**
  String get convertedAmount;

  /// No description provided for @principalAmount.
  ///
  /// In en, this message translates to:
  /// **'Principal Amount'**
  String get principalAmount;

  /// No description provided for @rateOfInterest.
  ///
  /// In en, this message translates to:
  /// **'Rate of Interest (p.a)'**
  String get rateOfInterest;

  /// No description provided for @timeYears.
  ///
  /// In en, this message translates to:
  /// **'Time (in years)'**
  String get timeYears;

  /// No description provided for @calculateInterest.
  ///
  /// In en, this message translates to:
  /// **'Calculate Interest'**
  String get calculateInterest;

  /// No description provided for @simpleInterest.
  ///
  /// In en, this message translates to:
  /// **'Simple Interest'**
  String get simpleInterest;

  /// No description provided for @loanAmount.
  ///
  /// In en, this message translates to:
  /// **'Loan Amount (₹)'**
  String get loanAmount;

  /// No description provided for @interestRate.
  ///
  /// In en, this message translates to:
  /// **'Interest Rate (p.a)'**
  String get interestRate;

  /// No description provided for @loanTenure.
  ///
  /// In en, this message translates to:
  /// **'Loan Tenure (Years)'**
  String get loanTenure;

  /// No description provided for @calculateEmi.
  ///
  /// In en, this message translates to:
  /// **'Calculate EMI'**
  String get calculateEmi;

  /// No description provided for @yourEmi.
  ///
  /// In en, this message translates to:
  /// **'Your EMI'**
  String get yourEmi;

  /// No description provided for @emiFrequency.
  ///
  /// In en, this message translates to:
  /// **'EMI Frequency'**
  String get emiFrequency;

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearly;

  /// No description provided for @originalPrice.
  ///
  /// In en, this message translates to:
  /// **'Original Price (₹)'**
  String get originalPrice;

  /// No description provided for @discountPercentage.
  ///
  /// In en, this message translates to:
  /// **'Discount (%)'**
  String get discountPercentage;

  /// No description provided for @calculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get calculate;

  /// No description provided for @discountAmount.
  ///
  /// In en, this message translates to:
  /// **'Discount Amount'**
  String get discountAmount;

  /// No description provided for @finalPrice.
  ///
  /// In en, this message translates to:
  /// **'Final Price'**
  String get finalPrice;

  /// No description provided for @quizScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Quiz Zone'**
  String get quizScreenTitle;

  /// No description provided for @recentQuiz.
  ///
  /// In en, this message translates to:
  /// **'Recent Quiz'**
  String get recentQuiz;

  /// No description provided for @featured.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get featured;

  /// No description provided for @featuredDescription.
  ///
  /// In en, this message translates to:
  /// **'Take part in challenges\nenhance your knowledge'**
  String get featuredDescription;

  /// No description provided for @findFriends.
  ///
  /// In en, this message translates to:
  /// **'Find Friends'**
  String get findFriends;

  /// No description provided for @liveQuizzes.
  ///
  /// In en, this message translates to:
  /// **'Live Quizzes'**
  String get liveQuizzes;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @closeAll.
  ///
  /// In en, this message translates to:
  /// **'Close All'**
  String get closeAll;

  /// No description provided for @phishingSimulation.
  ///
  /// In en, this message translates to:
  /// **'Phishing Simulation'**
  String get phishingSimulation;

  /// No description provided for @whatIsPhishing.
  ///
  /// In en, this message translates to:
  /// **'What is Phishing?'**
  String get whatIsPhishing;

  /// No description provided for @phishingExplanation.
  ///
  /// In en, this message translates to:
  /// **'Phishing is a type of cyberattack where criminals impersonate trusted organizations to trick you into revealing sensitive information such as passwords, credit card numbers, or personal details.'**
  String get phishingExplanation;

  /// No description provided for @playAudio.
  ///
  /// In en, this message translates to:
  /// **'Play Audio'**
  String get playAudio;

  /// No description provided for @simulation.
  ///
  /// In en, this message translates to:
  /// **'Simulation'**
  String get simulation;

  /// No description provided for @emailSubject.
  ///
  /// In en, this message translates to:
  /// **'Urgent: Account Verification Required'**
  String get emailSubject;

  /// No description provided for @emailBody.
  ///
  /// In en, this message translates to:
  /// **'Dear Customer,\n\nWe noticed suspicious activity on your bank account. Please click the link below to verify your information immediately and avoid account suspension.\n\nThank you,\nYour Bank Security Team'**
  String get emailBody;

  /// No description provided for @clickLink.
  ///
  /// In en, this message translates to:
  /// **'Click Link'**
  String get clickLink;

  /// No description provided for @reportPhishing.
  ///
  /// In en, this message translates to:
  /// **'Report Phishing'**
  String get reportPhishing;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct!'**
  String get correct;

  /// No description provided for @incorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get incorrect;

  /// No description provided for @correctExplanation.
  ///
  /// In en, this message translates to:
  /// **'Good job! You avoided a phishing attempt.'**
  String get correctExplanation;

  /// No description provided for @incorrectExplanation.
  ///
  /// In en, this message translates to:
  /// **'Oops! That was a phishing link. Always verify before clicking.'**
  String get incorrectExplanation;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @videoExplanation.
  ///
  /// In en, this message translates to:
  /// **'Video Explanation'**
  String get videoExplanation;

  /// No description provided for @tipsTitle.
  ///
  /// In en, this message translates to:
  /// **'Tips to Avoid Phishing Attacks'**
  String get tipsTitle;

  /// No description provided for @tipsContent.
  ///
  /// In en, this message translates to:
  /// **'• Always verify the sender’s email address.\n• Look out for spelling mistakes and generic greetings.\n• Never click on suspicious links.\n• Enable two-factor authentication on your accounts.\n• Report suspicious emails to your IT department or email provider.'**
  String get tipsContent;

  /// No description provided for @smishingSimulation.
  ///
  /// In en, this message translates to:
  /// **'Smishing Simulation'**
  String get smishingSimulation;

  /// No description provided for @whatIsSmishing.
  ///
  /// In en, this message translates to:
  /// **'What is Smishing?'**
  String get whatIsSmishing;

  /// No description provided for @smishingExplanation.
  ///
  /// In en, this message translates to:
  /// **'Smishing is a type of phishing attack using SMS. Scammers send fake messages pretending to be from trusted organizations to steal your information.'**
  String get smishingExplanation;

  /// No description provided for @smsMessage.
  ///
  /// In en, this message translates to:
  /// **'SMS Message'**
  String get smsMessage;

  /// No description provided for @smsBody.
  ///
  /// In en, this message translates to:
  /// **'Your bank account is suspended. Click the link to verify immediately: http://fakebank.com'**
  String get smsBody;

  /// No description provided for @reportSmishing.
  ///
  /// In en, this message translates to:
  /// **'Report Smishing'**
  String get reportSmishing;

  /// No description provided for @vishingDescription.
  ///
  /// In en, this message translates to:
  /// **'Vishing is a type of scam where fraudsters call you pretending to be from a trusted organization to steal sensitive information like bank details or OTPs.'**
  String get vishingDescription;

  /// No description provided for @playVideo.
  ///
  /// In en, this message translates to:
  /// **'Play Video'**
  String get playVideo;

  /// No description provided for @pauseVideo.
  ///
  /// In en, this message translates to:
  /// **'Pause Video'**
  String get pauseVideo;

  /// No description provided for @simulateVishingCall.
  ///
  /// In en, this message translates to:
  /// **'Simulate Vishing Call'**
  String get simulateVishingCall;

  /// No description provided for @incomingCall.
  ///
  /// In en, this message translates to:
  /// **'Incoming Call'**
  String get incomingCall;

  /// No description provided for @calling.
  ///
  /// In en, this message translates to:
  /// **'Calling…'**
  String get calling;

  /// No description provided for @endCall.
  ///
  /// In en, this message translates to:
  /// **'End Call'**
  String get endCall;

  /// No description provided for @vishingFakeCallLine.
  ///
  /// In en, this message translates to:
  /// **'Hello, this is your bank calling regarding suspicious activity.'**
  String get vishingFakeCallLine;

  /// No description provided for @pauseAudio.
  ///
  /// In en, this message translates to:
  /// **'Pause Audio'**
  String get pauseAudio;

  /// No description provided for @couldNotLaunchPhone.
  ///
  /// In en, this message translates to:
  /// **'Could not open phone dialer.'**
  String get couldNotLaunchPhone;

  /// No description provided for @couldNotLaunchWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'Could not open WhatsApp.'**
  String get couldNotLaunchWhatsapp;

  /// No description provided for @setAsProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Set as profile picture?'**
  String get setAsProfilePicture;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @shieldStatus.
  ///
  /// In en, this message translates to:
  /// **'Shield is currently {status}'**
  String shieldStatus(String state, Object status);

  /// No description provided for @callWarning.
  ///
  /// In en, this message translates to:
  /// **'Incoming unknown number call detected!'**
  String get callWarning;

  /// No description provided for @callFromUnknown.
  ///
  /// In en, this message translates to:
  /// **'Call from unknown number'**
  String get callFromUnknown;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @reportCaller.
  ///
  /// In en, this message translates to:
  /// **'Report this caller?'**
  String get reportCaller;

  /// No description provided for @scam.
  ///
  /// In en, this message translates to:
  /// **'SCAM'**
  String get scam;

  /// No description provided for @misbehavior.
  ///
  /// In en, this message translates to:
  /// **'Misbehavior'**
  String get misbehavior;

  /// No description provided for @robocall.
  ///
  /// In en, this message translates to:
  /// **'Robocall'**
  String get robocall;

  /// No description provided for @promotional.
  ///
  /// In en, this message translates to:
  /// **'Promotional Call'**
  String get promotional;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @shieldOn.
  ///
  /// In en, this message translates to:
  /// **'Shield is activated'**
  String get shieldOn;

  /// No description provided for @shieldOff.
  ///
  /// In en, this message translates to:
  /// **'Shield is deactivated'**
  String get shieldOff;

  /// No description provided for @otpScam.
  ///
  /// In en, this message translates to:
  /// **'OTP SCAM'**
  String get otpScam;

  /// No description provided for @otpScamDescription.
  ///
  /// In en, this message translates to:
  /// **'OTP scams involve fraudsters tricking you into sharing a one-time password sent to your phone, allowing them unauthorized access.'**
  String get otpScamDescription;

  /// No description provided for @simulateOtpScam.
  ///
  /// In en, this message translates to:
  /// **'Simulate OTP Scam'**
  String get simulateOtpScam;

  /// No description provided for @otpScamSimulation.
  ///
  /// In en, this message translates to:
  /// **'OTP Scam Simulation'**
  String get otpScamSimulation;

  /// No description provided for @otpScamSimulationInfo.
  ///
  /// In en, this message translates to:
  /// **'Experience how OTP scams work in real-time. Stay alert, stay safe!'**
  String get otpScamSimulationInfo;

  /// No description provided for @fakeBankMessage.
  ///
  /// In en, this message translates to:
  /// **'Fake Message from Bank'**
  String get fakeBankMessage;

  /// No description provided for @otpScamMessageExample.
  ///
  /// In en, this message translates to:
  /// **'Your account will be blocked. Share the OTP \'907643\' sent to you to keep it active.'**
  String get otpScamMessageExample;

  /// No description provided for @enterOtpHere.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOtpHere;

  /// No description provided for @audioExplainsScam.
  ///
  /// In en, this message translates to:
  /// **'This audio explains how scammers trap you into revealing your OTP.'**
  String get audioExplainsScam;

  /// No description provided for @watchHowScamWorks.
  ///
  /// In en, this message translates to:
  /// **'Watch how this scam works in the video below.'**
  String get watchHowScamWorks;

  /// No description provided for @scamAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Scam Alert!'**
  String get scamAlertTitle;

  /// No description provided for @scamAmountDebited.
  ///
  /// In en, this message translates to:
  /// **'INR 49,999 has been debited from your account ****3456.'**
  String get scamAmountDebited;

  /// No description provided for @scamWarning.
  ///
  /// In en, this message translates to:
  /// **'NEVER share your OTP with anyone. Even your bank will never ask for it. otherwise this will happen So be Educated and Safe'**
  String get scamWarning;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @skimmingScamSimulation.
  ///
  /// In en, this message translates to:
  /// **'Skimming Scam Simulation'**
  String get skimmingScamSimulation;

  /// No description provided for @skimmingScamInfo.
  ///
  /// In en, this message translates to:
  /// **'Skimming is a method used by criminals to capture data from the magnetic stripe on credit and debit cards.'**
  String get skimmingScamInfo;

  /// No description provided for @fakeATMScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'ATM Machine'**
  String get fakeATMScreenTitle;

  /// No description provided for @fakeATMInstruction.
  ///
  /// In en, this message translates to:
  /// **'Please insert your card and enter PIN.'**
  String get fakeATMInstruction;

  /// No description provided for @enterYourPIN.
  ///
  /// In en, this message translates to:
  /// **'Enter your PIN'**
  String get enterYourPIN;

  /// No description provided for @audioExplainsSkimming.
  ///
  /// In en, this message translates to:
  /// **'This audio explains how skimming scams work. Listen carefully.'**
  String get audioExplainsSkimming;

  /// No description provided for @watchHowSkimmingWorks.
  ///
  /// In en, this message translates to:
  /// **'Watch How Skimming Works'**
  String get watchHowSkimmingWorks;

  /// No description provided for @skimmingDetectedWarning.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Warning: Your PIN might be being recorded via a hidden camera!'**
  String get skimmingDetectedWarning;

  /// No description provided for @insertCardToProceed.
  ///
  /// In en, this message translates to:
  /// **'Tap the ATM card slot to insert your card.'**
  String get insertCardToProceed;

  /// No description provided for @okayButtonText.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okayButtonText;

  /// No description provided for @yourDetailsCapturedTitle.
  ///
  /// In en, this message translates to:
  /// **'Your ATM details have been captured!'**
  String get yourDetailsCapturedTitle;

  /// No description provided for @capturedCardNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get capturedCardNumberLabel;

  /// No description provided for @capturedPinLabel.
  ///
  /// In en, this message translates to:
  /// **'PIN'**
  String get capturedPinLabel;

  /// No description provided for @howToRecognizeSkimming.
  ///
  /// In en, this message translates to:
  /// **'How to Recognize Skimming:'**
  String get howToRecognizeSkimming;

  /// No description provided for @tipCheckCardSlot.
  ///
  /// In en, this message translates to:
  /// **'Check for loose card slot or hidden devices.'**
  String get tipCheckCardSlot;

  /// No description provided for @tipCoverPin.
  ///
  /// In en, this message translates to:
  /// **'Always cover your PIN when entering it.'**
  String get tipCoverPin;

  /// No description provided for @tipReportSuspicious.
  ///
  /// In en, this message translates to:
  /// **'Report suspicious ATMs immediately.'**
  String get tipReportSuspicious;

  /// No description provided for @websiteSpoofingSimulation.
  ///
  /// In en, this message translates to:
  /// **'Website Spoofing Simulation'**
  String get websiteSpoofingSimulation;

  /// No description provided for @websiteSpoofingInfo.
  ///
  /// In en, this message translates to:
  /// **'Website spoofing involves fake sites imitating real ones to steal your data. Learn how to spot them.'**
  String get websiteSpoofingInfo;

  /// No description provided for @enterFakeBankDetails.
  ///
  /// In en, this message translates to:
  /// **'Enter credentials on this suspicious site to simulate the spoofing.'**
  String get enterFakeBankDetails;

  /// No description provided for @enterUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get enterUsername;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get enterPassword;

  /// No description provided for @fakeWebsiteWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning! This is a spoofed website. Never enter credentials on suspicious URLs.'**
  String get fakeWebsiteWarning;

  /// No description provided for @audioExplainsSpoofing.
  ///
  /// In en, this message translates to:
  /// **'This audio explains how fake websites try to trick you into entering credentials.'**
  String get audioExplainsSpoofing;

  /// No description provided for @watchSpoofingDemo.
  ///
  /// In en, this message translates to:
  /// **'Watch how website spoofing works'**
  String get watchSpoofingDemo;

  /// No description provided for @fakeUrl.
  ///
  /// In en, this message translates to:
  /// **'(Fake URL)'**
  String get fakeUrl;

  /// No description provided for @misspelledDomainExample.
  ///
  /// In en, this message translates to:
  /// **'Fake URLs often contain typos like \'yourb4nk\' instead of \'yourbank\'.'**
  String get misspelledDomainExample;

  /// No description provided for @whyThisIsFake.
  ///
  /// In en, this message translates to:
  /// **'Why is this website fake?'**
  String get whyThisIsFake;

  /// No description provided for @lookForHttps.
  ///
  /// In en, this message translates to:
  /// **'Always check if the URL starts with HTTPS and has a padlock.'**
  String get lookForHttps;

  /// No description provided for @realDomainExample.
  ///
  /// In en, this message translates to:
  /// **'Real URL'**
  String get realDomainExample;

  /// No description provided for @changePhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Change Phone Number'**
  String get changePhoneNumber;

  /// No description provided for @enterNewPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter New Number'**
  String get enterNewPhoneNumber;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get terms;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @noBankSynced.
  ///
  /// In en, this message translates to:
  /// **'No bank account is synced yet.'**
  String get noBankSynced;

  /// No description provided for @aadhaarStatus.
  ///
  /// In en, this message translates to:
  /// **'Aadhaar Linked'**
  String get aadhaarStatus;

  /// No description provided for @viewPassbook.
  ///
  /// In en, this message translates to:
  /// **'View Passbook'**
  String get viewPassbook;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Not Found'**
  String get notFound;

  /// No description provided for @noBankData.
  ///
  /// In en, this message translates to:
  /// **'No Bank Data'**
  String get noBankData;

  /// No description provided for @refreshBalance.
  ///
  /// In en, this message translates to:
  /// **'Refresh Balance'**
  String get refreshBalance;

  /// No description provided for @downloadStatement.
  ///
  /// In en, this message translates to:
  /// **'Download Statemen'**
  String get downloadStatement;

  /// No description provided for @noBank.
  ///
  /// In en, this message translates to:
  /// **'No Bank Data'**
  String get noBank;

  /// No description provided for @rewardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewardsTitle;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @ptsShort.
  ///
  /// In en, this message translates to:
  /// **'pts'**
  String get ptsShort;

  /// No description provided for @claim.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get claim;

  /// No description provided for @alreadyClaimed.
  ///
  /// In en, this message translates to:
  /// **'You already claimed this task!'**
  String get alreadyClaimed;

  /// No description provided for @pointsClaimed.
  ///
  /// In en, this message translates to:
  /// **'Points claimed successfully!'**
  String get pointsClaimed;

  /// No description provided for @leaderboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboardTitle;

  /// No description provided for @completeTask.
  ///
  /// In en, this message translates to:
  /// **'Complete Task'**
  String get completeTask;

  /// No description provided for @errorLoadingTasks.
  ///
  /// In en, this message translates to:
  /// **'Failed to load tasks. Please try again.'**
  String get errorLoadingTasks;

  /// No description provided for @errorStartingTask.
  ///
  /// In en, this message translates to:
  /// **'Failed to start task. Please try again.'**
  String get errorStartingTask;

  /// No description provided for @errorResumingTask.
  ///
  /// In en, this message translates to:
  /// **'Failed to resume task. Please try again.'**
  String get errorResumingTask;

  /// No description provided for @taskStarted.
  ///
  /// In en, this message translates to:
  /// **'Task started! Complete it to earn points.'**
  String get taskStarted;

  /// No description provided for @videoUrlNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Video URL not available for this task.'**
  String get videoUrlNotAvailable;

  /// No description provided for @openingVideo.
  ///
  /// In en, this message translates to:
  /// **'Opening video...'**
  String get openingVideo;

  /// No description provided for @cannotOpenVideoUrl.
  ///
  /// In en, this message translates to:
  /// **'Cannot open video URL. Please try again.'**
  String get cannotOpenVideoUrl;

  /// No description provided for @errorOpeningVideo.
  ///
  /// In en, this message translates to:
  /// **'Error opening video'**
  String get errorOpeningVideo;

  /// No description provided for @videoCompleted.
  ///
  /// In en, this message translates to:
  /// **'Video Completed?'**
  String get videoCompleted;

  /// No description provided for @finishedWatchingVideo.
  ///
  /// In en, this message translates to:
  /// **'Have you finished watching the video?'**
  String get finishedWatchingVideo;

  /// No description provided for @notYet.
  ///
  /// In en, this message translates to:
  /// **'Not Yet'**
  String get notYet;

  /// No description provided for @yesCompleted.
  ///
  /// In en, this message translates to:
  /// **'Yes, Completed!'**
  String get yesCompleted;

  /// No description provided for @shareAppMessage.
  ///
  /// In en, this message translates to:
  /// **'🛡️ Stay Safe from Online Scams! 🛡️\n\nDownload this amazing scam awareness app and protect yourself from:\n✅ Fake calls & Digital Arrests\n✅ OTP Scams & Phishing\n✅ Investment Frauds\n✅ Deepfake Videos\n\nDownload now and stay protected!\n\n#CyberSafety #ScamAlert #DigitalSafety'**
  String get shareAppMessage;

  /// No description provided for @shareTaskCompleted.
  ///
  /// In en, this message translates to:
  /// **'Great! You\'ve shared the app {count} times!'**
  String shareTaskCompleted(Object count);

  /// No description provided for @shareRemaining.
  ///
  /// In en, this message translates to:
  /// **'Shared! {count} more shares needed to complete this task.'**
  String shareRemaining(Object count);

  /// No description provided for @errorSharing.
  ///
  /// In en, this message translates to:
  /// **'Error sharing. Please try again.'**
  String get errorSharing;

  /// No description provided for @shareManually.
  ///
  /// In en, this message translates to:
  /// **'Share Manually'**
  String get shareManually;

  /// No description provided for @textCopiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'The share text has been copied to your clipboard!'**
  String get textCopiedToClipboard;

  /// No description provided for @pasteAndShare.
  ///
  /// In en, this message translates to:
  /// **'Please paste and share it manually on:'**
  String get pasteAndShare;

  /// No description provided for @shareOptions.
  ///
  /// In en, this message translates to:
  /// **'• WhatsApp\n• Instagram\n• Facebook\n• SMS\n• Email'**
  String get shareOptions;

  /// No description provided for @failedToCopyToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Failed to copy to clipboard'**
  String get failedToCopyToClipboard;

  /// No description provided for @quizUrlNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Quiz URL not available for this task.'**
  String get quizUrlNotAvailable;

  /// No description provided for @openingQuiz.
  ///
  /// In en, this message translates to:
  /// **'Opening quiz...'**
  String get openingQuiz;

  /// No description provided for @cannotOpenQuizUrl.
  ///
  /// In en, this message translates to:
  /// **'Cannot open quiz URL. Please try again.'**
  String get cannotOpenQuizUrl;

  /// No description provided for @errorOpeningQuiz.
  ///
  /// In en, this message translates to:
  /// **'Error opening quiz'**
  String get errorOpeningQuiz;

  /// No description provided for @quizCompleted.
  ///
  /// In en, this message translates to:
  /// **'Quiz Completed?'**
  String get quizCompleted;

  /// No description provided for @finishedQuizSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Have you finished the quiz successfully?'**
  String get finishedQuizSuccessfully;

  /// No description provided for @dailyCheckinCompleted.
  ///
  /// In en, this message translates to:
  /// **'Daily check-in completed!'**
  String get dailyCheckinCompleted;

  /// No description provided for @taskCompletedCanClaim.
  ///
  /// In en, this message translates to:
  /// **'Task completed! You can now claim your reward.'**
  String get taskCompletedCanClaim;

  /// No description provided for @errorClaimingReward.
  ///
  /// In en, this message translates to:
  /// **'Failed to claim reward. Please try again.'**
  String get errorClaimingReward;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get congratulations;

  /// No description provided for @earnedPoints.
  ///
  /// In en, this message translates to:
  /// **'You earned {points} points!'**
  String earnedPoints(Object points);

  /// No description provided for @awesome.
  ///
  /// In en, this message translates to:
  /// **'Awesome!'**
  String get awesome;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @startTask.
  ///
  /// In en, this message translates to:
  /// **'Start Task'**
  String get startTask;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress...'**
  String get inProgress;

  /// No description provided for @continueTask.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueTask;

  /// No description provided for @incomplete.
  ///
  /// In en, this message translates to:
  /// **'Incomplete'**
  String get incomplete;

  /// No description provided for @pts.
  ///
  /// In en, this message translates to:
  /// **'pts'**
  String get pts;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @incompleteTask.
  ///
  /// In en, this message translates to:
  /// **'Incomplete Task'**
  String get incompleteTask;

  /// No description provided for @markTaskIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to mark this task as incomplete? All progress will be lost.'**
  String get markTaskIncomplete;

  /// No description provided for @markIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Mark Incomplete'**
  String get markIncomplete;

  /// No description provided for @taskMarkedIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Task marked as incomplete. You can start it again.'**
  String get taskMarkedIncomplete;

  /// No description provided for @noTasksAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Tasks Available Yet'**
  String get noTasksAvailable;

  /// No description provided for @newTasksAddedSoon.
  ///
  /// In en, this message translates to:
  /// **'New tasks will be added soon.\nCheck back later!'**
  String get newTasksAddedSoon;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @yourProgress.
  ///
  /// In en, this message translates to:
  /// **'Your Progress'**
  String get yourProgress;

  /// No description provided for @loadingTasks.
  ///
  /// In en, this message translates to:
  /// **'Loading tasks...'**
  String get loadingTasks;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get min;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get showLess;

  /// No description provided for @spamAlert.
  ///
  /// In en, this message translates to:
  /// **'SPAM ALERT'**
  String get spamAlert;

  /// No description provided for @suspiciousCallDetected.
  ///
  /// In en, this message translates to:
  /// **'Suspicious call detected from:'**
  String get suspiciousCallDetected;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'WARNING'**
  String get warning;

  /// No description provided for @spamWarningMessage.
  ///
  /// In en, this message translates to:
  /// **'This number matches known spam patterns. Be extremely careful before answering.'**
  String get spamWarningMessage;

  /// No description provided for @block.
  ///
  /// In en, this message translates to:
  /// **'BLOCK'**
  String get block;

  /// No description provided for @allow.
  ///
  /// In en, this message translates to:
  /// **'ALLOW'**
  String get allow;

  /// No description provided for @callBlocked.
  ///
  /// In en, this message translates to:
  /// **'Call blocked'**
  String get callBlocked;

  /// No description provided for @callAllowed.
  ///
  /// In en, this message translates to:
  /// **'Call allowed'**
  String get callAllowed;

  /// No description provided for @deactivateShield.
  ///
  /// In en, this message translates to:
  /// **'Deactivate Shield'**
  String get deactivateShield;

  /// No description provided for @phonePermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone permission is required'**
  String get phonePermissionRequired;

  /// No description provided for @monitoringStartFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not start monitoring'**
  String get monitoringStartFailed;

  /// No description provided for @shieldActivatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'MShield activated successfully!'**
  String get shieldActivatedSuccess;

  /// No description provided for @activationFailed.
  ///
  /// In en, this message translates to:
  /// **'Activation failed'**
  String get activationFailed;

  /// No description provided for @monitoringActive.
  ///
  /// In en, this message translates to:
  /// **'Monitoring is now active'**
  String get monitoringActive;

  /// No description provided for @spamCallBlocked.
  ///
  /// In en, this message translates to:
  /// **'Spam call blocked'**
  String get spamCallBlocked;

  /// No description provided for @shieldDeactivated.
  ///
  /// In en, this message translates to:
  /// **'MShield deactivated'**
  String get shieldDeactivated;

  /// No description provided for @deactivationError.
  ///
  /// In en, this message translates to:
  /// **'Deactivation error'**
  String get deactivationError;

  /// No description provided for @realTimeDetectionAndBlocker.
  ///
  /// In en, this message translates to:
  /// **'Real Time Detection and Blocker'**
  String get realTimeDetectionAndBlocker;

  /// No description provided for @fakeBankOfficer.
  ///
  /// In en, this message translates to:
  /// **'Bank Officer (Fake)'**
  String get fakeBankOfficer;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected at'**
  String get connected;

  /// No description provided for @safetyTipsTitle.
  ///
  /// In en, this message translates to:
  /// **'How to Stay Safe from Vishing'**
  String get safetyTipsTitle;

  /// No description provided for @noShareOTP.
  ///
  /// In en, this message translates to:
  /// **'Never share your OTP or PIN with anyone.'**
  String get noShareOTP;

  /// No description provided for @verifyCallerID.
  ///
  /// In en, this message translates to:
  /// **'Always verify the caller’s identity on official channels.'**
  String get verifyCallerID;

  /// No description provided for @callBackOfficial.
  ///
  /// In en, this message translates to:
  /// **'Hang up and call the bank’s official number yourself.'**
  String get callBackOfficial;

  /// No description provided for @reportScam.
  ///
  /// In en, this message translates to:
  /// **'Scam'**
  String get reportScam;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn more about scam prevention'**
  String get learnMore;

  /// No description provided for @game.
  ///
  /// In en, this message translates to:
  /// **'Scam Runner'**
  String get game;

  /// No description provided for @tips.
  ///
  /// In en, this message translates to:
  /// **'Finance Tips'**
  String get tips;

  /// No description provided for @tip.
  ///
  /// In en, this message translates to:
  /// **'M.Tips'**
  String get tip;

  /// No description provided for @emergency_fund.
  ///
  /// In en, this message translates to:
  /// **'Emergency Fund'**
  String get emergency_fund;

  /// No description provided for @stock_basics.
  ///
  /// In en, this message translates to:
  /// **'Stock Basics'**
  String get stock_basics;

  /// No description provided for @long_term_growth.
  ///
  /// In en, this message translates to:
  /// **'Long-Term Growth'**
  String get long_term_growth;

  /// No description provided for @budgeting_101.
  ///
  /// In en, this message translates to:
  /// **'Budgeting 101'**
  String get budgeting_101;

  /// No description provided for @retirement_plan.
  ///
  /// In en, this message translates to:
  /// **'Retirement Plan'**
  String get retirement_plan;

  /// No description provided for @learn_more.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learn_more;

  /// No description provided for @savings_tips_category.
  ///
  /// In en, this message translates to:
  /// **'Savings Tips'**
  String get savings_tips_category;

  /// No description provided for @stock_market_tips_category.
  ///
  /// In en, this message translates to:
  /// **'Stock Market Tips'**
  String get stock_market_tips_category;

  /// No description provided for @tip_title.
  ///
  /// In en, this message translates to:
  /// **'Start an Emergency Fund'**
  String get tip_title;

  /// No description provided for @tip_description.
  ///
  /// In en, this message translates to:
  /// **'Save at least 3-6 months of expenses in a high-yield account.'**
  String get tip_description;

  /// No description provided for @income_level.
  ///
  /// In en, this message translates to:
  /// **'Lower Class'**
  String get income_level;

  /// No description provided for @financial_category.
  ///
  /// In en, this message translates to:
  /// **'Saving'**
  String get financial_category;

  /// No description provided for @risk_tolerance.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get risk_tolerance;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @region_specific.
  ///
  /// In en, this message translates to:
  /// **'Rural'**
  String get region_specific;

  /// No description provided for @translate.
  ///
  /// In en, this message translates to:
  /// **'Translate'**
  String get translate;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Financial Tips Finder'**
  String get appTitle;

  /// No description provided for @personalInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInfoTitle;

  /// No description provided for @personalInfoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself'**
  String get personalInfoSubtitle;

  /// No description provided for @financialPreferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'Financial Preferences'**
  String get financialPreferencesTitle;

  /// No description provided for @financialPreferencesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'What are you looking for?'**
  String get financialPreferencesSubtitle;

  /// No description provided for @askQuestionTitle.
  ///
  /// In en, this message translates to:
  /// **'Ask a Question'**
  String get askQuestionTitle;

  /// No description provided for @askQuestionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get personalized advice (optional)'**
  String get askQuestionSubtitle;

  /// No description provided for @incomeLevel.
  ///
  /// In en, this message translates to:
  /// **'Income Level'**
  String get incomeLevel;

  /// No description provided for @ageGroup.
  ///
  /// In en, this message translates to:
  /// **'Age Group'**
  String get ageGroup;

  /// No description provided for @occupation.
  ///
  /// In en, this message translates to:
  /// **'Occupation'**
  String get occupation;

  /// No description provided for @region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get region;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @riskTolerance.
  ///
  /// In en, this message translates to:
  /// **'Risk Tolerance'**
  String get riskTolerance;

  /// No description provided for @lowerClass.
  ///
  /// In en, this message translates to:
  /// **'Lower Class'**
  String get lowerClass;

  /// No description provided for @middleClass.
  ///
  /// In en, this message translates to:
  /// **'Middle Class'**
  String get middleClass;

  /// No description provided for @upperClass.
  ///
  /// In en, this message translates to:
  /// **'Upper Class'**
  String get upperClass;

  /// No description provided for @age18to25.
  ///
  /// In en, this message translates to:
  /// **'18-25'**
  String get age18to25;

  /// No description provided for @age25to45.
  ///
  /// In en, this message translates to:
  /// **'25-45'**
  String get age25to45;

  /// No description provided for @age45to60.
  ///
  /// In en, this message translates to:
  /// **'45-60'**
  String get age45to60;

  /// No description provided for @age60plus.
  ///
  /// In en, this message translates to:
  /// **'60+'**
  String get age60plus;

  /// No description provided for @farmer.
  ///
  /// In en, this message translates to:
  /// **'Farmer'**
  String get farmer;

  /// No description provided for @salaried.
  ///
  /// In en, this message translates to:
  /// **'Salaried'**
  String get salaried;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @student.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get student;

  /// No description provided for @urban.
  ///
  /// In en, this message translates to:
  /// **'Urban'**
  String get urban;

  /// No description provided for @rural.
  ///
  /// In en, this message translates to:
  /// **'Rural'**
  String get rural;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving'**
  String get saving;

  /// No description provided for @investment.
  ///
  /// In en, this message translates to:
  /// **'Investment'**
  String get investment;

  /// No description provided for @debtManagement.
  ///
  /// In en, this message translates to:
  /// **'Debt Management'**
  String get debtManagement;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @questionHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., How can I start investing with ₹1000?'**
  String get questionHint;

  /// No description provided for @findTips.
  ///
  /// In en, this message translates to:
  /// **'Find Tips'**
  String get findTips;

  /// No description provided for @searching.
  ///
  /// In en, this message translates to:
  /// **'Searching...'**
  String get searching;

  /// No description provided for @yourTipsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Financial Tips'**
  String get yourTipsTitle;

  /// No description provided for @tipsFound.
  ///
  /// In en, this message translates to:
  /// **'{count} tips found'**
  String tipsFound(Object count);

  /// No description provided for @noTipsFound.
  ///
  /// In en, this message translates to:
  /// **'No tips found'**
  String get noTipsFound;

  /// No description provided for @tryDifferentFilters.
  ///
  /// In en, this message translates to:
  /// **'Try different filters or ask a specific question'**
  String get tryDifferentFilters;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Unable to fetch tips. Please check your connection and try again.'**
  String get errorMessage;

  /// No description provided for @qrSafetyScanner.
  ///
  /// In en, this message translates to:
  /// **'QR Safety Scanner'**
  String get qrSafetyScanner;

  /// No description provided for @scanComplete.
  ///
  /// In en, this message translates to:
  /// **'Scan Complete'**
  String get scanComplete;

  /// No description provided for @checkResultsBelow.
  ///
  /// In en, this message translates to:
  /// **'Check results below'**
  String get checkResultsBelow;

  /// No description provided for @pointCameraAtQR.
  ///
  /// In en, this message translates to:
  /// **'Point camera at QR code'**
  String get pointCameraAtQR;

  /// No description provided for @readyToScan.
  ///
  /// In en, this message translates to:
  /// **'Ready to Scan'**
  String get readyToScan;

  /// No description provided for @positionQRCode.
  ///
  /// In en, this message translates to:
  /// **'Position QR code within the frame'**
  String get positionQRCode;

  /// No description provided for @startScanning.
  ///
  /// In en, this message translates to:
  /// **'Start Scanning'**
  String get startScanning;

  /// No description provided for @scanResult.
  ///
  /// In en, this message translates to:
  /// **'Scan Result'**
  String get scanResult;

  /// No description provided for @scanAgain.
  ///
  /// In en, this message translates to:
  /// **'Scan Again'**
  String get scanAgain;

  /// No description provided for @rawQRContent.
  ///
  /// In en, this message translates to:
  /// **'Raw QR Content'**
  String get rawQRContent;

  /// No description provided for @parsedFields.
  ///
  /// In en, this message translates to:
  /// **'Parsed Fields'**
  String get parsedFields;

  /// No description provided for @notProvided.
  ///
  /// In en, this message translates to:
  /// **'Not provided'**
  String get notProvided;

  /// No description provided for @copiedUPIID.
  ///
  /// In en, this message translates to:
  /// **'Copied UPI ID'**
  String get copiedUPIID;

  /// No description provided for @analysisAdvice.
  ///
  /// In en, this message translates to:
  /// **'Analysis & Advice'**
  String get analysisAdvice;

  /// No description provided for @noRedFlags.
  ///
  /// In en, this message translates to:
  /// **'No red flags found.'**
  String get noRedFlags;

  /// No description provided for @securityTips.
  ///
  /// In en, this message translates to:
  /// **'Security Tips'**
  String get securityTips;

  /// No description provided for @safetyTipsList.
  ///
  /// In en, this message translates to:
  /// **'• Confirm UPI ID with the payee before paying\n• Avoid paying to shortened URLs or external links\n• Never share OTPs or UPI PINs\n• If uncertain, verify through official channels'**
  String get safetyTipsList;

  /// No description provided for @verificationResult.
  ///
  /// In en, this message translates to:
  /// **'Verification Result'**
  String get verificationResult;

  /// No description provided for @qrScanner.
  ///
  /// In en, this message translates to:
  /// **'QR Checker'**
  String get qrScanner;

  /// No description provided for @scamRunnerTitle.
  ///
  /// In en, this message translates to:
  /// **'SCAM RUNNER'**
  String get scamRunnerTitle;

  /// No description provided for @tapToJump.
  ///
  /// In en, this message translates to:
  /// **'TAP TO JUMP'**
  String get tapToJump;

  /// No description provided for @holdToChargeJump.
  ///
  /// In en, this message translates to:
  /// **'HOLD TO CHARGE JUMP'**
  String get holdToChargeJump;

  /// No description provided for @avoidScams.
  ///
  /// In en, this message translates to:
  /// **'AVOID SCAMS!'**
  String get avoidScams;

  /// No description provided for @tapToStart.
  ///
  /// In en, this message translates to:
  /// **'TAP TO START'**
  String get tapToStart;

  /// No description provided for @gameOver.
  ///
  /// In en, this message translates to:
  /// **'G A M E  O V E R'**
  String get gameOver;

  /// No description provided for @scoreLabel.
  ///
  /// In en, this message translates to:
  /// **'SCORE'**
  String get scoreLabel;

  /// No description provided for @highLabel.
  ///
  /// In en, this message translates to:
  /// **'HIGH'**
  String get highLabel;

  /// No description provided for @tapToRestart.
  ///
  /// In en, this message translates to:
  /// **'TAP TO RESTART'**
  String get tapToRestart;

  /// No description provided for @fake.
  ///
  /// In en, this message translates to:
  /// **'FAKE'**
  String get fake;

  /// No description provided for @fraud.
  ///
  /// In en, this message translates to:
  /// **'FRAUD'**
  String get fraud;

  /// No description provided for @spam.
  ///
  /// In en, this message translates to:
  /// **'SPAM'**
  String get spam;

  /// No description provided for @kycScam.
  ///
  /// In en, this message translates to:
  /// **'KYC SCAM'**
  String get kycScam;

  /// No description provided for @investmentScam.
  ///
  /// In en, this message translates to:
  /// **'INVESTMENT'**
  String get investmentScam;

  /// No description provided for @loanScam.
  ///
  /// In en, this message translates to:
  /// **'LOAN SCAM'**
  String get loanScam;

  /// No description provided for @jobScam.
  ///
  /// In en, this message translates to:
  /// **'JOB SCAM'**
  String get jobScam;

  /// No description provided for @romanceScam.
  ///
  /// In en, this message translates to:
  /// **'ROMANCE'**
  String get romanceScam;

  /// No description provided for @qrScam.
  ///
  /// In en, this message translates to:
  /// **'QR SCAM'**
  String get qrScam;

  /// No description provided for @screenShareScam.
  ///
  /// In en, this message translates to:
  /// **'SCREEN SHARE'**
  String get screenShareScam;

  /// No description provided for @malware.
  ///
  /// In en, this message translates to:
  /// **'MALWARE'**
  String get malware;

  /// No description provided for @muleAccount.
  ///
  /// In en, this message translates to:
  /// **'MULE ACCOUNT'**
  String get muleAccount;

  /// No description provided for @cyberCrime.
  ///
  /// In en, this message translates to:
  /// **'CYBER CRIME'**
  String get cyberCrime;

  /// No description provided for @dataTheft.
  ///
  /// In en, this message translates to:
  /// **'DATA THEFT'**
  String get dataTheft;

  /// No description provided for @identityTheft.
  ///
  /// In en, this message translates to:
  /// **'IDENTITY'**
  String get identityTheft;

  /// No description provided for @onlineFraud.
  ///
  /// In en, this message translates to:
  /// **'ONLINE FRAUD'**
  String get onlineFraud;

  /// No description provided for @cryptoScam.
  ///
  /// In en, this message translates to:
  /// **'CRYPTO'**
  String get cryptoScam;

  /// No description provided for @impersonation.
  ///
  /// In en, this message translates to:
  /// **'FAKE CALL'**
  String get impersonation;

  /// No description provided for @techSupport.
  ///
  /// In en, this message translates to:
  /// **'TECH SUPPORT'**
  String get techSupport;

  /// No description provided for @audioNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Audio not available'**
  String get audioNotAvailable;

  /// No description provided for @stopAudio.
  ///
  /// In en, this message translates to:
  /// **'Stop Audio'**
  String get stopAudio;

  /// No description provided for @toLabel.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get toLabel;

  /// No description provided for @indUrgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent language used'**
  String get indUrgent;

  /// No description provided for @indSender.
  ///
  /// In en, this message translates to:
  /// **'Suspicious sender address'**
  String get indSender;

  /// No description provided for @indSpelling.
  ///
  /// In en, this message translates to:
  /// **'Spelling and grammar errors'**
  String get indSpelling;

  /// No description provided for @indGreeting.
  ///
  /// In en, this message translates to:
  /// **'Generic greeting'**
  String get indGreeting;

  /// No description provided for @indLink.
  ///
  /// In en, this message translates to:
  /// **'Suspicious link'**
  String get indLink;

  /// No description provided for @suspiciousIndicatorTitle.
  ///
  /// In en, this message translates to:
  /// **'Suspicious Indicators'**
  String get suspiciousIndicatorTitle;

  /// No description provided for @securityWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning! You clicked on a suspicious link. In real life, this could compromise your personal data. Always verify before clicking any links.'**
  String get securityWarning;

  /// No description provided for @videoNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Video not available'**
  String get videoNotAvailable;

  /// No description provided for @restartVideo.
  ///
  /// In en, this message translates to:
  /// **'Restart Video'**
  String get restartVideo;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// No description provided for @verificationLinkSent.
  ///
  /// In en, this message translates to:
  /// **'A verification link has been sent to your email'**
  String get verificationLinkSent;

  /// No description provided for @verifyEmailInstruction.
  ///
  /// In en, this message translates to:
  /// **'Please verify your email before proceeding.'**
  String get verifyEmailInstruction;

  /// No description provided for @emailNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Email is not verified yet.'**
  String get emailNotVerified;

  /// No description provided for @resendVerification.
  ///
  /// In en, this message translates to:
  /// **'Resend verification email'**
  String get resendVerification;

  /// No description provided for @startSimulation.
  ///
  /// In en, this message translates to:
  /// **'Start Simulation'**
  String get startSimulation;

  /// No description provided for @tipUseTrustedATMs.
  ///
  /// In en, this message translates to:
  /// **'Use ATMs in safe locations or bank branches'**
  String get tipUseTrustedATMs;

  /// No description provided for @tipMonitorBankStatements.
  ///
  /// In en, this message translates to:
  /// **'Regularly monitor your bank statements'**
  String get tipMonitorBankStatements;

  /// No description provided for @fakeMirroringPanel.
  ///
  /// In en, this message translates to:
  /// **'Mirroring Panel (Fake Display)'**
  String get fakeMirroringPanel;

  /// No description provided for @noVideoAvailable.
  ///
  /// In en, this message translates to:
  /// **'No video available.'**
  String get noVideoAvailable;

  /// No description provided for @infoTab.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get infoTab;

  /// No description provided for @stolenDetailsTab.
  ///
  /// In en, this message translates to:
  /// **'Your Details'**
  String get stolenDetailsTab;

  /// No description provided for @detailsStolenWarning.
  ///
  /// In en, this message translates to:
  /// **'⚠ Your details have been stolen! ⚠'**
  String get detailsStolenWarning;

  /// No description provided for @noUserData.
  ///
  /// In en, this message translates to:
  /// **'No user data available.'**
  String get noUserData;

  /// No description provided for @clickHereToLogin.
  ///
  /// In en, this message translates to:
  /// **'Click here to login'**
  String get clickHereToLogin;

  /// No description provided for @howToRecognizeScam.
  ///
  /// In en, this message translates to:
  /// **'How to Recognize an OTP Scam'**
  String get howToRecognizeScam;

  /// No description provided for @tip1.
  ///
  /// In en, this message translates to:
  /// **'Check the sender’s email address carefully.'**
  String get tip1;

  /// No description provided for @tip2.
  ///
  /// In en, this message translates to:
  /// **'Look for grammar or spelling mistakes.'**
  String get tip2;

  /// No description provided for @tip3.
  ///
  /// In en, this message translates to:
  /// **'Hover over links to see the real URL.'**
  String get tip3;

  /// No description provided for @tip4.
  ///
  /// In en, this message translates to:
  /// **'If in doubt, call your bank\'s official helpline immediately.'**
  String get tip4;

  /// No description provided for @newMessageReceived.
  ///
  /// In en, this message translates to:
  /// **'📩 You have received a new message. Tap to view.'**
  String get newMessageReceived;

  /// No description provided for @smsTime.
  ///
  /// In en, this message translates to:
  /// **'Today, 10:45 AM'**
  String get smsTime;

  /// No description provided for @tipsToRecognize.
  ///
  /// In en, this message translates to:
  /// **'Tips to recognize phishing emails:'**
  String get tipsToRecognize;

  /// No description provided for @suspiciousLinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Suspicious Link Detected'**
  String get suspiciousLinkTitle;

  /// No description provided for @suspiciousLinkMessage.
  ///
  /// In en, this message translates to:
  /// **'The link you clicked looks suspicious. Do not enter any personal information.'**
  String get suspiciousLinkMessage;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @learnHow.
  ///
  /// In en, this message translates to:
  /// **'Learn how to check links'**
  String get learnHow;

  /// No description provided for @linkTipsTitle.
  ///
  /// In en, this message translates to:
  /// **'How to Recognize Dangerous Links'**
  String get linkTipsTitle;

  /// No description provided for @linkTip1.
  ///
  /// In en, this message translates to:
  /// **'Avoid clicking unknown links from emails.'**
  String get linkTip1;

  /// No description provided for @linkTip2.
  ///
  /// In en, this message translates to:
  /// **'Check if the website address is spelled correctly.'**
  String get linkTip2;

  /// No description provided for @linkTip3.
  ///
  /// In en, this message translates to:
  /// **'Be cautious with shortened URLs.'**
  String get linkTip3;

  /// No description provided for @smsBodyBeforeLink.
  ///
  /// In en, this message translates to:
  /// **'Your bank account is suspended. Click here: '**
  String get smsBodyBeforeLink;

  /// No description provided for @smsBodyAfterLink.
  ///
  /// In en, this message translates to:
  /// **' to verify immediately.'**
  String get smsBodyAfterLink;

  /// No description provided for @verifyWithMShield.
  ///
  /// In en, this message translates to:
  /// **'Verify suspicious links with M-Shield for safety.'**
  String get verifyWithMShield;

  /// No description provided for @openMShield.
  ///
  /// In en, this message translates to:
  /// **'Open M-Shield'**
  String get openMShield;

  /// No description provided for @simulationTitle.
  ///
  /// In en, this message translates to:
  /// **'Phishing Simulation'**
  String get simulationTitle;

  /// No description provided for @inboxSubjectLine.
  ///
  /// In en, this message translates to:
  /// **'Bank Security Notice'**
  String get inboxSubjectLine;

  /// No description provided for @inboxPreviewText.
  ///
  /// In en, this message translates to:
  /// **'Important: Verify your account immediately...'**
  String get inboxPreviewText;

  /// No description provided for @emailSenderName.
  ///
  /// In en, this message translates to:
  /// **'SecureBank Support'**
  String get emailSenderName;

  /// No description provided for @emailSenderAddress.
  ///
  /// In en, this message translates to:
  /// **'support@securebank-alerts.com'**
  String get emailSenderAddress;

  /// No description provided for @emailBodyIntro.
  ///
  /// In en, this message translates to:
  /// **'Dear Customer,\n\nWe detected unusual login attempts on your account. For your safety, please verify your details immediately by clicking the secure link below:\n\n'**
  String get emailBodyIntro;

  /// No description provided for @verifyAccountLinkText.
  ///
  /// In en, this message translates to:
  /// **'Verify My Account'**
  String get verifyAccountLinkText;

  /// No description provided for @emailBodyOutro.
  ///
  /// In en, this message translates to:
  /// **'\n\nFailure to verify may result in temporary account suspension.\n\nSincerely,\nSecureBank Security Team'**
  String get emailBodyOutro;

  /// No description provided for @suspiciousLinkDescription.
  ///
  /// In en, this message translates to:
  /// **'This link may be part of a phishing attempt. Cybercriminals often use fake websites to steal your login details or personal information.'**
  String get suspiciousLinkDescription;

  /// No description provided for @howToRecognizeTitle.
  ///
  /// In en, this message translates to:
  /// **'How to Recognize a Fake Email:'**
  String get howToRecognizeTitle;

  /// No description provided for @tipCheckEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Check the sender’s email address carefully.'**
  String get tipCheckEmailAddress;

  /// No description provided for @tipGrammarMistakes.
  ///
  /// In en, this message translates to:
  /// **'Look for grammar mistakes or urgent threats.'**
  String get tipGrammarMistakes;

  /// No description provided for @tipHoverOverLinks.
  ///
  /// In en, this message translates to:
  /// **'Hover over links to see the real destination.'**
  String get tipHoverOverLinks;

  /// No description provided for @tipNoPasswordRequests.
  ///
  /// In en, this message translates to:
  /// **'Legitimate companies rarely ask for passwords via email.'**
  String get tipNoPasswordRequests;

  /// No description provided for @mitraShieldAdvice.
  ///
  /// In en, this message translates to:
  /// **'Mitra Shield: Always verify suspicious messages before clicking links or entering sensitive information.'**
  String get mitraShieldAdvice;

  /// No description provided for @openMitraShield.
  ///
  /// In en, this message translates to:
  /// **'Open Mitra Shield'**
  String get openMitraShield;

  /// No description provided for @newEmailReceived.
  ///
  /// In en, this message translates to:
  /// **'New email received'**
  String get newEmailReceived;

  /// No description provided for @emailTime.
  ///
  /// In en, this message translates to:
  /// **'2 hours ago'**
  String get emailTime;

  /// No description provided for @emailBodyBeforeLink.
  ///
  /// In en, this message translates to:
  /// **'We noticed unusual activity. Please verify your account immediately by visiting '**
  String get emailBodyBeforeLink;

  /// No description provided for @emailBodyAfterLink.
  ///
  /// In en, this message translates to:
  /// **'. If you do not verify, your account will be suspended.'**
  String get emailBodyAfterLink;

  /// No description provided for @tapToOpen.
  ///
  /// In en, this message translates to:
  /// **'Tap to open'**
  String get tapToOpen;

  /// No description provided for @subjectLine.
  ///
  /// In en, this message translates to:
  /// **'Suspicious activity detected on your account'**
  String get subjectLine;

  /// No description provided for @vishingTitle.
  ///
  /// In en, this message translates to:
  /// **'Vishing Scam'**
  String get vishingTitle;

  /// No description provided for @vishingHeader.
  ///
  /// In en, this message translates to:
  /// **'Beware of Vishing Calls'**
  String get vishingHeader;

  /// No description provided for @audioExplanation.
  ///
  /// In en, this message translates to:
  /// **'Audio Explanation'**
  String get audioExplanation;

  /// No description provided for @mshieldTitle.
  ///
  /// In en, this message translates to:
  /// **'MShield'**
  String get mshieldTitle;

  /// No description provided for @popupReportCall.
  ///
  /// In en, this message translates to:
  /// **'Report Call'**
  String get popupReportCall;

  /// No description provided for @popupViewReports.
  ///
  /// In en, this message translates to:
  /// **'View Reports'**
  String get popupViewReports;

  /// No description provided for @shieldActivating.
  ///
  /// In en, this message translates to:
  /// **'Activating...'**
  String get shieldActivating;

  /// No description provided for @shieldActivate.
  ///
  /// In en, this message translates to:
  /// **'Activate Shield'**
  String get shieldActivate;

  /// No description provided for @shieldActivated.
  ///
  /// In en, this message translates to:
  /// **'Shield Activated'**
  String get shieldActivated;

  /// No description provided for @autoCallBlock.
  ///
  /// In en, this message translates to:
  /// **'Call Block'**
  String get autoCallBlock;

  /// No description provided for @autoOtpBlock.
  ///
  /// In en, this message translates to:
  /// **'OTP Block'**
  String get autoOtpBlock;

  /// No description provided for @shieldActiveMsg.
  ///
  /// In en, this message translates to:
  /// **'Your MShield is actively protecting you.'**
  String get shieldActiveMsg;

  /// No description provided for @shieldInactiveMsg.
  ///
  /// In en, this message translates to:
  /// **'Activate MShield to stay protected.'**
  String get shieldInactiveMsg;

  /// No description provided for @reportDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Report Suspicious Call'**
  String get reportDialogTitle;

  /// No description provided for @reportPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get reportPhoneNumber;

  /// No description provided for @reportCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get reportCategory;

  /// No description provided for @reportDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get reportDetails;

  /// No description provided for @reportSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Report submitted successfully ✅'**
  String get reportSubmitted;

  /// No description provided for @reportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reportsTitle;

  /// No description provided for @noReports.
  ///
  /// In en, this message translates to:
  /// **'No reports available.'**
  String get noReports;

  /// No description provided for @reportMisguiding.
  ///
  /// In en, this message translates to:
  /// **'Misguiding'**
  String get reportMisguiding;

  /// No description provided for @reportMisbehaviour.
  ///
  /// In en, this message translates to:
  /// **'Misbehaviour'**
  String get reportMisbehaviour;

  /// No description provided for @reportSpam.
  ///
  /// In en, this message translates to:
  /// **'Spam'**
  String get reportSpam;

  /// No description provided for @mshieldAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'MShield Alert'**
  String get mshieldAlertTitle;

  /// No description provided for @mshieldWarningMsg.
  ///
  /// In en, this message translates to:
  /// **'Be careful while talking. Unknown caller may attempt suspicious activity.'**
  String get mshieldWarningMsg;

  /// No description provided for @reportNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Report Suspicious Call'**
  String get reportNotificationTitle;

  /// No description provided for @reportNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'If you found any suspicious activity you can report it here.'**
  String get reportNotificationBody;

  /// No description provided for @incomingCallWarning.
  ///
  /// In en, this message translates to:
  /// **'Be careful while talking. Unknown caller may attempt suspicious activity.'**
  String get incomingCallWarning;

  /// No description provided for @reportNotificationMsg.
  ///
  /// In en, this message translates to:
  /// **'If you found any suspicious activity you can report it here.'**
  String get reportNotificationMsg;

  /// No description provided for @categoryScam.
  ///
  /// In en, this message translates to:
  /// **'Scam'**
  String get categoryScam;

  /// No description provided for @categoryMisguiding.
  ///
  /// In en, this message translates to:
  /// **'Misguiding'**
  String get categoryMisguiding;

  /// No description provided for @categoryMisbehaviour.
  ///
  /// In en, this message translates to:
  /// **'Misbehaviour'**
  String get categoryMisbehaviour;

  /// No description provided for @categorySpam.
  ///
  /// In en, this message translates to:
  /// **'Spam'**
  String get categorySpam;

  /// No description provided for @reportTitle.
  ///
  /// In en, this message translates to:
  /// **'Report a Call'**
  String get reportTitle;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @reportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Report submitted successfully!'**
  String get reportSuccess;

  /// No description provided for @reportCall.
  ///
  /// In en, this message translates to:
  /// **'Report Call'**
  String get reportCall;

  /// No description provided for @viewReports.
  ///
  /// In en, this message translates to:
  /// **'View Reports'**
  String get viewReports;

  /// No description provided for @feedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedbackTitle;

  /// No description provided for @feedbackHeading.
  ///
  /// In en, this message translates to:
  /// **'We value your feedback 💬'**
  String get feedbackHeading;

  /// No description provided for @feedbackSubHeading.
  ///
  /// In en, this message translates to:
  /// **'Tell us what you think about our app. Your feedback helps us improve!'**
  String get feedbackSubHeading;

  /// No description provided for @feedbackHint.
  ///
  /// In en, this message translates to:
  /// **'Type your feedback here...'**
  String get feedbackHint;

  /// No description provided for @submitting.
  ///
  /// In en, this message translates to:
  /// **'Submitting...'**
  String get submitting;

  /// No description provided for @enterFeedback.
  ///
  /// In en, this message translates to:
  /// **'Please enter feedback before submitting'**
  String get enterFeedback;

  /// No description provided for @feedbackSuccess.
  ///
  /// In en, this message translates to:
  /// **'✅ Feedback submitted successfully!'**
  String get feedbackSuccess;

  /// No description provided for @feedbackFail.
  ///
  /// In en, this message translates to:
  /// **'❌ Failed to submit feedback:'**
  String get feedbackFail;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @appNotifications.
  ///
  /// In en, this message translates to:
  /// **'App Notifications'**
  String get appNotifications;

  /// No description provided for @appNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive important alerts and updates'**
  String get appNotificationsDesc;

  /// No description provided for @promotionalMessages.
  ///
  /// In en, this message translates to:
  /// **'Promotional Messages'**
  String get promotionalMessages;

  /// No description provided for @promotionalMessagesDesc.
  ///
  /// In en, this message translates to:
  /// **'Get offers, tips, and promotions'**
  String get promotionalMessagesDesc;

  /// No description provided for @helpSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupportTitle;

  /// No description provided for @faqs.
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get faqs;

  /// No description provided for @faqsDesc.
  ///
  /// In en, this message translates to:
  /// **'Find answers to common questions'**
  String get faqsDesc;

  /// No description provided for @contactUsDesc.
  ///
  /// In en, this message translates to:
  /// **'Reach out for support'**
  String get contactUsDesc;

  /// No description provided for @emailSupport.
  ///
  /// In en, this message translates to:
  /// **'Email Support'**
  String get emailSupport;

  /// No description provided for @callSupport.
  ///
  /// In en, this message translates to:
  /// **'Call Support'**
  String get callSupport;

  /// No description provided for @faq1Q.
  ///
  /// In en, this message translates to:
  /// **'How can I reset my password?'**
  String get faq1Q;

  /// No description provided for @faq1A.
  ///
  /// In en, this message translates to:
  /// **'You can reset your password by going to the Login screen and selecting \'Forgot Password\'.'**
  String get faq1A;

  /// No description provided for @faq2Q.
  ///
  /// In en, this message translates to:
  /// **'How do I contact support?'**
  String get faq2Q;

  /// No description provided for @faq2A.
  ///
  /// In en, this message translates to:
  /// **'You can contact our support team via email at support@myapp.com or call us at +91 7696481976.'**
  String get faq2A;

  /// No description provided for @termsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms & Policies'**
  String get termsTitle;

  /// No description provided for @termsHeading.
  ///
  /// In en, this message translates to:
  /// **'Our Commitment to You'**
  String get termsHeading;

  /// No description provided for @termsPoint1.
  ///
  /// In en, this message translates to:
  /// **'MyMitra is designed to provide you safe, reliable and secure digital financial awareness.'**
  String get termsPoint1;

  /// No description provided for @termsPoint2.
  ///
  /// In en, this message translates to:
  /// **'We never ask for your passwords, OTPs, or confidential banking details.'**
  String get termsPoint2;

  /// No description provided for @termsPoint3.
  ///
  /// In en, this message translates to:
  /// **'All your personal information is stored securely and never shared without your consent.'**
  String get termsPoint3;

  /// No description provided for @termsPoint4.
  ///
  /// In en, this message translates to:
  /// **'The app content is for educational and awareness purposes. Use your judgment before financial actions.'**
  String get termsPoint4;

  /// No description provided for @termsPoint5.
  ///
  /// In en, this message translates to:
  /// **'We may send important updates, but you can control notification preferences anytime.'**
  String get termsPoint5;

  /// No description provided for @termsPoint6.
  ///
  /// In en, this message translates to:
  /// **'By using MyMitra, you agree to use it responsibly and respect community guidelines.'**
  String get termsPoint6;

  /// No description provided for @termsThanks.
  ///
  /// In en, this message translates to:
  /// **'Thank you for trusting MyMitra!'**
  String get termsThanks;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'hi', 'pa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'hi': return AppLocalizationsHi();
    case 'pa': return AppLocalizationsPa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
