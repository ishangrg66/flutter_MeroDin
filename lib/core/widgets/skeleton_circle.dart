import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonCircle extends StatelessWidget {
  final double radius;

  const SkeletonCircle({super.key, this.radius = 16});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
