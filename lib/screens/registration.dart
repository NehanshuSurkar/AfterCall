import 'package:after_call/components/pressable_scale.dart';
import 'package:after_call/sevices/auth_service.dart';
import 'package:after_call/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _acceptTerms = false;

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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please accept Terms and Conditions'),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final authService = context.read<AuthService>();

    // Check if your AuthService has a registration method
    // If not, you'll need to add it to your AuthService class
    // final success = await authService.registerWithEmail(
    //   _emailController.text,
    //   _passwordController.text,
    //   _nameController.text,
    // );

    if (mounted) {
      setState(() => _isLoading = false);

      // if (success) {
      //   // Show success message
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('Welcome to AfterCall, ${_nameController.text}!'),
      //       backgroundColor: Theme.of(context).colorScheme.primary,
      //       behavior: SnackBarBehavior.floating,
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(AppRadius.md),
      //       ),
      //     ),
      //   );

      //   // Navigate to home page
      //   context.go('/');
      // } else {
      //   // Show error message
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: const Text('Registration failed. Please try again.'),
      //       backgroundColor: Theme.of(context).colorScheme.error,
      //       behavior: SnackBarBehavior.floating,
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(AppRadius.md),
      //       ),
      //     ),
      //   );
      // }
    }
  }

  Future<void> _registerWithGoogle() async {
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
                      // Back Button and Logo
                      Row(
                        children: [
                          PressableScale(
                            onTap: () => context.go('/auth'),
                            scale: 0.95,
                            child: Container(
                              padding: const EdgeInsets.all(AppSpacing.sm),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors.surfaceContainerHighest
                                    .withOpacity(0.5),
                              ),
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: colors.onSurfaceVariant,
                                size: 24,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppGradients.primary,
                              boxShadow: AppShadows.glowPrimary,
                            ),
                            child: Icon(
                              Icons.call_made_rounded,
                              size: 24,
                              color: colors.onPrimary,
                            ),
                          ),
                          const Spacer(),
                          const SizedBox(width: 48), // Balance the row
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Header
                      ShaderMask(
                        shaderCallback:
                            (bounds) =>
                                AppGradients.primary.createShader(bounds),
                        child: Text(
                          'Create Account',
                          style: GoogleFonts.inter(
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                            height: 1.1,
                            letterSpacing: -1,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Join AfterCall today',
                        style: context.textStyles.titleMedium?.withColor(
                          colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // Registration Form Card
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
                                // Full Name Field
                                TextFormField(
                                  controller: _nameController,
                                  style: context.textStyles.bodyLarge,
                                  decoration: InputDecoration(
                                    labelText: 'Full Name',
                                    prefixIcon: Icon(
                                      Icons.person_outline_rounded,
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
                                      return 'Please enter your name';
                                    }
                                    if (value!.length < 2) {
                                      return 'Name must be at least 2 characters';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: AppSpacing.lg),

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
                                    if (!value!.contains('@') ||
                                        !value.contains('.')) {
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
                                      Icons.lock_outline_rounded,
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
                                    helperText: 'Minimum 6 characters',
                                    helperStyle: context.textStyles.labelSmall
                                        ?.withColor(
                                          colors.onSurfaceVariant.withOpacity(
                                            0.6,
                                          ),
                                        ),
                                    floatingLabelStyle: TextStyle(
                                      color: colors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Please enter a password';
                                    }
                                    if (value!.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: AppSpacing.lg),

                                // Confirm Password Field
                                TextFormField(
                                  controller: _confirmPasswordController,
                                  obscureText: !_showConfirmPassword,
                                  style: context.textStyles.bodyLarge,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    prefixIcon: Icon(
                                      Icons.lock_outline_rounded,
                                      color: colors.primary,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _showConfirmPassword
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: colors.onSurfaceVariant,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showConfirmPassword =
                                              !_showConfirmPassword;
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
                                      return 'Please confirm your password';
                                    }
                                    if (value != _passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: AppSpacing.xl),

                                // Terms and Conditions Checkbox
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Checkbox(
                                        value: _acceptTerms,
                                        onChanged: (value) {
                                          setState(() {
                                            _acceptTerms = value ?? false;
                                          });
                                        },
                                        activeColor: colors.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            AppRadius.xs,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _acceptTerms = !_acceptTerms;
                                          });
                                        },
                                        child: RichText(
                                          text: TextSpan(
                                            style: context.textStyles.bodySmall
                                                ?.copyWith(
                                                  color:
                                                      colors.onSurfaceVariant,
                                                ),
                                            children: [
                                              const TextSpan(
                                                text: 'I agree to the ',
                                              ),
                                              TextSpan(
                                                text: 'Terms of Service',
                                                style: TextStyle(
                                                  color: colors.primary,
                                                  fontWeight: FontWeight.w600,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                              const TextSpan(text: ' and '),
                                              TextSpan(
                                                text: 'Privacy Policy',
                                                style: TextStyle(
                                                  color: colors.primary,
                                                  fontWeight: FontWeight.w600,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.xl),

                                // Register Button
                                PressableScale(
                                  onTap: _isLoading ? null : _register,
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
                                        onTap: _isLoading ? null : _register,
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
                                                      Icon(
                                                        Icons
                                                            .person_add_rounded,
                                                        color: colors.onPrimary,
                                                        size: 20,
                                                      ),
                                                      const SizedBox(
                                                        width: AppSpacing.sm,
                                                      ),
                                                      Text(
                                                        'Create Account',
                                                        style: GoogleFonts.inter(
                                                          fontSize:
                                                              AppTypography
                                                                  .labelLarge,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color:
                                                              colors.onPrimary,
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
                                        'OR SIGN UP WITH',
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

                                // Google Sign Up Button
                                PressableScale(
                                  onTap:
                                      _isLoading ? null : _registerWithGoogle,
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
                                                : _registerWithGoogle,
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
                                                  errorBuilder:
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) => const Icon(
                                                        Icons.g_mobiledata,
                                                        size: 20,
                                                      ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: AppSpacing.md,
                                              ),
                                              Text(
                                                'Continue with Google',
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
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Sign In Link
                      const SizedBox(height: AppSpacing.xl),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: context.textStyles.bodyMedium?.withColor(
                              colors.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          TextButton(
                            onPressed: () {
                              context.go('/auth');
                            },
                            child: Text(
                              'Sign In',
                              style: context.textStyles.bodyMedium?.copyWith(
                                color: colors.primary,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
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

// =============================================================================
// Add this to your AuthService class if it doesn't exist
// =============================================================================
/*
  Future<bool> registerWithEmail(String email, String password, String name) async {
    try {
      // Your registration logic here
      // This could be Firebase Auth, your own backend, etc.
      
      // Example with Firebase:
      // final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
      // 
      // await userCredential.user?.updateDisplayName(name);
      // 
      // return true;
      
      return true; // Return true on success
    } catch (e) {
      debugPrint('Registration failed: $e');
      return false;
    }
  }
*/
