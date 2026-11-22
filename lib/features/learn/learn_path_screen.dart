import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/storage_service.dart';
import '../../shared/widgets/mascot_widget.dart';
import 'lesson_listening_screen.dart';
import 'lesson_speaking_screen.dart';
import 'lesson_market_screen.dart';

class LearnPathScreen extends StatefulWidget {
  const LearnPathScreen({super.key});

  @override
  State<LearnPathScreen> createState() => _LearnPathScreenState();
}

class _LearnPathScreenState extends State<LearnPathScreen> {
  @override
  Widget build(BuildContext context) {
    final profile = StorageService().userProfile;

    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        titleSpacing: 16,
        title: Row(
          children: [
            // Dialect Selector Chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.language_rounded, color: AppColors.primary, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    profile.selectedDialect.split(' ').first,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Streak Pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.secondary.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_fire_department_rounded, color: AppColors.secondary, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    "${profile.streakDays}",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppColors.secondaryDark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Gems Pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE8EAF6),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.tertiary.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.diamond_rounded, color: AppColors.tertiary, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    "${profile.gems}",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppColors.tertiaryDark,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 90),
        child: Column(
          children: [
            // Unit 1 Header Card
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryDark.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "UNIT 1 • NTỌALA",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Ekele na Nsọpụrụ (Greetings & Etiquette)",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Master respectful morning salutations, tone recognition, and fundamental phrases.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // Progression Path Nodes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Column(
                children: [
                  // Lesson 1 Node (Listening)
                  _buildLessonNode(
                    title: "Ekele Ụtụtụ (Good Morning)",
                    subtitle: "Listening drill & tone pitch",
                    icon: Icons.headphones_rounded,
                    isCompleted: profile.completedLessonIds.contains("lesson_1_1"),
                    isActive: true,
                    xp: "+20 XP",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LessonListeningScreen(),
                        ),
                      ).then((_) => setState(() {}));
                    },
                  ),
                  _buildPathConnector(),

                  // Lesson 2 Node (Speaking)
                  _buildLessonNode(
                    title: "Ịza Ekele (Responding)",
                    subtitle: "Speaking drill • Kedu ka ị mere?",
                    icon: Icons.mic_rounded,
                    isCompleted: profile.completedLessonIds.contains("lesson_1_2"),
                    isActive: profile.completedLessonIds.contains("lesson_1_1"),
                    xp: "+25 XP",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LessonSpeakingScreen(),
                        ),
                      ).then((_) => setState(() {}));
                    },
                  ),
                  _buildPathConnector(),

                  // Mascot Guide Breakpoint
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const MascotWidget(pose: MascotPose.friendly, size: 80),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border, width: 1.5),
                        ),
                        child: const Text(
                          "\"Ị na-eme nke ọma!\"\n(You are doing wonderfully!)",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildPathConnector(),

                  // Unit 2 Lesson Node (Market Bargaining)
                  _buildLessonNode(
                    title: "Ịjụ Ọnụ Ahịa (Asking Prices)",
                    subtitle: "Ahịa Ogbete Bargaining Dialogue",
                    icon: Icons.storefront_rounded,
                    isCompleted: profile.completedLessonIds.contains("lesson_2_1"),
                    isActive: profile.completedLessonIds.contains("lesson_1_2"),
                    xp: "+35 XP",
                    badge: "MARKET IMMERSION",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LessonMarketScreen(),
                        ),
                      ).then((_) => setState(() {}));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonNode({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isCompleted,
    required bool isActive,
    required String xp,
    String? badge,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: isActive ? onTap : null,
      borderRadius: BorderRadius.circular(22),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isCompleted
                ? AppColors.primary
                : isActive
                    ? AppColors.primaryDark
                    : AppColors.border,
            width: isCompleted ? 2.5 : (isActive ? 2 : 1),
          ),
          boxShadow: [
            if (isActive)
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: isCompleted
                    ? AppColors.primary
                    : isActive
                        ? AppColors.primaryContainer
                        : Colors.grey.shade200,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted ? AppColors.primaryDark : AppColors.primary,
                  width: 2,
                ),
              ),
              child: Icon(
                isCompleted ? Icons.check_rounded : icon,
                color: isCompleted ? Colors.white : (isActive ? AppColors.primary : Colors.grey),
                size: 26,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (badge != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        badge,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: isActive ? AppColors.textDark : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: isActive ? AppColors.textMuted : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.primaryContainer : AppColors.canvas,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                xp,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isCompleted ? AppColors.primary : AppColors.secondaryDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPathConnector() {
    return Container(
      width: 4,
      height: 26,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
