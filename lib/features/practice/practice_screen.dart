import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/audio_service.dart';
import 'tone_workout_screen.dart';

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Omume & Ncheta (Practice Hub)",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Tone Workout Banner
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ToneWorkoutScreen()),
                );
              },
              borderRadius: BorderRadius.circular(24),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.tertiary, AppColors.tertiaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.tertiaryDark.withOpacity(0.3),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "ACOUSTIC ENGINE",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.graphic_eq_rounded, color: Colors.white, size: 28),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Tone Workout (Ọzụzụ Uda)",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Master the four tonal patterns that differentiate words like Ákwá (crying), Àkwà (bed), Àkwá (egg), and Ákwà (cloth).",
                      style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: const [
                        Text(
                          "Bido Ugbu A (Start Drill)",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              "Omume Ngwa Ngwa (Quick Recall)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textDark),
            ),
            const SizedBox(height: 12),

            _buildPracticeCard(
              title: "Rapid Flashcards (Kaadị Ncheta)",
              subtitle: "50 essential market & transit vocabulary",
              icon: Icons.style_rounded,
              color: AppColors.primary,
              onTap: () {
                AudioService().playAudio("assets/audio/default.mp3");
              },
            ),
            const SizedBox(height: 12),
            _buildPracticeCard(
              title: "Listening Speed Drill",
              subtitle: "Identify native speech without diacritic subtitles",
              icon: Icons.speed_rounded,
              color: AppColors.secondary,
              onTap: () {
                AudioService().playAudio("assets/audio/default.mp3");
              },
            ),
            const SizedBox(height: 12),
            _buildPracticeCard(
              title: "Grammar & Diacritic Matching",
              subtitle: "Practice subdots (ị, ọ, ụ) and nasal tildes (ṅ)",
              icon: Icons.spellcheck_rounded,
              color: AppColors.tertiary,
              onTap: () {
                AudioService().playAudio("assets/audio/default.mp3");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPracticeCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
