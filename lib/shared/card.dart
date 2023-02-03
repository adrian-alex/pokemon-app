import 'package:flutter/material.dart';

class WhiteCard extends StatelessWidget {
  final Widget child;

  const WhiteCard({required this.child, super.key});

  static const double _cardsPadding = 10;
  static const double _cardMargin = 35;
  static const double _maxCardWidth = 600;
  static const double _borderRadius = 40;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.8),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.all(_cardMargin),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(_borderRadius),
            ),
          ),
          constraints: const BoxConstraints(maxWidth: _maxCardWidth),
          padding: const EdgeInsets.all(_cardsPadding),
          width: double.infinity,
          height: double.infinity,
          child: ClipRRect(borderRadius: BorderRadius.circular(_borderRadius), child: child),
        ),
      ),
    );
  }
}
