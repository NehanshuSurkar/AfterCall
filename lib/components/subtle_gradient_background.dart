import 'package:flutter/material.dart';

class SubtleGradientBackground extends StatelessWidget {
  final Widget child;

  const SubtleGradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    // Build a very soft vertical gradient using surface variants
    final colors =
        theme.brightness == Brightness.light
            ? [cs.surface, cs.surfaceContainerHighest]
            : [cs.surface, cs.surfaceContainerHighest];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colors.first,
            Color.alphaBlend(cs.primary.withValues(alpha: 0.03), colors.last),
          ],
        ),
      ),
      child: child,
    );
  }
}
