import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/storage_service.dart';
import '../../shared/widgets/mascot_widget.dart';
import '../../shared/widgets/tactile_button.dart';

class LessonCompleteScreen extends StatelessWidget {
  final String lessonTitle;
  final int earnedXp;

  const LessonCompleteScreen({
    super.key,
    required this.lessonTitle,
    required this.earnedXp,
  });

  @override
  Widget build(BuildContext context) {
    final profile = StorageService().userProfile;

    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10),
              Column(
                children: [
                  const MascotWidget(
                    pose: MascotPose.celebrating,
                    size: 190,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "I mere nke ọma!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "You mastered: $lessonTitle",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Rewards Container
                  Row(
                    children: [
                      // XP Tile
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.border, width: 1.5),
                          ),
                          child: Column(
                            children: [
                              const Icon(Icons.diamond_rounded, color: AppColors.tertiary, size: 28),
                              const SizedBox(height: 6),
                              Text(
                                "+$earnedXp XP",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.tertiaryDark,
                                ),
                              ),
                              const Text("TOTAL XP", style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Streak Tile
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.border, width: 1.5),
                          ),
                          child: Column(
                            children: [
                              const Icon(Icons.local_fire_department_rounded, color: AppColors.secondary, size: 28),
                              const SizedBox(height: 6),
                              Text(
                                "${profile.streakDays} DAYS",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.secondaryDark,
                                ),
                              ),
                              const Text("STREAK ON FIRE", style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Bottom Actions
              Column(
                children: [
                  TactileButton(
                    label: "Gaa n'ihu (Continue)",
                    width: double.infinity,
                    style: TactileButtonStyle.primary,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
