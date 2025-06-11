import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import '../screens/home_screen.dart';
import 'glass_card.dart';
import 'toast.dart';

class PasswordResetForm extends HookConsumerWidget {
  final PageController pageController;
  final TextEditingController emailController;
  const PasswordResetForm({
    super.key,
    required this.pageController,
    required this.emailController,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailSent = useState(false);
    final otpController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final isBusy = useState(false);
    final showPassword = useState(false);
    final showConfirmPassword = useState(false);

    Future<void> sendPasswordResetLink() async {
      if (!formKey.currentState!.validate()) {
        return;
      }
      formKey.currentState!.save();
      try {
        isBusy.value = true;
        await supabase.auth.resetPasswordForEmail(emailController.text);
        emailSent.value = true;
      } on AuthException catch (e) {
        if (context.mounted) {
          ToastManager.showError(context, e.message);
        }
      } catch (e) {
        if (context.mounted) {
          ToastManager.showError(context, e.toString());
        }
      } finally {
        isBusy.value = false;
      }
    }

    Future<void> resetPassword() async {
      if (!formKey.currentState!.validate()) {
        return;
      }
      formKey.currentState!.save();
      try {
        isBusy.value = true;
        await supabase.auth.verifyOTP(
          email: emailController.text,
          token: otpController.text,
          type: OtpType.recovery,
        );
        await supabase.auth.updateUser(
          UserAttributes(password: passwordController.text),
        );
        if (context.mounted) {
          ToastManager.showSuccess(context, 'Password reset successful');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } on AuthException catch (e) {
        if (context.mounted) {
          ToastManager.showError(context, e.message);
        }
      } catch (e) {
        if (context.mounted) {
          ToastManager.showError(context, e.toString());
        }
      } finally {
        isBusy.value = false;
      }
    }

    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child:
              emailSent.value
                  ? SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: otpController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password Reset Token',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the password reset token';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'New Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed:
                                  () =>
                                      showPassword.value = !showPassword.value,
                              icon: Icon(
                                showPassword.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                          obscureText: !showPassword.value,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Confirm Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed:
                                  () =>
                                      showConfirmPassword.value =
                                          !showConfirmPassword.value,
                              icon: Icon(
                                showConfirmPassword.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirm Password is required';
                            }
                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          obscureText: !showConfirmPassword.value,
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: isBusy.value ? null : resetPassword,
                          icon: const Icon(Icons.check),
                          label: const Text('Reset Password'),
                        ),
                      ],
                    ),
                  )
                  : SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            icon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed:
                              isBusy.value ? null : sendPasswordResetLink,
                          icon: const Icon(Icons.send),
                          label: const Text('Send Reset Link'),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed:
                              () => pageController.animateToPage(
                                0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              ),
                          child: const Text('Back to Login'),
                        ),
                      ],
                    ),
                  ),
        ),
      ),
    );
  }
}
