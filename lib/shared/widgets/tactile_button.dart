import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum TactileButtonStyle { primary, secondary, tertiary, ghost }

class TactileButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final TactileButtonStyle style;
  final Widget? icon;
  final double? width;
  final double height;
  final double fontSize;

  const TactileButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.style = TactileButtonStyle.primary,
    this.icon,
    this.width,
    this.height = 56,
    this.fontSize = 16,
  });

  @override
  State<TactileButton> createState() => _TactileButtonState();
}

class _TactileButtonState extends State<TactileButton> {
  bool _isPressed = false;

  Color get _faceColor {
    switch (widget.style) {
      case TactileButtonStyle.primary:
        return AppColors.primary;
      case TactileButtonStyle.secondary:
        return AppColors.secondary;
      case TactileButtonStyle.tertiary:
        return AppColors.tertiary;
      case TactileButtonStyle.ghost:
        return AppColors.surface;
    }
  }

  Color get _baseBorderColor {
    switch (widget.style) {
      case TactileButtonStyle.primary:
        return AppColors.primaryDark;
      case TactileButtonStyle.secondary:
        return AppColors.secondaryDark;
      case TactileButtonStyle.tertiary:
        return AppColors.tertiaryDark;
      case TactileButtonStyle.ghost:
        return AppColors.borderDark;
    }
  }

  Color get _textColor {
    switch (widget.style) {
      case TactileButtonStyle.ghost:
        return AppColors.textDark;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;
    final double borderBottom = _isPressed ? 1.0 : 4.0;
    final double translateY = _isPressed ? 3.0 : 0.0;

    return GestureDetector(
      onTapDown: isDisabled ? null : (_) => setState(() => _isPressed = true),
      onTapUp: isDisabled
          ? null
          : (_) {
              setState(() => _isPressed = false);
              widget.onPressed?.call();
            },
      onTapCancel: isDisabled ? null : () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 70),
        width: widget.width,
        height: widget.height,
        transform: Matrix4.translationValues(0, translateY, 0),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey.shade300 : _faceColor,
          borderRadius: BorderRadius.circular(9999),
          border: Border(
            top: BorderSide(
              color: widget.style == TactileButtonStyle.ghost
                  ? AppColors.border
                  : Colors.transparent,
              width: 1.5,
            ),
            left: BorderSide(
              color: widget.style == TactileButtonStyle.ghost
                  ? AppColors.border
                  : Colors.transparent,
              width: 1.5,
            ),
            right: BorderSide(
              color: widget.style == TactileButtonStyle.ghost
                  ? AppColors.border
                  : Colors.transparent,
              width: 1.5,
            ),
            bottom: BorderSide(
              color: isDisabled ? Colors.grey.shade400 : _baseBorderColor,
              width: borderBottom,
            ),
          ),
          boxShadow: [
            if (!_isPressed && !isDisabled)
              BoxShadow(
                color: _baseBorderColor.withOpacity(0.25),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              widget.icon!,
              const SizedBox(width: 8),
            ],
            Text(
              widget.label,
              style: TextStyle(
                color: isDisabled ? Colors.grey.shade600 : _textColor,
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.02,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
