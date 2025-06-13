import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import '../screens/home_screen.dart';
import 'glass_card.dart';
import 'dialog.dart';

class EmailVerificationForm extends HookConsumerWidget {
  final PageController pageController;
  final TextEditingController emailController;
  const EmailVerificationForm({super.key, required this.pageController, required this.emailController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final otpController = useTextEditingController();
    final isBusy = useState(false);

    Future<void> verifyEmail() async {
      if (!formKey.currentState!.validate()) {
        return;
      }
      formKey.currentState!.save();
      try {
        isBusy.value = true;
        await supabase.auth.verifyOTP(
          email: emailController.text,
          token: otpController.text,
          type: OtpType.signup,
        );
        if (context.mounted) {
          DialogManager.showDialog(context, 'Email verified successfully', DialogType.success);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
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

    Future<void> resendToken() async {
      try {
        isBusy.value = true;
        await supabase.auth.resend(
          type: OtpType.signup,
          email: emailController.text,
        );
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
                  controller: otpController,
                  decoration: InputDecoration(
                    labelText: 'Verification Token',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.token),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the verification token';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FilledButton.icon(
                      onPressed: isBusy.value ? null : resendToken,
                      label: const Text('Resend Token'),
                      icon: const Icon(Icons.send),
                    ),
                    FilledButton.icon(
                      onPressed: isBusy.value ? null : verifyEmail,
                      label: const Text('Submit'),
                      icon: const Icon(Icons.check),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  },
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
