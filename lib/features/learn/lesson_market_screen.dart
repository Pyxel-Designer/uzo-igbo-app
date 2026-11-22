import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/audio_service.dart';
import '../../core/services/storage_service.dart';
import '../../shared/widgets/tactile_button.dart';
import 'lesson_complete_screen.dart';

class LessonMarketScreen extends StatefulWidget {
  const LessonMarketScreen({super.key});

  @override
  State<LessonMarketScreen> createState() => _LessonMarketScreenState();
}

class _LessonMarketScreenState extends State<LessonMarketScreen> {
  int _dialogueStep = 0;

  final List<Map<String, dynamic>> _dialogueSteps = [
    {
      "speaker": "You (Buyer)",
      "igbo": "Ego ole ka nke a bụ?",
      "english": "How much is this one?",
      "options": [
        "Ego ole ka nke a bụ?",
        "Kedu aha gị?",
        "Aha m bụ Chidi",
      ],
      "correct": 0,
      "audio": "assets/audio/ego_ole.mp3",
    },
    {
      "speaker": "Vendor (Mama Chinedu)",
      "igbo": "Ọ bụ puku naịra abụọ (₦2,000).",
      "english": "It is two thousand naira.",
      "isVendor": true,
      "tip": "Tip: In Igbo markets, never accept the first quoted price! Polite bargaining shows cultural savvy.",
    },
    {
      "speaker": "You (Buyer)",
      "igbo": "Biko, belata ọnụ ahịa ya!",
      "english": "Please, reduce the price!",
      "options": [
        "Biko, belata ọnụ ahịa ya!",
        "Ọ dị oke ọnụ!",
        "Nnọọ nwanne",
      ],
      "correct": 0,
    },
    {
      "speaker": "Vendor (Mama Chinedu)",
      "igbo": "Weta puku naịra na narị ise (₦1,500).",
      "english": "Bring one thousand five hundred naira (Deal!).",
      "isVendor": true,
      "deal": true,
    },
  ];

  void _nextStep() {
    if (_dialogueStep < _dialogueSteps.length - 1) {
      setState(() {
        _dialogueStep++;
      });
    } else {
      StorageService().completeLesson("lesson_2_1", 35);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LessonCompleteScreen(
            lessonTitle: "Ịjụ Ọnụ Ahịa na Ahịa Ogbete",
            earnedXp: 35,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = _dialogueSteps[_dialogueStep];
    final bool isVendor = step['isVendor'] == true;

    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        title: const Text(
          "Ahịa Ogbete • Ịjụ Ọnụ Ahịa",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Market Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.secondary.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.storefront_rounded, color: AppColors.secondary, size: 24),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Enugu • Ogbete Main Market",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.secondaryDark),
                        ),
                        Text(
                          "Step ${_dialogueStep + 1} of ${_dialogueSteps.length}",
                          style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Dialogue Speech Bubble
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isVendor ? AppColors.secondary : AppColors.primary,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: isVendor ? AppColors.secondary : AppColors.primary,
                          child: Icon(
                            isVendor ? Icons.person_pin_rounded : Icons.account_circle_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          step['speaker'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: isVendor ? AppColors.secondaryDark : AppColors.primaryDark,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.volume_up_rounded, color: AppColors.primary),
                          onPressed: () {
                            AudioService().playAudio(step['audio'] ?? "assets/audio/default.mp3");
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      step['igbo'] as String,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      step['english'] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (step['tip'] != null) ...[
                      const Divider(height: 24),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.canvas,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          step['tip'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const Spacer(),

              // Next / Action Button
              TactileButton(
                label: _dialogueStep == _dialogueSteps.length - 1
                    ? "Kwekọrịtara! (Agreement Reached • Done)"
                    : "Gaa n'ihu n'ahịa (Continue Bargaining)",
                width: double.infinity,
                style: isVendor ? TactileButtonStyle.secondary : TactileButtonStyle.primary,
                onPressed: _nextStep,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
