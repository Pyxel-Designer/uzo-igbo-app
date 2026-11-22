import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/audio_service.dart';
import '../../core/services/storage_service.dart';
import '../../shared/widgets/tactile_button.dart';
import 'lesson_complete_screen.dart';

class LessonSpeakingScreen extends StatefulWidget {
  const LessonSpeakingScreen({super.key});

  @override
  State<LessonSpeakingScreen> createState() => _LessonSpeakingScreenState();
}

class _LessonSpeakingScreenState extends State<LessonSpeakingScreen>
    with SingleTickerProviderStateMixin {
  bool _isListening = false;
  bool _hasSpoken = false;
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _toggleMic() {
    if (_isListening) {
      _animController.stop();
      setState(() {
        _isListening = false;
        _hasSpoken = true;
      });
      StorageService().completeLesson("lesson_1_2", 25);
    } else {
      _animController.repeat(reverse: true);
      setState(() {
        _isListening = true;
      });

      // Simulate 2.5s speech input
      Future.delayed(const Duration(milliseconds: 2400), () {
        if (mounted) {
          _animController.stop();
          setState(() {
            _isListening = false;
            _hasSpoken = true;
          });
          StorageService().completeLesson("lesson_1_2", 25);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        title: const Text(
          "Ihe Mmụta 2 • Ikpe Okwu",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Target Dialogue Card
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.border, width: 1.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.tertiary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "SAY IT IN IGBO",
                                style: TextStyle(
                                  color: AppColors.tertiary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.volume_up_rounded, color: AppColors.primary),
                              onPressed: () {
                                AudioService().playAudio("assets/audio/kedu.mp3");
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "\"Adị m mma, daalụ\"",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Meaning: I am fine, thank you",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Phonetic: Ah-dee m mm-ah, dah-loo",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Microphone Action Hub
                  AnimatedBuilder(
                    animation: _animController,
                    builder: (context, child) {
                      final scale = 1.0 + (_animController.value * 0.15);
                      return GestureDetector(
                        onTap: _toggleMic,
                        child: Container(
                          width: 100 * scale,
                          height: 100 * scale,
                          decoration: BoxDecoration(
                            color: _isListening ? AppColors.secondary : AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _isListening ? AppColors.secondaryDark : AppColors.primaryDark,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: (_isListening ? AppColors.secondary : AppColors.primary)
                                    .withOpacity(0.35),
                                blurRadius: 20,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Icon(
                            _isListening ? Icons.mic_rounded : Icons.mic_none_rounded,
                            color: Colors.white,
                            size: 44,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _isListening
                        ? "Na-ege ntị... (Listening to your pronunciation)"
                        : (_hasSpoken
                            ? "Ọ dị mma nke ukwuu! (98% Tone Accuracy)"
                            : "Kpatụ igwe okwu ka i kwuo (Tap mic to speak)"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _hasSpoken ? AppColors.success : AppColors.textDark,
                    ),
                  ),
                ],
              ),

              // Bottom Button
              TactileButton(
                label: _hasSpoken ? "Gaa n'ihu (Continue)" : "Mee ya nwayọ (Practice later)",
                width: double.infinity,
                style: _hasSpoken ? TactileButtonStyle.secondary : TactileButtonStyle.ghost,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LessonCompleteScreen(
                        lessonTitle: "Ịza Ekele",
                        earnedXp: 25,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
