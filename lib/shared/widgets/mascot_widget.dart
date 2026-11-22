import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum MascotPose {
  welcoming,
  friendly,
  thoughtful,
  surprised,
  angry,
  celebrating,
}

class MascotWidget extends StatelessWidget {
  final MascotPose pose;
  final double size;

  const MascotWidget({
    super.key,
    this.pose = MascotPose.friendly,
    this.size = 180,
  });

  String get _assetPath {
    switch (pose) {
      case MascotPose.welcoming:
        return 'assets/mascot/Welcoming Pose.png';
      case MascotPose.friendly:
        return 'assets/mascot/Friendly Tortoise Mascot.png';
      case MascotPose.thoughtful:
        return 'assets/mascot/Thoughtful Turtle Mascot.png';
      case MascotPose.surprised:
        return 'assets/mascot/suprised Tortoise Mascot.png';
      case MascotPose.angry:
        return 'assets/mascot/angry pose.png';
      case MascotPose.celebrating:
        return 'assets/mascot/smilling pose.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      child: Image.asset(
        _assetPath,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // Fallback visual representation with Mbe's traditional red Okpu Agu cap and coral beads
          return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 3),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.cruelty_free,
                  color: AppColors.primary,
                  size: 54,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Mbe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
