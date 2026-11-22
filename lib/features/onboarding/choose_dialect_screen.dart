import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/storage_service.dart';
import '../../shared/widgets/mascot_widget.dart';
import '../../shared/widgets/tactile_button.dart';
import 'daily_commitment_screen.dart';

class ChooseDialectScreen extends StatefulWidget {
  const ChooseDialectScreen({super.key});

  @override
  State<ChooseDialectScreen> createState() => _ChooseDialectScreenState();
}

class _ChooseDialectScreenState extends State<ChooseDialectScreen> {
  String _selectedDialect = "central";

  final List<Map<String, dynamic>> _dialects = [
    {
      "id": "central",
      "name": "Central Igbo (Igbo Izugbe)",
      "badge": "Standard & Official",
      "desc": "Understood everywhere across all states, schools, and media.",
    },
    {
      "id": "anambra",
      "name": "Anambra / Onitsha",
      "badge": "Commercial Hub",
      "desc": "Spoken around Onitsha Main Market, Awka, and Idemili.",
    },
    {
      "id": "enuani",
      "name": "Enuani (Delta Igbo)",
      "badge": "Western Bank",
      "desc": "Spoken across Asaba, Ogwashi-Uku, and Anioma.",
    },
    {
      "id": "imo",
      "name": "Imo / Owerri",
      "badge": "Classical Dialect",
      "desc": "Famous for rich oral proverbs and distinctive tonal cadence.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        title: const Text("Nzọụkwụ 3 nke 5", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textMuted)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mascot Advice Box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: const Row(
                  children: [
                    MascotWidget(pose: MascotPose.thoughtful, size: 54),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Mbe says: \"If you are new to Igbo, start with Central (Izugbe). You can switch dialects anytime!\"",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDark,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Họrọ olumba ị chọrọ",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Choose your target dialect. Lessons adapt vocabulary and audio.",
                style: TextStyle(fontSize: 14, color: AppColors.textMuted),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: ListView.separated(
                  itemCount: _dialects.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = _dialects[index];
                    final isSelected = _selectedDialect == item['id'];

                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedDialect = item['id'] as String;
                        });
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : Colors.white70,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.border,
                            width: isSelected ? 2.5 : 1.5,
                          ),
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.12),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Radio<String>(
                              value: item['id'] as String,
                              groupValue: _selectedDialect,
                              activeColor: AppColors.primary,
                              onChanged: (val) {
                                if (val != null) setState(() => _selectedDialect = val);
                              },
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        item['name'] as String,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item['desc'] as String,
                                    style: const TextStyle(
                                      fontSize: 13,
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
                label: "Họrọ Olumba A (Confirm Dialect)",
                width: double.infinity,
                style: TactileButtonStyle.primary,
                onPressed: () {
                  final chosen = _dialects.firstWhere((d) => d['id'] == _selectedDialect);
                  StorageService().userProfile.selectedDialect = chosen['name'] as String;
                  StorageService().saveProfile();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DailyCommitmentScreen(),
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
