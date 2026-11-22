import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/audio_service.dart';

class FaceToFaceScreen extends StatefulWidget {
  const FaceToFaceScreen({super.key});

  @override
  State<FaceToFaceScreen> createState() => _FaceToFaceScreenState();
}

class _FaceToFaceScreenState extends State<FaceToFaceScreen> {
  bool _isFlipped = true; // Inverts the top lane for the partner across the counter
  bool _isTopSpeaking = false;
  bool _isBottomSpeaking = false;

  String _partnerIgboText = "Kedu ihe ị na-ere? Enwere m mmasị n'akwà ọcha ahụ.";
  String _partnerEnglishTranslation = "What are you selling? I'm interested in that white fabric.";

  String _myEnglishText = "I have high quality Akwete and George fabrics. How many yards do you need?";
  String _myIgboTranslation = "Enwere m ezigbo akwa Akwete na George. Yard ole ka ị chọrọ?";

  void _speakPartner() {
    setState(() => _isTopSpeaking = true);
    AudioService().playAudio("assets/audio/ego_ole.wav");
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _isTopSpeaking = false);
    });
  }

  void _speakMe() {
    setState(() => _isBottomSpeaking = true);
    AudioService().playAudio("assets/audio/kedu.wav");
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _isBottomSpeaking = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        title: const Text(
          "Mkparịta Ụka Ihu na Ihu",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: "Toggle partner view flip",
            icon: Icon(
              Icons.screen_rotation_rounded,
              color: _isFlipped ? AppColors.tertiary : AppColors.textMuted,
            ),
            onPressed: () {
              setState(() {
                _isFlipped = !_isFlipped;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Status Tag
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.wifi_off_rounded, size: 14, color: AppColors.primaryDark),
                        SizedBox(width: 4),
                        Text(
                          "100% OFFLINE CONVERSATION",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryDark,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    _isFlipped ? "180° Inverted for Partner" : "Normal Orientation",
                    style: const TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            // TOP LANE: Partner / Them (Rotated 180° so person across the table reads naturally)
            Expanded(
              child: RotatedBox(
                quarterTurns: _isFlipped ? 2 : 0,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: _isTopSpeaking ? AppColors.secondary : AppColors.border,
                      width: _isTopSpeaking ? 2.5 : 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "THEM • ONYE ỌZỌ (IGBO)",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                color: AppColors.secondaryDark,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.volume_up_rounded, color: AppColors.secondary),
                            onPressed: _speakPartner,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _partnerIgboText,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textDark,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _partnerEnglishTranslation,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textMuted,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: _speakPartner,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.mic_rounded, color: Colors.white, size: 18),
                                SizedBox(width: 6),
                                Text(
                                  "Tap for Partner to Speak",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Middle Divider Beam
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
              child: Row(
                children: [
                  const Expanded(child: Divider()),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.tertiary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.swap_vert_rounded, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          "TWO-WAY LIVE",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 10,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
            ),

            // BOTTOM LANE: You (The user holding the device)
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: _isBottomSpeaking ? AppColors.primary : AppColors.border,
                    width: _isBottomSpeaking ? 2.5 : 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "YOU • GỊ (ENGLISH)",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: AppColors.primaryDark,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.volume_up_rounded, color: AppColors.primary),
                          onPressed: _speakMe,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _myEnglishText,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Igbo: $_myIgboTranslation",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: _speakMe,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.mic_rounded, color: Colors.white, size: 18),
                              SizedBox(width: 6),
                              Text(
                                "Tap to Speak (You)",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
