import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/storage_service.dart';
import '../../shared/widgets/tactile_button.dart';
import 'learning_plan_ready_screen.dart';

class DailyCommitmentScreen extends StatefulWidget {
  const DailyCommitmentScreen({super.key});

  @override
  State<DailyCommitmentScreen> createState() => _DailyCommitmentScreenState();
}

class _DailyCommitmentScreenState extends State<DailyCommitmentScreen> {
  int _selectedMinutes = 15;

  final List<Map<String, dynamic>> _goals = [
    {
      "minutes": 5,
      "level": "Casual (Nwayọ nwayọ)",
      "desc": "1 lesson per day. Perfect for busy travelers.",
      "icon": Icons.bolt_outlined,
    },
    {
      "minutes": 15,
      "level": "Regular (Onye ọrụ)",
      "desc": "3 lessons per day + 1 tone drill. Recommended pace.",
      "icon": Icons.bolt_rounded,
      "recommended": true,
    },
    {
      "minutes": 30,
      "level": "Serious (Onye uchu)",
      "desc": "Rapid immersion for upcoming trips or fluent speaking.",
      "icon": Icons.flash_on_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        title: const Text("Nzọụkwụ 4 nke 5", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textMuted)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Gịnị bụ ebumnuche gị kwa ụbọchị?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "How much time can you commit each day? Small daily practice builds lifelong fluency.",
                style: TextStyle(fontSize: 14, color: AppColors.textMuted),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: _goals.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = _goals[index];
                    final isSelected = _selectedMinutes == item['minutes'];
                    final isRecommended = item['recommended'] == true;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedMinutes = item['minutes'] as int;
                        });
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryContainer : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.border,
                            width: isSelected ? 2.5 : 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primary : AppColors.canvas,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                item['icon'] as IconData,
                                color: isSelected ? Colors.white : AppColors.secondary,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${item['minutes']} mins / day",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800,
                                          color: isSelected ? AppColors.primaryDark : AppColors.textDark,
                                        ),
                                      ),
                                      if (isRecommended) ...[
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.secondary,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Text(
                                            "POPULAR",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item['level'] as String,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item['desc'] as String,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              TactileButton(
                label: "Debanye Ebumnuche (Save Goal)",
                width: double.infinity,
                style: TactileButtonStyle.primary,
                onPressed: () {
                  StorageService().userProfile.dailyGoalMinutes = _selectedMinutes;
                  StorageService().saveProfile();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LearningPlanReadyScreen(),
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
