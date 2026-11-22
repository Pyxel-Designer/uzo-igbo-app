import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/audio_service.dart';
import '../../core/services/storage_service.dart';
import 'face_to_face_screen.dart';

class LiveTranslatorScreen extends StatefulWidget {
  const LiveTranslatorScreen({super.key});

  @override
  State<LiveTranslatorScreen> createState() => _LiveTranslatorScreenState();
}

class _LiveTranslatorScreenState extends State<LiveTranslatorScreen> {
  bool _isEnglishToIgbo = true;
  final TextEditingController _inputController = TextEditingController();
  String _translatedResult = "";
  bool _isTranslating = false;

  final Map<String, String> _quickTranslations = {
    "hello": "Nnọọ",
    "how are you": "Kedu ka ị mere?",
    "how much is this": "Ego ole ka nke a bụ?",
    "thank you": "Daalụ nke ukwuu",
    "where are you going": "Ebee ka ị na-aga?",
    "please drop me off here": "Biko, wetuo m ebe a",
    "i am hungry": "Enwere m agụụ",
  };

  void _translate(String text) {
    if (text.trim().isEmpty) {
      setState(() => _translatedResult = "");
      return;
    }

    setState(() => _isTranslating = true);

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        final query = text.trim().toLowerCase();
        String result = "Nsụgharị: $text"; // Fallback

        _quickTranslations.forEach((key, val) {
          if (query.contains(key)) {
            result = val;
          }
        });

        setState(() {
          _isTranslating = false;
          _translatedResult = result;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = StorageService().travelCategories;

    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Onye Ntụgharị Njem (Travel & Conversation)",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: "Face-to-Face Conversation Mode",
            icon: const Icon(Icons.people_alt_rounded, color: AppColors.tertiary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FaceToFaceScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Face-to-Face Conversation Mode Launcher Card
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FaceToFaceScreen()),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.tertiary, AppColors.tertiaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.tertiaryDark.withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.record_voice_over_rounded, color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mkparịta Ụka Ihu na Ihu (Face to Face)",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Hold live two-way conversations with native speakers",
                            style: TextStyle(color: Colors.white70, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white70, size: 14),
                  ],
                ),
              ),
            ),
            // Language Direction Switcher Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(color: AppColors.border, width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isEnglishToIgbo ? "Bekee (English)" : "Asụsụ Igbo",
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  IconButton(
                    icon: const Icon(Icons.swap_horiz_rounded, color: AppColors.tertiary),
                    onPressed: () {
                      setState(() {
                        _isEnglishToIgbo = !_isEnglishToIgbo;
                        _inputController.clear();
                        _translatedResult = "";
                      });
                    },
                  ),
                  Text(
                    _isEnglishToIgbo ? "Asụsụ Igbo (Central)" : "Bekee (English)",
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.primary),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Translation Input Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _inputController,
                    onChanged: _translate,
                    maxLines: 3,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      hintText: _isEnglishToIgbo ? "Enter English phrase (e.g. How much is this?)" : "Dee okwu Igbo ebe a...",
                      hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 15),
                      border: InputBorder.none,
                    ),
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.mic_rounded, color: AppColors.tertiary),
                        onPressed: () {
                          _inputController.text = "How much is this";
                          _translate("how much is this");
                        },
                      ),
                      if (_translatedResult.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.volume_up_rounded, color: AppColors.primary),
                          onPressed: () {
                            AudioService().playAudio("assets/audio/ego_ole.mp3");
                          },
                        ),
                    ],
                  ),
                  if (_translatedResult.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "IGBO TRANSLATION:",
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.primaryDark),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _translatedResult,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Travel Phrasebook Section (Akwụkwọ Okwu Njem)
            const Text(
              "Akwụkwọ Okwu Njem (Travel Phrasebook)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textDark),
            ),
            const SizedBox(height: 6),
            const Text(
              "Offline ready phrases for transit, street food, and market interactions.",
              style: TextStyle(fontSize: 13, color: AppColors.textMuted),
            ),
            const SizedBox(height: 14),

            ...categories.map((cat) {
              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.folder_open_rounded, color: AppColors.secondary, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          cat.category,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textDark),
                        ),
                      ],
                    ),
                    const Divider(height: 16),
                    ...cat.phrases.map((p) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.igbo,
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textDark),
                                  ),
                                  Text(
                                    "${p.english} • (${p.phonetic})",
                                    style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.volume_up_rounded, color: AppColors.primary, size: 20),
                              onPressed: () {
                                AudioService().playAudio("assets/audio/default.mp3");
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
