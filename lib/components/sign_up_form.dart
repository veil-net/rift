import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import 'glass_card.dart';
import 'dialog.dart';

class SignUpForm extends HookConsumerWidget {
  final PageController pageController;
  final TextEditingController emailController;
  const SignUpForm({
    super.key,
    required this.pageController,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final passwordController = useTextEditingController();
    final showPassword = useState(false);
    final confirmPasswordController = useTextEditingController();
    final termsAccepted = useState(false);
    final isBusy = useState(false);

    Future<void> register() async {
      if (!termsAccepted.value) {
        DialogManager.showDialog(
          context,
          'Please accept the terms and conditions',
          DialogType.error,
        );
        return;
      }

      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        isBusy.value = true;
        try {
          await supabase.auth.signUp(
            email: emailController.text,
            password: passwordController.text,
          );
          if (context.mounted) {
            DialogManager.showDialog(
              context,
              'Registration successful! Please check your email for verification.',
              DialogType.success,
            );
            pageController.animateToPage(
              2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        } on AuthException catch (e) {
          if (context.mounted) {
            DialogManager.showDialog(context, e.message, DialogType.error);
          }
        } catch (e) {
          if (context.mounted) {
            DialogManager.showDialog(context, e.toString(), DialogType.error);
          }
        } finally {
          isBusy.value = false;
        }
      }
    }

    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        showPassword.value = !showPassword.value;
                      },
                      icon: Icon(
                        showPassword.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  obscureText: !showPassword.value,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        showPassword.value = !showPassword.value;
                      },
                      icon: Icon(
                        showPassword.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  obscureText: !showPassword.value,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: termsAccepted.value,
                      onChanged: (value) {
                        termsAccepted.value = value ?? false;
                      },
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          termsAccepted.value = !termsAccepted.value;
                        },
                        child: Text(
                          'I accept the Terms and Conditions and Privacy Policy',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: isBusy.value ? null : register,
                  icon: const Icon(Icons.person_add),
                  label: const Text('Register'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
