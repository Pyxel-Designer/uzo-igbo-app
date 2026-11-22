import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/audio_service.dart';
import '../../core/services/storage_service.dart';
import '../../shared/widgets/tactile_button.dart';
import 'lesson_complete_screen.dart';

class LessonListeningScreen extends StatefulWidget {
  const LessonListeningScreen({super.key});

  @override
  State<LessonListeningScreen> createState() => _LessonListeningScreenState();
}

class _LessonListeningScreenState extends State<LessonListeningScreen> {
  int? _selectedOptionIndex;
  bool _hasChecked = false;
  bool _isCorrect = false;

  final String _phraseIgbo = "Ụtụtụ ọma";
  final String _phonetic = "Oo-too-too oh-mah";
  final String _toneBreakdown = "High • High • High • Low";

  final List<String> _options = [
    "Good morning",
    "Good night",
    "Welcome to my home",
    "How is your family?",
  ];

  final int _correctIndex = 0;

  void _checkAnswer() {
    setState(() {
      _hasChecked = true;
      _isCorrect = _selectedOptionIndex == _correctIndex;
    });

    if (_isCorrect) {
      StorageService().completeLesson("lesson_1_1", 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        title: const Text(
          "Ihe Mmụta 1 • Ekele",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.diamond_rounded, color: AppColors.primary, size: 16),
                SizedBox(width: 4),
                Text("+20 XP", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryDark, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Audio Playback Pill Hero
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.border, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Speaker Button
                    GestureDetector(
                      onTap: () {
                        AudioService().playAudio("assets/audio/ututu_oma.mp3");
                      },
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primaryDark, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryDark.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.volume_up_rounded, color: Colors.white, size: 32),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Igbo Target Phrase (With correct diacritics)
                    Text(
                      _phraseIgbo,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                        letterSpacing: -0.02,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Pronunciation: $_phonetic",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.tertiary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Tone: $_toneBreakdown",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.tertiary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              const Text(
                "Gịnị ka nke a pụtara na Bekee? (What does this mean?)",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textDark),
              ),
              const SizedBox(height: 12),

              // Options
              Expanded(
                child: ListView.separated(
                  itemCount: _options.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final isSelected = _selectedOptionIndex == index;
                    Color borderColor = AppColors.border;
                    Color bgColor = Colors.white;

                    if (_hasChecked) {
                      if (index == _correctIndex) {
                        borderColor = AppColors.success;
                        bgColor = AppColors.successLight;
                      } else if (isSelected && !_isCorrect) {
                        borderColor = AppColors.error;
                        bgColor = AppColors.errorLight;
                      }
                    } else if (isSelected) {
                      borderColor = AppColors.primary;
                      bgColor = AppColors.primaryContainer;
                    }

                    return InkWell(
                      onTap: _hasChecked
                          ? null
                          : () {
                              setState(() {
                                _selectedOptionIndex = index;
                              });
                            },
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: borderColor, width: 2),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? AppColors.primary : AppColors.canvas,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                String.fromCharCode(65 + index),
                                style: TextStyle(
                                  color: isSelected ? Colors.white : AppColors.textDark,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                _options[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? AppColors.primaryDark : AppColors.textDark,
                                ),
                              ),
                            ),
                            if (_hasChecked && index == _correctIndex)
                              const Icon(Icons.check_circle_rounded, color: AppColors.success),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Bottom Action Button
              if (!_hasChecked)
                TactileButton(
                  label: "Nyochaa (Check Answer)",
                  width: double.infinity,
                  style: TactileButtonStyle.primary,
                  onPressed: _selectedOptionIndex == null ? null : _checkAnswer,
                )
              else
                TactileButton(
                  label: _isCorrect ? "I mere nke ọma! (Continue)" : "Nwaa ọzọ (Try Again)",
                  width: double.infinity,
                  style: _isCorrect ? TactileButtonStyle.secondary : TactileButtonStyle.primary,
                  onPressed: () {
                    if (_isCorrect) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LessonCompleteScreen(
                            lessonTitle: "Ekele Ụtụtụ",
                            earnedXp: 20,
                          ),
                        ),
                      );
                    } else {
                      setState(() {
                        _hasChecked = false;
                        _selectedOptionIndex = null;
                      });
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
