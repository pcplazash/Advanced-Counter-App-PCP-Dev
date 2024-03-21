import 'dart:math';
import 'dart:ui';
import 'package:advanced_counter_app/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class CustomBox extends StatefulWidget {
  const CustomBox({super.key});

  @override
  State<CustomBox> createState() => _CustomBoxState();
}

class _CustomBoxState extends State<CustomBox>
    with SingleTickerProviderStateMixin {
  late final _rotationController =
      AnimationController(vsync: this, upperBound: pi * 2);
  final Duration _rotationDuration = const Duration(seconds: 20);

  @override
  void initState() {
    super.initState();
    _rotationController.duration = _rotationDuration;
    _rotationController.repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Paint paint = Paint()
      ..color = Theme.of(context).particlesColor.withOpacity(0.5);
    return CustomPaint(
      painter: MyCustomPainter(_rotationController, myPaint: paint),
      child: const SizedBox.expand(),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final Paint myPaint;
  final Animation<double> rotation;

  MyCustomPainter(this.rotation, {required this.myPaint})
      : super(repaint: rotation);

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.shortestSide / 5;
    final center = Offset(size.width / 2, size.height / 5);

    const vertexCount = 6;

    final offsets = <Offset>[];
    offsets.add(center);
    for (var i = 0; i < vertexCount; i++) {
      final angle = (i / vertexCount) * 2 * pi;
      final x = cos(angle - rotation.value) * radius;
      final y = sin(angle - rotation.value) * radius;

      final offset = Offset(x, y);
      offsets.add(center + offset);
      if (i == 0) {}
    }

    final indices = <int>[];
    for (var i = 0; i < vertexCount - 1; i++) {
      indices.add(0);
      indices.add(1 + i);
      indices.add(1 + i + 1);
    }
    indices.addAll([0, vertexCount, 1]);

    final vertices = Vertices(
      VertexMode.triangles,
      offsets,
      indices: indices,
    );

    canvas.drawVertices(vertices, BlendMode.src, myPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
