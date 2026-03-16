import 'package:after_call/components/pressable_scale.dart';
import 'package:after_call/sevices/auth_service.dart';
import 'package:after_call/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _showPassword = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final authService = context.read<AuthService>();
    final success = await authService.signInWithEmail(
      _emailController.text,
      _passwordController.text,
    );

    if (mounted) {
      setState(() => _isLoading = false);
      if (success) {
        context.go('/');
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);

    final authService = context.read<AuthService>();
    final success = await authService.signInWithGoogle();

    if (mounted) {
      setState(() => _isLoading = false);
      if (success) {
        context.go('/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colors.primaryContainer.withOpacity(0.05),
              colors.surfaceVariant.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.xl,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo Section with Glassmorphism
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppGradients.primary,
                          boxShadow: AppShadows.glowPrimary,
                        ),
                        child: Icon(
                          Icons.call_made_rounded,
                          size: 48,
                          color: colors.onPrimary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // App Name with Gradient Text
                      ShaderMask(
                        shaderCallback:
                            (bounds) =>
                                AppGradients.primary.createShader(bounds),
                        child: Text(
                          'AfterCall',
                          style: GoogleFonts.inter(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            height: 1.1,
                            letterSpacing: -1,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      // Tagline
                      Text(
                        'Intelligent Call Summaries',
                        style: context.textStyles.titleMedium?.withColor(
                          colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxl),

                      // Glassmorphism Card
                      Container(
                        decoration: AppStyles.glassCard(
                          dark: theme.brightness == Brightness.dark,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.xl),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Header
                                Text(
                                  'Welcome Back',
                                  style: context.textStyles.headlineSmall
                                      ?.copyWith(color: colors.onSurface),
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  'Sign in to continue',
                                  style: context.textStyles.bodyMedium
                                      ?.withColor(colors.onSurfaceVariant),
                                ),
                                const SizedBox(height: AppSpacing.xl),

                                // Email Field
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: context.textStyles.bodyLarge,
                                  decoration: InputDecoration(
                                    labelText: 'Email Address',
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: colors.primary,
                                    ),
                                    filled: true,
                                    fillColor: colors.surfaceVariant
                                        .withOpacity(0.3),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppRadius.lg,
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.md,
                                      vertical: AppSpacing.md,
                                    ),
                                    floatingLabelStyle: TextStyle(
                                      color: colors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Please enter your email';
                                    }
                                    if (!value!.contains('@')) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: AppSpacing.lg),

                                // Password Field
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: !_showPassword,
                                  style: context.textStyles.bodyLarge,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: colors.primary,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _showPassword
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: colors.onSurfaceVariant,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showPassword = !_showPassword;
                                        });
                                      },
                                    ),
                                    filled: true,
                                    fillColor: colors.surfaceVariant
                                        .withOpacity(0.3),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppRadius.lg,
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.md,
                                      vertical: AppSpacing.md,
                                    ),
                                    floatingLabelStyle: TextStyle(
                                      color: colors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Please enter your password';
                                    }
                                    if (value!.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                ),

                                // Forgot Password
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      // Add forgot password functionality
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: context.textStyles.labelMedium
                                          ?.withColor(colors.primary),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.xl),

                                // Sign In Button
                                PressableScale(
                                  onTap: _isLoading ? null : _signIn,
                                  scale: 0.98,
                                  child: Container(
                                    width: double.infinity,
                                    height: 56,
                                    decoration: AppStyles.primaryGradientButton(
                                      isPressed: false,
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(
                                          AppRadius.lg,
                                        ),
                                        onTap: _isLoading ? null : _signIn,
                                        child: Center(
                                          child:
                                              _isLoading
                                                  ? const SizedBox(
                                                    height: 24,
                                                    width: 24,
                                                    child:
                                                        CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color: Colors.white,
                                                        ),
                                                  )
                                                  : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(
                                                        Icons.login_rounded,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ),
                                                      const SizedBox(
                                                        width: AppSpacing.sm,
                                                      ),
                                                      Text(
                                                        'Sign In',
                                                        style: GoogleFonts.inter(
                                                          fontSize:
                                                              AppTypography
                                                                  .labelLarge,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.white,
                                                          letterSpacing:
                                                              AppTypography
                                                                  .letterSpacingWide,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.lg),

                                // Divider with Text
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        color: colors.outline.withOpacity(0.3),
                                        thickness: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppSpacing.md,
                                      ),
                                      child: Text(
                                        'OR CONTINUE WITH',
                                        style: context.textStyles.labelSmall
                                            ?.withColor(
                                              colors.onSurfaceVariant
                                                  .withOpacity(0.6),
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: colors.outline.withOpacity(0.3),
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.lg),

                                // Google Sign In Button
                                PressableScale(
                                  onTap: _isLoading ? null : _signInWithGoogle,
                                  scale: 0.98,
                                  child: Container(
                                    width: double.infinity,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        AppRadius.lg,
                                      ),
                                      color: colors.surface,
                                      border: Border.all(
                                        color: colors.outline.withOpacity(0.3),
                                        width: 1.5,
                                      ),
                                      boxShadow: AppShadows.subtle,
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(
                                          AppRadius.lg,
                                        ),
                                        onTap:
                                            _isLoading
                                                ? null
                                                : _signInWithGoogle,
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(
                                                  4,
                                                ),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  boxShadow: AppShadows.subtle,
                                                ),

                                                child: Image.network(
                                                  'https://www.google.com/favicon.ico',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: AppSpacing.md,
                                              ),
                                              Text(
                                                'Google',
                                                style: GoogleFonts.inter(
                                                  fontSize:
                                                      AppTypography.labelLarge,
                                                  fontWeight: FontWeight.w600,
                                                  color: colors.onSurface,
                                                  letterSpacing:
                                                      AppTypography
                                                          .letterSpacingWide,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // Sign Up Link
                                const SizedBox(height: AppSpacing.xl),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'New to AfterCall?',
                                      style: context.textStyles.bodyMedium
                                          ?.withColor(colors.onSurfaceVariant),
                                    ),
                                    const SizedBox(width: AppSpacing.xs),
                                    TextButton(
                                      onPressed: () {
                                        context.go('/register');
                                      },
                                      child: Text(
                                        'Create Account',
                                        style: context.textStyles.bodyMedium
                                            ?.copyWith(
                                              color: colors.primary,
                                              fontWeight: FontWeight.w600,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Footer
                      const SizedBox(height: AppSpacing.xxl),
                      Text(
                        'Your privacy-first call assistant',
                        style: context.textStyles.bodySmall?.withColor(
                          colors.onSurfaceVariant.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            size: 14,
                            color: colors.onSurfaceVariant.withOpacity(0.5),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            'End-to-end encrypted • No data selling',
                            style: context.textStyles.labelSmall?.withColor(
                              colors.onSurfaceVariant.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
