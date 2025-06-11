import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import '../screens/home_screen.dart';
import 'glass_card.dart';
import 'toast.dart';

class LoginForm extends HookConsumerWidget {
  final PageController pageController;
  final TextEditingController emailController;
  const LoginForm({super.key, required this.pageController, required this.emailController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final passwordController = useTextEditingController();
    final showPassword = useState(false);
    final isBusy = useState(false);

    Future<void> login() async {
      if (formKey.currentState!.validate()) {
        isBusy.value = true;
        try {
          await supabase.auth.signInWithPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          if (context.mounted) {
            ToastManager.showSuccess(context, 'Login successful');
            Navigator.pushReplacement(
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
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  controller: emailController,
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
                TextFormField(
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
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: login,
                  icon: Icon(Icons.login),
                  label:
                      isBusy.value
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(color: Colors.white),
                          )
                          : const Text('Login'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  },
                  child: const Text('Don\'t have an account? Sign up'),
                ),
                TextButton(
                  onPressed: () {
                    pageController.animateToPage(2, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  },
                  child: const Text('Need to verify email?'),
                ),
                TextButton(
                  onPressed: () {
                    pageController.animateToPage(3, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  },
                  child: const Text('Forgot password?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
