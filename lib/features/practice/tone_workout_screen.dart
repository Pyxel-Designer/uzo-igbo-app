import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/audio_service.dart';

class ToneWorkoutScreen extends StatefulWidget {
  const ToneWorkoutScreen({super.key});

  @override
  State<ToneWorkoutScreen> createState() => _ToneWorkoutScreenState();
}

class _ToneWorkoutScreenState extends State<ToneWorkoutScreen> {
  int _activeToneIndex = 0;

  final List<Map<String, dynamic>> _tones = [
    {
      "word": "Ákwá",
      "tones": "High — High (ˊ ˊ)",
      "meaning": "Crying / Tears",
      "exampleIgbo": "Nwa ahụ na-akwa ákwá.",
      "exampleEnglish": "That child is crying.",
      "contour": "↗ ↗",
      "color": AppColors.primary,
    },
    {
      "word": "Àkwà",
      "tones": "Low — Low (ˋ ˋ)",
      "meaning": "Bed / Bridge",
      "exampleIgbo": "Dina n'elu àkwà ka i zuo ike.",
      "exampleEnglish": "Lie down on the bed to rest.",
      "contour": "↘ ↘",
      "color": AppColors.secondary,
    },
    {
      "word": "Àkwá",
      "tones": "Low — High (ˋ ˊ)",
      "meaning": "Egg",
      "exampleIgbo": "M chọrọ àkwá ọkụkọ abụọ.",
      "exampleEnglish": "I want two chicken eggs.",
      "contour": "↘ ↗",
      "color": AppColors.tertiary,
    },
    {
      "word": "Ákwà",
      "tones": "High — Low (ˊ ˋ)",
      "meaning": "Cloth / Fabric",
      "exampleIgbo": "Akwa George a mara mma nke ukwuu.",
      "exampleEnglish": "This George fabric is truly beautiful.",
      "contour": "↗ ↘",
      "color": Colors.deepPurple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final active = _tones[_activeToneIndex];

    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        title: const Text(
          "Ọzụzụ Uda (Tone Workout)",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tone Focus Hero Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: active['color'] as Color, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: (active['color'] as Color).withOpacity(0.15),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: (active['color'] as Color).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            active['tones'] as String,
                            style: TextStyle(
                              color: active['color'] as Color,
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Text(
                          active['contour'] as String,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: active['color'] as Color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      active['word'] as String,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Meaning: ${active['meaning']}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Speaker Button
                    GestureDetector(
                      onTap: () {
                        AudioService().playTone(active['tones'] as String);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: active['color'] as Color,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.volume_up_rounded, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              "Hear Pitch Pattern",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 32),
                    // Sentence Example
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "EXAMPLE SENTENCE:",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textMuted,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          active['exampleIgbo'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          active['exampleEnglish'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                "Tonal Minimal Pairs (The \"Akwa\" Family)",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textDark),
              ),
              const SizedBox(height: 10),

              // Selection Tiles
              ...List.generate(_tones.length, (index) {
                final item = _tones[index];
                final isSelected = _activeToneIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _activeToneIndex = index;
                      });
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.white70,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isSelected ? (item['color'] as Color) : AppColors.border,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            item['word'] as String,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: isSelected ? (item['color'] as Color) : AppColors.textDark,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['meaning'] as String,
                                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                                ),
                                Text(
                                  item['tones'] as String,
                                  style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            item['contour'] as String,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: item['color'] as Color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
