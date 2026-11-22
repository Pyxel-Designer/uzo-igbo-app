import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/storage_service.dart';
import '../../shared/widgets/mascot_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _slowAudioMode = false;
  bool _offlineCacheEnabled = true;

  @override
  Widget build(BuildContext context) {
    final profile = StorageService().userProfile;

    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Profaịlụ m (My Profile)",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 90),
        child: Column(
          children: [
            // User Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border, width: 1.5),
              ),
              child: Row(
                children: [
                  const MascotWidget(pose: MascotPose.friendly, size: 70),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Focus: ${profile.selectedDialect}",
                          style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Total XP: ${profile.xp} • Daily: ${profile.dailyGoalMinutes}m",
                          style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Settings Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border, width: 1.5),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text("Slow Audio Pronunciation", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    subtitle: const Text("Plays tones at 0.75x speed for clearer diacritic learning", style: TextStyle(fontSize: 12)),
                    value: _slowAudioMode,
                    activeColor: AppColors.primary,
                    onChanged: (val) {
                      setState(() => _slowAudioMode = val);
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text("Offline Travel Mode", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    subtitle: const Text("Keep all lessons and phrasebook audio cached on device", style: TextStyle(fontSize: 12)),
                    value: _offlineCacheEnabled,
                    activeColor: AppColors.primary,
                    onChanged: (val) {
                      setState(() => _offlineCacheEnabled = val);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // App & Legal Info
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border, width: 1.5),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.privacy_tip_outlined, color: AppColors.textDark),
                    title: const Text("Privacy Policy (Iwu Nzuzo)", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.star_outline_rounded, color: AppColors.textDark),
                    title: const Text("Rate on Google Play Store", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.info_outline_rounded, color: AppColors.textDark),
                    title: const Text("About Ụzọ v1.0.0", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                    subtitle: const Text("Crafted for authentic Igbo cultural fluency", style: TextStyle(fontSize: 12)),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
