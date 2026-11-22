import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/tactile_button.dart';
import 'choose_dialect_screen.dart';

class WhyLearnScreen extends StatefulWidget {
  const WhyLearnScreen({super.key});

  @override
  State<WhyLearnScreen> createState() => _WhyLearnScreenState();
}

class _WhyLearnScreenState extends State<WhyLearnScreen> {
  String? _selectedReason;

  final List<Map<String, dynamic>> _reasons = [
    {
      "id": "heritage",
      "icon": Icons.family_restroom_rounded,
      "title": "Connect with Heritage & Family",
      "subtitle": "Speak fluently with parents, elders, and relatives back home.",
    },
    {
      "id": "travel",
      "icon": Icons.explore_rounded,
      "title": "Travel & Exploration",
      "subtitle": "Confidently navigate transit, markets, and towns in Eastern Nigeria.",
    },
    {
      "id": "trade",
      "icon": Icons.storefront_rounded,
      "title": "Business & Market Trade",
      "subtitle": "Negotiate prices and build trust across regional commercial hubs.",
    },
    {
      "id": "culture",
      "icon": Icons.music_note_rounded,
      "title": "Culture & Entertainment",
      "subtitle": "Understand Igbo highlife, proverbs (Ilu), and Nollywood without subtitles.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        title: const Text("Nzọụkwụ 2 nke 5", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textMuted)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Gịnị mere i ji chọọ ịmụ Igbo?",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Why are you learning Igbo? We'll tailor your path and travel phrase priority.",
                style: TextStyle(fontSize: 15, color: AppColors.textMuted),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: _reasons.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = _reasons[index];
                    final isSelected = _selectedReason == item['id'];

                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedReason = item['id'];
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
                            width: isSelected ? 2 : 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.canvas,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                item['icon'] as IconData,
                                color: isSelected ? Colors.white : AppColors.textDark,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'] as String,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: isSelected
                                          ? AppColors.primaryDark
                                          : AppColors.textDark,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['subtitle'] as String,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textMuted,
                                      height: 1.3,
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
                label: "Gaa n'ihu (Continue)",
                width: double.infinity,
                style: TactileButtonStyle.primary,
                onPressed: _selectedReason == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChooseDialectScreen(),
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
