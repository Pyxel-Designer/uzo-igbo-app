import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/mascot_widget.dart';
import '../../shared/widgets/tactile_button.dart';
import 'why_learn_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Header Tag
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.flag_rounded, color: AppColors.primary, size: 16),
                        SizedBox(width: 6),
                        Text(
                          "ASỤSỤ IGBO",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.0,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Mascot & Core Hero
              Column(
                children: [
                  const MascotWidget(
                    pose: MascotPose.welcoming,
                    size: 210,
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                        height: 1.25,
                      ),
                      children: [
                        TextSpan(text: "Nnọọ na "),
                        TextSpan(
                          text: "Ụzọ",
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Master the Igbo language with confidence. Authentic tones, regional dialects, and real-time travel fluency.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textMuted,
                      height: 1.5,
                    ),
                  ),
                ],
              ),

              // Action Buttons
              Column(
                children: [
                  TactileButton(
                    label: "Bido Ugbu A (Get Started)",
                    width: double.infinity,
                    style: TactileButtonStyle.primary,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WhyLearnScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  TactileButton(
                    label: "Enwere m akaụntụ (I have an account)",
                    width: double.infinity,
                    style: TactileButtonStyle.ghost,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WhyLearnScreen(),
                        ),
                      );
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
