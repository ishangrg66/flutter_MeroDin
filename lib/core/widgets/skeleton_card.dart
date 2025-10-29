// lib/shared/widgets/skeleton_card.dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonCard extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const SkeletonCard({
    super.key,
    this.width = 150,
    this.height = 80,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: borderRadius ?? BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
