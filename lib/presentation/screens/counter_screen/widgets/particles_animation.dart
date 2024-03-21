import 'package:advanced_counter_app/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:sa3_liquid/liquid/plasma/plasma.dart';

class ParticlesAnimation extends StatelessWidget {
  const ParticlesAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        backgroundBlendMode: BlendMode.srcOver,
      ),
      child: PlasmaRenderer(
        type: PlasmaType.bubbles,
        particles: 45,
        color: Theme.of(context).particlesColor,
        blur: 0.5,
        size: 0.3,
        speed: 1.35,
        offset: 0,
        blendMode: BlendMode.screen,
        particleType: ParticleType.atlas,
        variation1: 0.31,
        variation2: 0.3,
        variation3: 0.13,
        rotation: 1.05,
      ),
    );
  }
}
