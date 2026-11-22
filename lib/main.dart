import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_colors.dart';
import 'core/services/storage_service.dart';
import 'features/onboarding/welcome_screen.dart';
import 'features/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style matching Stitch warm canvas theme
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize offline curriculum and persistent user progress
  await StorageService().init();

  runApp(const UzoApp());
}

class UzoApp extends StatelessWidget {
  const UzoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // If the user already completed lessons or has progress, start at HomeScreen, otherwise WelcomeScreen
    final hasExistingProgress = StorageService().userProfile.completedLessonIds.length > 1;

    return MaterialApp(
      title: 'Ụzọ',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: hasExistingProgress ? const HomeScreen() : const WelcomeScreen(),
    );
  }
}
