import 'package:after_call/components/subtle_gradient_background.dart';
import 'package:after_call/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingSlide> _slides = [
    OnboardingSlide(
      icon: Icons.record_voice_over,
      title: 'Record Post-Call Summaries',
      description:
          'After your important calls, quickly record a voice note about what was discussed. We never record your actual calls.',
    ),
    OnboardingSlide(
      icon: Icons.auto_awesome,
      title: 'AI-Powered Organization',
      description:
          'Get instant summaries, action items, and deadlines extracted from your voice notes. Stay organized effortlessly.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SubtleGradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    return _buildSlide(
                      _slides[index],
                      theme,
                      index == _currentPage,
                    );
                  },
                ),
              ),
              Padding(
                padding: AppSpacing.paddingLg,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _slides.length,
                        (index) => _buildPageIndicator(index, theme),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FilledButton(
                        onPressed: () {
                          if (_currentPage < _slides.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            context.go('/auth');
                          }
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: theme.colorScheme.tertiary,
                          foregroundColor: theme.colorScheme.onTertiary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.lg),
                          ),
                        ),
                        child: Text(
                          _currentPage < _slides.length - 1
                              ? 'Next'
                              : 'Get Started',
                          style: context.textStyles.titleMedium?.bold,
                        ),
                      ),
                    ),
                    if (_currentPage < _slides.length - 1) ...[
                      const SizedBox(height: AppSpacing.md),
                      TextButton(
                        onPressed: () => context.go('/auth'),
                        child: Text(
                          'Skip',
                          style: context.textStyles.titleMedium?.withColor(
                            theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlide(OnboardingSlide slide, ThemeData theme, bool isCurrent) {
    return Padding(
      padding: AppSpacing.paddingXl,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(
            key: ValueKey(slide.title),
            tween: Tween(begin: 0.92, end: isCurrent ? 1.0 : 0.96),
            curve: Curves.easeOutBack,
            duration: const Duration(milliseconds: 500),
            builder:
                (context, value, child) => Opacity(
                  opacity: isCurrent ? 1 : 0.7,
                  child: Transform.scale(scale: value, child: child),
                ),
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    theme.colorScheme.primaryContainer,
                    theme.colorScheme.primaryContainer.withValues(alpha: 0.6),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                slide.icon,
                size: 60,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text(
            slide.title,
            style: context.textStyles.headlineMedium?.copyWith(
              letterSpacing: -0.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            slide.description,
            style: context.textStyles.bodyLarge?.withColor(
              theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int index, ThemeData theme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color:
            _currentPage == index
                ? theme.colorScheme.primary
                : theme.colorScheme.outline.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingSlide {
  final IconData icon;
  final String title;
  final String description;

  OnboardingSlide({
    required this.icon,
    required this.title,
    required this.description,
  });
}
