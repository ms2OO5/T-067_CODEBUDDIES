// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get chooseLanguage => 'Choose Language';

  @override
  String get selectPreferredLanguage => 'Select your preferred language below.';

  @override
  String get youSelected => 'You Selected';

  @override
  String get availableLanguages => 'Available Languages';

  @override
  String get next => 'Next ->';

  @override
  String get appname => 'MY MITRA';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get continueAsGuest => 'Continue as Guest';

  @override
  String get home => 'Home';

  @override
  String get mitraAi => 'Mitra AI';

  @override
  String get financialTools => 'M. Tools';

  @override
  String get settings => 'Settings';

  @override
  String get password => 'Password';

  @override
  String get enterEmail => 'Please enter your email';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get loginHeading => 'Your digital banking buddy\nsafe, smart and always by your side.';

  @override
  String get loginTitle => 'Login';

  @override
  String get userNotFound => 'User not found in database.';

  @override
  String get incorrectEmailOrPassword => 'Incorrect email or password';

  @override
  String get invalidEmail => 'Enter a valid email address.';

  @override
  String get loginFailed => 'Login failed';

  @override
  String get fullName => 'Full Name';

  @override
  String get emailRequired => 'Email (Required)';

  @override
  String get phoneOptional => 'Phone Number (Optional)';

  @override
  String get fieldsRequired => 'Name, Email & Password are required';

  @override
  String get registrationFailed => 'Registration failed';

  @override
  String get unexpectedError => 'Something went wrong';

  @override
  String get alreadyAccount => 'Already have an account? ';

  @override
  String get forgotPasswordTitle => 'Forgot Password?';

  @override
  String get forgotPasswordSubtitle => 'Enter your registered email; we’ll send you a reset link.';

  @override
  String get emailHint => 'Email';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String resetLinkSent(Object email) {
    return '✅ A password‑reset link has been sent to $email. Check your inbox.';
  }

  @override
  String get noUserFound => 'No user found with that email.';

  @override
  String get hello => 'Hello';

  @override
  String get phone => 'Phone';

  @override
  String get email => 'Email';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get language => 'Language';

  @override
  String get mshield => 'M-Shield';

  @override
  String get vault => 'M.Vault';

  @override
  String get help => 'Help';

  @override
  String get more => 'More';

  @override
  String get fraudInfo => 'Fraud Info';

  @override
  String get govtPolicies => 'Govt Policies';

  @override
  String get back => 'Back';

  @override
  String get funZone => 'Fun Zone';

  @override
  String get quizSection => 'Quiz Section';

  @override
  String get dailyChallenges => 'Daily Challenges';

  @override
  String get rewards => 'Rewards';

  @override
  String get cashbacks => 'Cashbacks';

  @override
  String get giftCards => 'Gift Cards';

  @override
  String get viewAll => 'View All';

  @override
  String intro(Object name) {
    return '👋 Hello $name! I\'m your banking buddy 🤖. How can I help?';
  }

  @override
  String get typing => 'Typing...';

  @override
  String get listening => 'Listening...';

  @override
  String get refresh_chat => '🔄 Refresh Chat';

  @override
  String get report_problem => '⚠️ Report Problem';

  @override
  String get report_submitted => 'Report submitted!';

  @override
  String get ask_something => 'Ask Something... 💬';

  @override
  String get failed_response => '⚠️ Failed to get response.';

  @override
  String get default_reply => 'Sorry, I didn\'t understand.';

  @override
  String get financeTools => 'Finance Tools';

  @override
  String get currencyConverter => 'Currency Converter';

  @override
  String get interestCalculator => 'Interest Calculator';

  @override
  String get emiCalculator => 'EMI Calculator';

  @override
  String get discountCalculator => 'Discount Calculator';

  @override
  String get allLanguages => 'All Languages';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get account => 'Account';

  @override
  String get security => 'Security';

  @override
  String get manageAccounts => 'Manage Accounts';

  @override
  String get privacy => 'Privacy';

  @override
  String get appSettings => 'App Settings';

  @override
  String get notifications => 'Notifications';

  @override
  String get supportAndAbout => 'Support & About';

  @override
  String get feedback => 'Feedback';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get termsPolicies => 'Terms and Policies';

  @override
  String get permissionDenied => 'Permission denied. Please enable it in app settings.';

  @override
  String get takePhoto => 'Take a photo';

  @override
  String get chooseFromGallery => 'Choose from gallery';

  @override
  String get removePicture => 'Remove picture';

  @override
  String get name => 'Name';

  @override
  String get birthdate => 'Birthdate';

  @override
  String get gender => 'Gender';

  @override
  String get stateRegion => 'State/Region';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get mShield => 'M‑Shield';

  @override
  String get activateShield => 'Activate Shield';

  @override
  String get activating => 'Activating...';

  @override
  String get activated => 'Activated';

  @override
  String get serverError => 'Server error';

  @override
  String get connectionFailed => 'Connection failed';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get autoCallDetection => 'Auto Call Detection';

  @override
  String get autoOtpDetection => 'Auto OTP Detection';

  @override
  String get callBlock => 'Blocks suspicious calls';

  @override
  String get otpBlock => 'Prevents OTP theft';

  @override
  String get mitraShield => 'Mitra Shield';

  @override
  String get verifier => 'Verifier';

  @override
  String get mitraVault => 'Mitra Vault';

  @override
  String get termsAndConditions => 'Terms & Conditions';

  @override
  String get fetchOut => 'Fetch Out';

  @override
  String get noBankConnected => 'No Bank Connected Yet';

  @override
  String get addBankAccount => 'ADD Your Bank Account';

  @override
  String get documents => 'Documents';

  @override
  String get transactions => 'Transactions';

  @override
  String get aadhaarCard => 'Aadhaar Card';

  @override
  String get bankPassbook => 'Bank Passbook';

  @override
  String get fds => 'FD\'s';

  @override
  String get encryptedNote => 'end-to-end encrypted';

  @override
  String get noTransactionsYet => 'No transactions available.';

  @override
  String get onlineComplainForm => 'Online Complain form';

  @override
  String get cyberCrimeNo => 'Cyber Crime no. 1930';

  @override
  String get lockUnlockBiometrics => 'Lock/Unlock Biometrics';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get couldNotLaunch => 'Could not launch';

  @override
  String get savingInvestmentSchemes => 'Savings and Investment Schemes';

  @override
  String get loanSchemes => 'Loan Schemes';

  @override
  String get pmJanDhanYojana => 'Pradhan Mantri Jan Dhan Yojana';

  @override
  String get nationalPensionSystem => 'National Pension System';

  @override
  String get kisanVikasPatra => 'Kisan Vikas Patra';

  @override
  String get seniorCitizenSavings => 'Senior Citizen Savings Scheme';

  @override
  String get textAudioVideo => 'text , audio , video';

  @override
  String get view => 'View';

  @override
  String get phishing => 'PHISHING';

  @override
  String get smishing => 'SMISHING';

  @override
  String get vishing => 'VISHING';

  @override
  String get otpScams => 'OTP Scams';

  @override
  String get skimming => 'Skimming';

  @override
  String get websiteSpoofing => 'Website Spoofing';

  @override
  String get verifierTitle => 'Number & Message Verifier';

  @override
  String get enterPhoneOrMessage => 'Please enter phone number or message ID';

  @override
  String get messageId => 'Message ID';

  @override
  String get scamScore => 'Scam Score';

  @override
  String get scamDetected => '🚨 Scam Detected!';

  @override
  String get safe => 'Safe';

  @override
  String get saveError => 'Failed to save result';

  @override
  String get enterPhoneNumber => 'Enter Phone Number';

  @override
  String get enterMessageId => 'Enter Message ID';

  @override
  String get verify => 'Verify';

  @override
  String get phoneVerifier => 'Phone Number Verifier';

  @override
  String get messageVerifier => 'Message Verifier';

  @override
  String get selectState => 'Select Your State';

  @override
  String get chooseBankState => 'Choose the state where your bank is located:';

  @override
  String get selectYourBank => 'Select Your Bank';

  @override
  String get availableBanks => 'Available Banks:';

  @override
  String get enterNewPhone => 'Enter new phone number';

  @override
  String get enterPhoneHint => 'Enter phone number';

  @override
  String get cancel => 'Cancel';

  @override
  String get okay => 'Okay';

  @override
  String get verifyBankNumber => 'Verify number with your bank';

  @override
  String get change => 'Change';

  @override
  String get phoneBankInfo => 'To facilitate your payment transactions, make sure this number is linked to your bank and SIM is on your device.';

  @override
  String get continueText => 'Continue';

  @override
  String get enterAmount => 'Enter amount';

  @override
  String get from => 'From';

  @override
  String get to => 'To';

  @override
  String get convert => 'Convert';

  @override
  String get convertedAmount => 'Converted Amount';

  @override
  String get principalAmount => 'Principal Amount';

  @override
  String get rateOfInterest => 'Rate of Interest (p.a)';

  @override
  String get timeYears => 'Time (in years)';

  @override
  String get calculateInterest => 'Calculate Interest';

  @override
  String get simpleInterest => 'Simple Interest';

  @override
  String get loanAmount => 'Loan Amount (₹)';

  @override
  String get interestRate => 'Interest Rate (p.a)';

  @override
  String get loanTenure => 'Loan Tenure (Years)';

  @override
  String get calculateEmi => 'Calculate EMI';

  @override
  String get yourEmi => 'Your EMI';

  @override
  String get emiFrequency => 'EMI Frequency';

  @override
  String get daily => 'Daily';

  @override
  String get weekly => 'Weekly';

  @override
  String get monthly => 'Monthly';

  @override
  String get yearly => 'Yearly';

  @override
  String get originalPrice => 'Original Price (₹)';

  @override
  String get discountPercentage => 'Discount (%)';

  @override
  String get calculate => 'Calculate';

  @override
  String get discountAmount => 'Discount Amount';

  @override
  String get finalPrice => 'Final Price';

  @override
  String get quizScreenTitle => 'Quiz Zone';

  @override
  String get recentQuiz => 'Recent Quiz';

  @override
  String get featured => 'Featured';

  @override
  String get featuredDescription => 'Take part in challenges\nenhance your knowledge';

  @override
  String get findFriends => 'Find Friends';

  @override
  String get liveQuizzes => 'Live Quizzes';

  @override
  String get seeAll => 'See All';

  @override
  String get loading => 'Loading...';

  @override
  String get score => 'Score';

  @override
  String get closeAll => 'Close All';

  @override
  String get phishingSimulation => 'Phishing Simulation';

  @override
  String get whatIsPhishing => 'What is Phishing?';

  @override
  String get phishingExplanation => 'Phishing is a type of cyberattack where criminals impersonate trusted organizations to trick you into revealing sensitive information such as passwords, credit card numbers, or personal details.';

  @override
  String get playAudio => 'Play Audio';

  @override
  String get simulation => 'Simulation';

  @override
  String get emailSubject => 'Urgent: Account Verification Required';

  @override
  String get emailBody => 'Dear Customer,\n\nWe noticed suspicious activity on your bank account. Please click the link below to verify your information immediately and avoid account suspension.\n\nThank you,\nYour Bank Security Team';

  @override
  String get clickLink => 'Click Link';

  @override
  String get reportPhishing => 'Report Phishing';

  @override
  String get correct => 'Correct!';

  @override
  String get incorrect => 'Incorrect';

  @override
  String get correctExplanation => 'Good job! You avoided a phishing attempt.';

  @override
  String get incorrectExplanation => 'Oops! That was a phishing link. Always verify before clicking.';

  @override
  String get gotIt => 'Got it';

  @override
  String get videoExplanation => 'Video Explanation';

  @override
  String get tipsTitle => 'Tips to Avoid Phishing Attacks';

  @override
  String get tipsContent => '• Always verify the sender’s email address.\n• Look out for spelling mistakes and generic greetings.\n• Never click on suspicious links.\n• Enable two-factor authentication on your accounts.\n• Report suspicious emails to your IT department or email provider.';

  @override
  String get smishingSimulation => 'Smishing Simulation';

  @override
  String get whatIsSmishing => 'What is Smishing?';

  @override
  String get smishingExplanation => 'Smishing is a type of phishing attack using SMS. Scammers send fake messages pretending to be from trusted organizations to steal your information.';

  @override
  String get smsMessage => 'SMS Message';

  @override
  String get smsBody => 'Your bank account is suspended. Click the link to verify immediately: http://fakebank.com';

  @override
  String get reportSmishing => 'Report Smishing';

  @override
  String get vishingDescription => 'Vishing is a type of scam where fraudsters call you pretending to be from a trusted organization to steal sensitive information like bank details or OTPs.';

  @override
  String get playVideo => 'Play Video';

  @override
  String get pauseVideo => 'Pause Video';

  @override
  String get simulateVishingCall => 'Simulate Vishing Call';

  @override
  String get incomingCall => 'Incoming Call';

  @override
  String get calling => 'Calling…';

  @override
  String get endCall => 'End Call';

  @override
  String get vishingFakeCallLine => 'Hello, this is your bank calling regarding suspicious activity.';

  @override
  String get pauseAudio => 'Pause Audio';

  @override
  String get couldNotLaunchPhone => 'Could not open phone dialer.';

  @override
  String get couldNotLaunchWhatsapp => 'Could not open WhatsApp.';

  @override
  String get setAsProfilePicture => 'Set as profile picture?';

  @override
  String get done => 'Done';

  @override
  String shieldStatus(String state, Object status) {
    return 'Shield is currently $status';
  }

  @override
  String get callWarning => 'Incoming unknown number call detected!';

  @override
  String get callFromUnknown => 'Call from unknown number';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get reportCaller => 'Report this caller?';

  @override
  String get scam => 'SCAM';

  @override
  String get misbehavior => 'Misbehavior';

  @override
  String get robocall => 'Robocall';

  @override
  String get promotional => 'Promotional Call';

  @override
  String get submit => 'Submit';

  @override
  String get shieldOn => 'Shield is activated';

  @override
  String get shieldOff => 'Shield is deactivated';

  @override
  String get otpScam => 'OTP SCAM';

  @override
  String get otpScamDescription => 'OTP scams involve fraudsters tricking you into sharing a one-time password sent to your phone, allowing them unauthorized access.';

  @override
  String get simulateOtpScam => 'Simulate OTP Scam';

  @override
  String get otpScamSimulation => 'OTP Scam Simulation';

  @override
  String get otpScamSimulationInfo => 'Experience how OTP scams work in real-time. Stay alert, stay safe!';

  @override
  String get fakeBankMessage => 'Fake Message from Bank';

  @override
  String get otpScamMessageExample => 'Your account will be blocked. Share the OTP \'907643\' sent to you to keep it active.';

  @override
  String get enterOtpHere => 'Enter OTP';

  @override
  String get audioExplainsScam => 'This audio explains how scammers trap you into revealing your OTP.';

  @override
  String get watchHowScamWorks => 'Watch how this scam works in the video below.';

  @override
  String get scamAlertTitle => 'Scam Alert!';

  @override
  String get scamAmountDebited => 'INR 49,999 has been debited from your account ****3456.';

  @override
  String get scamWarning => 'NEVER share your OTP with anyone. Even your bank will never ask for it. otherwise this will happen So be Educated and Safe';

  @override
  String get ok => 'OK';

  @override
  String get skimmingScamSimulation => 'Skimming Scam Simulation';

  @override
  String get skimmingScamInfo => 'Skimming is a method used by criminals to capture data from the magnetic stripe on credit and debit cards.';

  @override
  String get fakeATMScreenTitle => 'ATM Machine';

  @override
  String get fakeATMInstruction => 'Please insert your card and enter PIN.';

  @override
  String get enterYourPIN => 'Enter your PIN';

  @override
  String get audioExplainsSkimming => 'This audio explains how skimming scams work. Listen carefully.';

  @override
  String get watchHowSkimmingWorks => 'Watch How Skimming Works';

  @override
  String get skimmingDetectedWarning => '⚠️ Warning: Your PIN might be being recorded via a hidden camera!';

  @override
  String get insertCardToProceed => 'Tap the ATM card slot to insert your card.';

  @override
  String get okayButtonText => 'OK';

  @override
  String get yourDetailsCapturedTitle => 'Your ATM details have been captured!';

  @override
  String get capturedCardNumberLabel => 'Card Number';

  @override
  String get capturedPinLabel => 'PIN';

  @override
  String get howToRecognizeSkimming => 'How to Recognize Skimming:';

  @override
  String get tipCheckCardSlot => 'Check for loose card slot or hidden devices.';

  @override
  String get tipCoverPin => 'Always cover your PIN when entering it.';

  @override
  String get tipReportSuspicious => 'Report suspicious ATMs immediately.';

  @override
  String get websiteSpoofingSimulation => 'Website Spoofing Simulation';

  @override
  String get websiteSpoofingInfo => 'Website spoofing involves fake sites imitating real ones to steal your data. Learn how to spot them.';

  @override
  String get enterFakeBankDetails => 'Enter credentials on this suspicious site to simulate the spoofing.';

  @override
  String get enterUsername => 'Username';

  @override
  String get enterPassword => 'Password';

  @override
  String get fakeWebsiteWarning => 'Warning! This is a spoofed website. Never enter credentials on suspicious URLs.';

  @override
  String get audioExplainsSpoofing => 'This audio explains how fake websites try to trick you into entering credentials.';

  @override
  String get watchSpoofingDemo => 'Watch how website spoofing works';

  @override
  String get fakeUrl => '(Fake URL)';

  @override
  String get misspelledDomainExample => 'Fake URLs often contain typos like \'yourb4nk\' instead of \'yourbank\'.';

  @override
  String get whyThisIsFake => 'Why is this website fake?';

  @override
  String get lookForHttps => 'Always check if the URL starts with HTTPS and has a padlock.';

  @override
  String get realDomainExample => 'Real URL';

  @override
  String get changePhoneNumber => 'Change Phone Number';

  @override
  String get enterNewPhoneNumber => 'Enter New Number';

  @override
  String get terms => 'Terms & Conditions';

  @override
  String get balance => 'Balance';

  @override
  String get noBankSynced => 'No bank account is synced yet.';

  @override
  String get aadhaarStatus => 'Aadhaar Linked';

  @override
  String get viewPassbook => 'View Passbook';

  @override
  String get notFound => 'Not Found';

  @override
  String get noBankData => 'No Bank Data';

  @override
  String get refreshBalance => 'Refresh Balance';

  @override
  String get downloadStatement => 'Download Statemen';

  @override
  String get noBank => 'No Bank Data';

  @override
  String get rewardsTitle => 'Rewards';

  @override
  String get points => 'Points';

  @override
  String get ptsShort => 'pts';

  @override
  String get claim => 'Claim';

  @override
  String get alreadyClaimed => 'You already claimed this task!';

  @override
  String get pointsClaimed => 'Points claimed successfully!';

  @override
  String get leaderboardTitle => 'Leaderboard';

  @override
  String get completeTask => 'Complete Task';

  @override
  String get errorLoadingTasks => 'Failed to load tasks. Please try again.';

  @override
  String get errorStartingTask => 'Failed to start task. Please try again.';

  @override
  String get errorResumingTask => 'Failed to resume task. Please try again.';

  @override
  String get taskStarted => 'Task started! Complete it to earn points.';

  @override
  String get videoUrlNotAvailable => 'Video URL not available for this task.';

  @override
  String get openingVideo => 'Opening video...';

  @override
  String get cannotOpenVideoUrl => 'Cannot open video URL. Please try again.';

  @override
  String get errorOpeningVideo => 'Error opening video';

  @override
  String get videoCompleted => 'Video Completed?';

  @override
  String get finishedWatchingVideo => 'Have you finished watching the video?';

  @override
  String get notYet => 'Not Yet';

  @override
  String get yesCompleted => 'Yes, Completed!';

  @override
  String get shareAppMessage => '🛡️ Stay Safe from Online Scams! 🛡️\n\nDownload this amazing scam awareness app and protect yourself from:\n✅ Fake calls & Digital Arrests\n✅ OTP Scams & Phishing\n✅ Investment Frauds\n✅ Deepfake Videos\n\nDownload now and stay protected!\n\n#CyberSafety #ScamAlert #DigitalSafety';

  @override
  String shareTaskCompleted(Object count) {
    return 'Great! You\'ve shared the app $count times!';
  }

  @override
  String shareRemaining(Object count) {
    return 'Shared! $count more shares needed to complete this task.';
  }

  @override
  String get errorSharing => 'Error sharing. Please try again.';

  @override
  String get shareManually => 'Share Manually';

  @override
  String get textCopiedToClipboard => 'The share text has been copied to your clipboard!';

  @override
  String get pasteAndShare => 'Please paste and share it manually on:';

  @override
  String get shareOptions => '• WhatsApp\n• Instagram\n• Facebook\n• SMS\n• Email';

  @override
  String get failedToCopyToClipboard => 'Failed to copy to clipboard';

  @override
  String get quizUrlNotAvailable => 'Quiz URL not available for this task.';

  @override
  String get openingQuiz => 'Opening quiz...';

  @override
  String get cannotOpenQuizUrl => 'Cannot open quiz URL. Please try again.';

  @override
  String get errorOpeningQuiz => 'Error opening quiz';

  @override
  String get quizCompleted => 'Quiz Completed?';

  @override
  String get finishedQuizSuccessfully => 'Have you finished the quiz successfully?';

  @override
  String get dailyCheckinCompleted => 'Daily check-in completed!';

  @override
  String get taskCompletedCanClaim => 'Task completed! You can now claim your reward.';

  @override
  String get errorClaimingReward => 'Failed to claim reward. Please try again.';

  @override
  String get congratulations => 'Congratulations!';

  @override
  String earnedPoints(Object points) {
    return 'You earned $points points!';
  }

  @override
  String get awesome => 'Awesome!';

  @override
  String get error => 'Error';

  @override
  String get startTask => 'Start Task';

  @override
  String get inProgress => 'In Progress...';

  @override
  String get continueTask => 'Continue';

  @override
  String get incomplete => 'Incomplete';

  @override
  String get pts => 'pts';

  @override
  String get completed => 'Completed';

  @override
  String get incompleteTask => 'Incomplete Task';

  @override
  String get markTaskIncomplete => 'Are you sure you want to mark this task as incomplete? All progress will be lost.';

  @override
  String get markIncomplete => 'Mark Incomplete';

  @override
  String get taskMarkedIncomplete => 'Task marked as incomplete. You can start it again.';

  @override
  String get noTasksAvailable => 'No Tasks Available Yet';

  @override
  String get newTasksAddedSoon => 'New tasks will be added soon.\nCheck back later!';

  @override
  String get refresh => 'Refresh';

  @override
  String get yourProgress => 'Your Progress';

  @override
  String get loadingTasks => 'Loading tasks...';

  @override
  String get min => 'min';

  @override
  String get showLess => 'Show Less';

  @override
  String get spamAlert => 'SPAM ALERT';

  @override
  String get suspiciousCallDetected => 'Suspicious call detected from:';

  @override
  String get warning => 'WARNING';

  @override
  String get spamWarningMessage => 'This number matches known spam patterns. Be extremely careful before answering.';

  @override
  String get block => 'BLOCK';

  @override
  String get allow => 'ALLOW';

  @override
  String get callBlocked => 'Call blocked';

  @override
  String get callAllowed => 'Call allowed';

  @override
  String get deactivateShield => 'Deactivate Shield';

  @override
  String get phonePermissionRequired => 'Phone permission is required';

  @override
  String get monitoringStartFailed => 'Could not start monitoring';

  @override
  String get shieldActivatedSuccess => 'MShield activated successfully!';

  @override
  String get activationFailed => 'Activation failed';

  @override
  String get monitoringActive => 'Monitoring is now active';

  @override
  String get spamCallBlocked => 'Spam call blocked';

  @override
  String get shieldDeactivated => 'MShield deactivated';

  @override
  String get deactivationError => 'Deactivation error';

  @override
  String get realTimeDetectionAndBlocker => 'Real Time Detection and Blocker';

  @override
  String get fakeBankOfficer => 'Bank Officer (Fake)';

  @override
  String get connected => 'Connected at';

  @override
  String get safetyTipsTitle => 'How to Stay Safe from Vishing';

  @override
  String get noShareOTP => 'Never share your OTP or PIN with anyone.';

  @override
  String get verifyCallerID => 'Always verify the caller’s identity on official channels.';

  @override
  String get callBackOfficial => 'Hang up and call the bank’s official number yourself.';

  @override
  String get reportScam => 'Scam';

  @override
  String get learnMore => 'Learn more about scam prevention';

  @override
  String get game => 'Scam Runner';

  @override
  String get tips => 'Finance Tips';

  @override
  String get tip => 'M.Tips';

  @override
  String get emergency_fund => 'Emergency Fund';

  @override
  String get stock_basics => 'Stock Basics';

  @override
  String get long_term_growth => 'Long-Term Growth';

  @override
  String get budgeting_101 => 'Budgeting 101';

  @override
  String get retirement_plan => 'Retirement Plan';

  @override
  String get learn_more => 'Learn More';

  @override
  String get savings_tips_category => 'Savings Tips';

  @override
  String get stock_market_tips_category => 'Stock Market Tips';

  @override
  String get tip_title => 'Start an Emergency Fund';

  @override
  String get tip_description => 'Save at least 3-6 months of expenses in a high-yield account.';

  @override
  String get income_level => 'Lower Class';

  @override
  String get financial_category => 'Saving';

  @override
  String get risk_tolerance => 'Low';

  @override
  String get priority => 'Priority';

  @override
  String get region_specific => 'Rural';

  @override
  String get translate => 'Translate';

  @override
  String get appTitle => 'Financial Tips Finder';

  @override
  String get personalInfoTitle => 'Personal Information';

  @override
  String get personalInfoSubtitle => 'Tell us about yourself';

  @override
  String get financialPreferencesTitle => 'Financial Preferences';

  @override
  String get financialPreferencesSubtitle => 'What are you looking for?';

  @override
  String get askQuestionTitle => 'Ask a Question';

  @override
  String get askQuestionSubtitle => 'Get personalized advice (optional)';

  @override
  String get incomeLevel => 'Income Level';

  @override
  String get ageGroup => 'Age Group';

  @override
  String get occupation => 'Occupation';

  @override
  String get region => 'Region';

  @override
  String get category => 'Category';

  @override
  String get riskTolerance => 'Risk Tolerance';

  @override
  String get lowerClass => 'Lower Class';

  @override
  String get middleClass => 'Middle Class';

  @override
  String get upperClass => 'Upper Class';

  @override
  String get age18to25 => '18-25';

  @override
  String get age25to45 => '25-45';

  @override
  String get age45to60 => '45-60';

  @override
  String get age60plus => '60+';

  @override
  String get farmer => 'Farmer';

  @override
  String get salaried => 'Salaried';

  @override
  String get business => 'Business';

  @override
  String get student => 'Student';

  @override
  String get urban => 'Urban';

  @override
  String get rural => 'Rural';

  @override
  String get saving => 'Saving';

  @override
  String get investment => 'Investment';

  @override
  String get debtManagement => 'Debt Management';

  @override
  String get low => 'Low';

  @override
  String get medium => 'Medium';

  @override
  String get high => 'High';

  @override
  String get questionHint => 'e.g., How can I start investing with ₹1000?';

  @override
  String get findTips => 'Find Tips';

  @override
  String get searching => 'Searching...';

  @override
  String get yourTipsTitle => 'Your Financial Tips';

  @override
  String tipsFound(Object count) {
    return '$count tips found';
  }

  @override
  String get noTipsFound => 'No tips found';

  @override
  String get tryDifferentFilters => 'Try different filters or ask a specific question';

  @override
  String get errorMessage => 'Unable to fetch tips. Please check your connection and try again.';

  @override
  String get qrSafetyScanner => 'QR Safety Scanner';

  @override
  String get scanComplete => 'Scan Complete';

  @override
  String get checkResultsBelow => 'Check results below';

  @override
  String get pointCameraAtQR => 'Point camera at QR code';

  @override
  String get readyToScan => 'Ready to Scan';

  @override
  String get positionQRCode => 'Position QR code within the frame';

  @override
  String get startScanning => 'Start Scanning';

  @override
  String get scanResult => 'Scan Result';

  @override
  String get scanAgain => 'Scan Again';

  @override
  String get rawQRContent => 'Raw QR Content';

  @override
  String get parsedFields => 'Parsed Fields';

  @override
  String get notProvided => 'Not provided';

  @override
  String get copiedUPIID => 'Copied UPI ID';

  @override
  String get analysisAdvice => 'Analysis & Advice';

  @override
  String get noRedFlags => 'No red flags found.';

  @override
  String get securityTips => 'Security Tips';

  @override
  String get safetyTipsList => '• Confirm UPI ID with the payee before paying\n• Avoid paying to shortened URLs or external links\n• Never share OTPs or UPI PINs\n• If uncertain, verify through official channels';

  @override
  String get verificationResult => 'Verification Result';

  @override
  String get qrScanner => 'QR Checker';

  @override
  String get scamRunnerTitle => 'SCAM RUNNER';

  @override
  String get tapToJump => 'TAP TO JUMP';

  @override
  String get holdToChargeJump => 'HOLD TO CHARGE JUMP';

  @override
  String get avoidScams => 'AVOID SCAMS!';

  @override
  String get tapToStart => 'TAP TO START';

  @override
  String get gameOver => 'G A M E  O V E R';

  @override
  String get scoreLabel => 'SCORE';

  @override
  String get highLabel => 'HIGH';

  @override
  String get tapToRestart => 'TAP TO RESTART';

  @override
  String get fake => 'FAKE';

  @override
  String get fraud => 'FRAUD';

  @override
  String get spam => 'SPAM';

  @override
  String get kycScam => 'KYC SCAM';

  @override
  String get investmentScam => 'INVESTMENT';

  @override
  String get loanScam => 'LOAN SCAM';

  @override
  String get jobScam => 'JOB SCAM';

  @override
  String get romanceScam => 'ROMANCE';

  @override
  String get qrScam => 'QR SCAM';

  @override
  String get screenShareScam => 'SCREEN SHARE';

  @override
  String get malware => 'MALWARE';

  @override
  String get muleAccount => 'MULE ACCOUNT';

  @override
  String get cyberCrime => 'CYBER CRIME';

  @override
  String get dataTheft => 'DATA THEFT';

  @override
  String get identityTheft => 'IDENTITY';

  @override
  String get onlineFraud => 'ONLINE FRAUD';

  @override
  String get cryptoScam => 'CRYPTO';

  @override
  String get impersonation => 'FAKE CALL';

  @override
  String get techSupport => 'TECH SUPPORT';

  @override
  String get audioNotAvailable => 'Audio not available';

  @override
  String get stopAudio => 'Stop Audio';

  @override
  String get toLabel => 'To';

  @override
  String get indUrgent => 'Urgent language used';

  @override
  String get indSender => 'Suspicious sender address';

  @override
  String get indSpelling => 'Spelling and grammar errors';

  @override
  String get indGreeting => 'Generic greeting';

  @override
  String get indLink => 'Suspicious link';

  @override
  String get suspiciousIndicatorTitle => 'Suspicious Indicators';

  @override
  String get securityWarning => 'Warning! You clicked on a suspicious link. In real life, this could compromise your personal data. Always verify before clicking any links.';

  @override
  String get videoNotAvailable => 'Video not available';

  @override
  String get restartVideo => 'Restart Video';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String get verificationLinkSent => 'A verification link has been sent to your email';

  @override
  String get verifyEmailInstruction => 'Please verify your email before proceeding.';

  @override
  String get emailNotVerified => 'Email is not verified yet.';

  @override
  String get resendVerification => 'Resend verification email';

  @override
  String get startSimulation => 'Start Simulation';

  @override
  String get tipUseTrustedATMs => 'Use ATMs in safe locations or bank branches';

  @override
  String get tipMonitorBankStatements => 'Regularly monitor your bank statements';

  @override
  String get fakeMirroringPanel => 'Mirroring Panel (Fake Display)';

  @override
  String get noVideoAvailable => 'No video available.';

  @override
  String get infoTab => 'Info';

  @override
  String get stolenDetailsTab => 'Your Details';

  @override
  String get detailsStolenWarning => '⚠ Your details have been stolen! ⚠';

  @override
  String get noUserData => 'No user data available.';

  @override
  String get clickHereToLogin => 'Click here to login';

  @override
  String get howToRecognizeScam => 'How to Recognize an OTP Scam';

  @override
  String get tip1 => 'Check the sender’s email address carefully.';

  @override
  String get tip2 => 'Look for grammar or spelling mistakes.';

  @override
  String get tip3 => 'Hover over links to see the real URL.';

  @override
  String get tip4 => 'If in doubt, call your bank\'s official helpline immediately.';

  @override
  String get newMessageReceived => '📩 You have received a new message. Tap to view.';

  @override
  String get smsTime => 'Today, 10:45 AM';

  @override
  String get tipsToRecognize => 'Tips to recognize phishing emails:';

  @override
  String get suspiciousLinkTitle => 'Suspicious Link Detected';

  @override
  String get suspiciousLinkMessage => 'The link you clicked looks suspicious. Do not enter any personal information.';

  @override
  String get close => 'Close';

  @override
  String get learnHow => 'Learn how to check links';

  @override
  String get linkTipsTitle => 'How to Recognize Dangerous Links';

  @override
  String get linkTip1 => 'Avoid clicking unknown links from emails.';

  @override
  String get linkTip2 => 'Check if the website address is spelled correctly.';

  @override
  String get linkTip3 => 'Be cautious with shortened URLs.';

  @override
  String get smsBodyBeforeLink => 'Your bank account is suspended. Click here: ';

  @override
  String get smsBodyAfterLink => ' to verify immediately.';

  @override
  String get verifyWithMShield => 'Verify suspicious links with M-Shield for safety.';

  @override
  String get openMShield => 'Open M-Shield';

  @override
  String get simulationTitle => 'Phishing Simulation';

  @override
  String get inboxSubjectLine => 'Bank Security Notice';

  @override
  String get inboxPreviewText => 'Important: Verify your account immediately...';

  @override
  String get emailSenderName => 'SecureBank Support';

  @override
  String get emailSenderAddress => 'support@securebank-alerts.com';

  @override
  String get emailBodyIntro => 'Dear Customer,\n\nWe detected unusual login attempts on your account. For your safety, please verify your details immediately by clicking the secure link below:\n\n';

  @override
  String get verifyAccountLinkText => 'Verify My Account';

  @override
  String get emailBodyOutro => '\n\nFailure to verify may result in temporary account suspension.\n\nSincerely,\nSecureBank Security Team';

  @override
  String get suspiciousLinkDescription => 'This link may be part of a phishing attempt. Cybercriminals often use fake websites to steal your login details or personal information.';

  @override
  String get howToRecognizeTitle => 'How to Recognize a Fake Email:';

  @override
  String get tipCheckEmailAddress => 'Check the sender’s email address carefully.';

  @override
  String get tipGrammarMistakes => 'Look for grammar mistakes or urgent threats.';

  @override
  String get tipHoverOverLinks => 'Hover over links to see the real destination.';

  @override
  String get tipNoPasswordRequests => 'Legitimate companies rarely ask for passwords via email.';

  @override
  String get mitraShieldAdvice => 'Mitra Shield: Always verify suspicious messages before clicking links or entering sensitive information.';

  @override
  String get openMitraShield => 'Open Mitra Shield';

  @override
  String get newEmailReceived => 'New email received';

  @override
  String get emailTime => '2 hours ago';

  @override
  String get emailBodyBeforeLink => 'We noticed unusual activity. Please verify your account immediately by visiting ';

  @override
  String get emailBodyAfterLink => '. If you do not verify, your account will be suspended.';

  @override
  String get tapToOpen => 'Tap to open';

  @override
  String get subjectLine => 'Suspicious activity detected on your account';

  @override
  String get vishingTitle => 'Vishing Scam';

  @override
  String get vishingHeader => 'Beware of Vishing Calls';

  @override
  String get audioExplanation => 'Audio Explanation';

  @override
  String get mshieldTitle => 'MShield';

  @override
  String get popupReportCall => 'Report Call';

  @override
  String get popupViewReports => 'View Reports';

  @override
  String get shieldActivating => 'Activating...';

  @override
  String get shieldActivate => 'Activate Shield';

  @override
  String get shieldActivated => 'Shield Activated';

  @override
  String get autoCallBlock => 'Call Block';

  @override
  String get autoOtpBlock => 'OTP Block';

  @override
  String get shieldActiveMsg => 'Your MShield is actively protecting you.';

  @override
  String get shieldInactiveMsg => 'Activate MShield to stay protected.';

  @override
  String get reportDialogTitle => 'Report Suspicious Call';

  @override
  String get reportPhoneNumber => 'Phone Number';

  @override
  String get reportCategory => 'Category';

  @override
  String get reportDetails => 'Details';

  @override
  String get reportSubmitted => 'Report submitted successfully ✅';

  @override
  String get reportsTitle => 'Reports';

  @override
  String get noReports => 'No reports available.';

  @override
  String get reportMisguiding => 'Misguiding';

  @override
  String get reportMisbehaviour => 'Misbehaviour';

  @override
  String get reportSpam => 'Spam';

  @override
  String get mshieldAlertTitle => 'MShield Alert';

  @override
  String get mshieldWarningMsg => 'Be careful while talking. Unknown caller may attempt suspicious activity.';

  @override
  String get reportNotificationTitle => 'Report Suspicious Call';

  @override
  String get reportNotificationBody => 'If you found any suspicious activity you can report it here.';

  @override
  String get incomingCallWarning => 'Be careful while talking. Unknown caller may attempt suspicious activity.';

  @override
  String get reportNotificationMsg => 'If you found any suspicious activity you can report it here.';

  @override
  String get categoryScam => 'Scam';

  @override
  String get categoryMisguiding => 'Misguiding';

  @override
  String get categoryMisbehaviour => 'Misbehaviour';

  @override
  String get categorySpam => 'Spam';

  @override
  String get reportTitle => 'Report a Call';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get details => 'Details';

  @override
  String get reportSuccess => 'Report submitted successfully!';

  @override
  String get reportCall => 'Report Call';

  @override
  String get viewReports => 'View Reports';

  @override
  String get feedbackTitle => 'Feedback';

  @override
  String get feedbackHeading => 'We value your feedback 💬';

  @override
  String get feedbackSubHeading => 'Tell us what you think about our app. Your feedback helps us improve!';

  @override
  String get feedbackHint => 'Type your feedback here...';

  @override
  String get submitting => 'Submitting...';

  @override
  String get enterFeedback => 'Please enter feedback before submitting';

  @override
  String get feedbackSuccess => '✅ Feedback submitted successfully!';

  @override
  String get feedbackFail => '❌ Failed to submit feedback:';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get appNotifications => 'App Notifications';

  @override
  String get appNotificationsDesc => 'Receive important alerts and updates';

  @override
  String get promotionalMessages => 'Promotional Messages';

  @override
  String get promotionalMessagesDesc => 'Get offers, tips, and promotions';

  @override
  String get helpSupportTitle => 'Help & Support';

  @override
  String get faqs => 'FAQs';

  @override
  String get faqsDesc => 'Find answers to common questions';

  @override
  String get contactUsDesc => 'Reach out for support';

  @override
  String get emailSupport => 'Email Support';

  @override
  String get callSupport => 'Call Support';

  @override
  String get faq1Q => 'How can I reset my password?';

  @override
  String get faq1A => 'You can reset your password by going to the Login screen and selecting \'Forgot Password\'.';

  @override
  String get faq2Q => 'How do I contact support?';

  @override
  String get faq2A => 'You can contact our support team via email at support@myapp.com or call us at +91 7696481976.';

  @override
  String get termsTitle => 'Terms & Policies';

  @override
  String get termsHeading => 'Our Commitment to You';

  @override
  String get termsPoint1 => 'MyMitra is designed to provide you safe, reliable and secure digital financial awareness.';

  @override
  String get termsPoint2 => 'We never ask for your passwords, OTPs, or confidential banking details.';

  @override
  String get termsPoint3 => 'All your personal information is stored securely and never shared without your consent.';

  @override
  String get termsPoint4 => 'The app content is for educational and awareness purposes. Use your judgment before financial actions.';

  @override
  String get termsPoint5 => 'We may send important updates, but you can control notification preferences anytime.';

  @override
  String get termsPoint6 => 'By using MyMitra, you agree to use it responsibly and respect community guidelines.';

  @override
  String get termsThanks => 'Thank you for trusting MyMitra!';
}
