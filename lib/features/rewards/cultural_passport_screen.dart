import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/storage_service.dart';
import '../../shared/widgets/mascot_widget.dart';

class CulturalPassportScreen extends StatelessWidget {
  const CulturalPassportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = StorageService().userProfile;
    final proverbs = StorageService().proverbs;
    final dailyProverb = proverbs.isNotEmpty ? proverbs.first : null;

    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Paspọtụ Omenala (Cultural Passport)",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Passport Cover Hero
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B2500), Color(0xFF5C1800)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(26),
                border: Border.all(color: AppColors.accent, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "PASPỌTỤ ALA IGBO",
                        style: TextStyle(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          letterSpacing: 2.0,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "ID: UZO-${profile.xp}XP",
                          style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const MascotWidget(pose: MascotPose.celebrating, size: 80),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Title: Onye Njem (Igbo Scholar)",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.accent.withOpacity(0.9),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Dialect: ${profile.selectedDialect}",
                              style: const TextStyle(fontSize: 12, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Daily Proverb (Ilu Igbo)
            if (dailyProverb != null) ...[
              const Text(
                "Ilu Igbo nke Ụbọchị (Daily Igbo Proverb)",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textDark),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.border, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.format_quote_rounded, color: AppColors.secondary, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          "THEME: ${dailyProverb.theme.toUpperCase()}",
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.secondaryDark,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "\"${dailyProverb.igbo}\"",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Literal: ${dailyProverb.literal}",
                      style: const TextStyle(fontSize: 13, color: AppColors.textMuted, fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Meaning: ${dailyProverb.meaning}",
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primaryDark),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Cultural Badges & Chieftain Titles
            const Text(
              "Akara Ogo (Chieftain Titles & Badges)",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textDark),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                _buildBadge(
                  title: "Onye Njem",
                  subtitle: "Level 1 Traveler",
                  icon: Icons.directions_walk_rounded,
                  color: AppColors.primary,
                  isUnlocked: true,
                ),
                const SizedBox(width: 12),
                _buildBadge(
                  title: "Onye Ọzụzụ",
                  subtitle: "Tone Master",
                  icon: Icons.graphic_eq_rounded,
                  color: AppColors.tertiary,
                  isUnlocked: true,
                ),
                const SizedBox(width: 12),
                _buildBadge(
                  title: "Ichie",
                  subtitle: "Market Elder",
                  icon: Icons.military_tech_rounded,
                  color: Colors.grey,
                  isUnlocked: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool isUnlocked,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
          color: isUnlocked ? Colors.white : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isUnlocked ? color.withOpacity(0.5) : AppColors.border,
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isUnlocked ? color.withOpacity(0.12) : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isUnlocked ? color : Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: isUnlocked ? AppColors.textDark : Colors.grey,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: isUnlocked ? AppColors.textMuted : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
