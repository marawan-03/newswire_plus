import 'package:flutter/material.dart';

class PublisherLogo extends StatelessWidget {
  final double hw;
  final String publisher;
  PublisherLogo({super.key, required this.publisher, required this.hw});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(7),
      ),
      child: SizedBox(
        height: hw,
        width: hw,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.asset(
            'assets/publisher_logos/${publisher.toLowerCase()}.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/publisher_logos/unknown_publisher.png',
                fit: BoxFit.contain,
              );
            },
          ),
        ),
      ),
    );
  }
}
