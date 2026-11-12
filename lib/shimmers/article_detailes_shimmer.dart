import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ArticleDetailsShimmer extends StatelessWidget {
  const ArticleDetailsShimmer({super.key});

  Widget bone({double? w, double h = 14}) => Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
      color: Colors.grey.withValues(alpha: 0.25),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(10),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: bone(h: double.infinity),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bone(h: 20),
                  bone(w: 200, h: 20),
                  Row(
                    spacing: 8,
                    children: [
                      bone(w: 40, h: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [bone(w: 100), bone(w: 80)],
                      ),
                    ],
                  ),
                  bone(),
                  bone(),
                  bone(),
                  bone(w: 180),
                  SizedBox(),
                  Center(child: bone(w: 90, h: 35)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
