import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/dialog_manager.dart';
import 'package:rift/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmailVerificationForm extends HookConsumerWidget {
  const EmailVerificationForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final otpController = useTextEditingController();
    final isBusy = useState(false);
    final tokenSent = useState(false);

    Future<void> verifyToken() async {
      if (!formKey.currentState!.validate()) {
        return;
      }
      formKey.currentState!.save();
      try {
        isBusy.value = true;
        await supabase.auth.verifyOTP(
          email: emailController.text,
          token: otpController.text,
          type: OtpType.email,
        );
        await Future.delayed(const Duration(seconds: 1));
        if (context.mounted) {
          context.go('/home');
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

    Future<void> sendToken() async {
      try {
        isBusy.value = true;
        await supabase.auth.signInWithOtp(email: emailController.text);
        if (context.mounted) {
          DialogManager.showDialog(
            context,
            'Token resent! Please check your email for the new token.',
            DialogType.success,
          );
        }
        tokenSent.value = true;
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

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
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
                autofillHints: [AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
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
                    onPressed:
                        isBusy.value || tokenSent.value ? null : sendToken,
                    label: const Text('Resend Token'),
                    icon: const Icon(Icons.send),
                  ),
                  FilledButton.icon(
                    onPressed: isBusy.value ? null : verifyToken,
                    label: const Text('Submit'),
                    icon: const Icon(Icons.check),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
