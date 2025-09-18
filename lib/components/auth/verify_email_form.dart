import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/components/dialog_manager.dart';
import 'package:rift/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmailVerificationForm extends HookConsumerWidget {
  final String? email;
  const EmailVerificationForm({super.key, this.email});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController(text: email);
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
        isBusy.value = false;
        if (context.mounted) {
          context.go('/home');
        }
      } on AuthException catch (e) {
        isBusy.value = false;
        if (context.mounted) {
          DialogManager.showDialog(context, e.message, DialogType.error);
        }
      } catch (e) {
        isBusy.value = false;
        if (context.mounted) {
          DialogManager.showDialog(context, e.toString(), DialogType.error);
        }
      }
    }

    Future<void> sendToken() async {
      try {
        isBusy.value = true;
        await supabase.auth.signInWithOtp(email: emailController.text);
        if (context.mounted) {
          DialogManager.showDialog(
            context,
            'Token sent! Please check your email for the new token.',
            DialogType.success,
          );
        }
        tokenSent.value = true;
        isBusy.value = false;
      } on AuthException catch (e) {
        isBusy.value = false;
        if (context.mounted) {
          DialogManager.showDialog(context, e.message, DialogType.error);
        }
      } catch (e) {
        isBusy.value = false;
        if (context.mounted) {
          DialogManager.showDialog(context, e.toString(), DialogType.error);
        }
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              Text(
                'Please enter the verification token sent to your email (If you did not receive the token, please check your spam folder and resend the token after 1 minute)',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
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
              TextFormField(
                controller: otpController,
                decoration: InputDecoration(
                  labelText: 'Verification Token',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.token),
                ),
                autofillHints: [AutofillHints.oneTimeCode],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the verification token';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilledButton.icon(
                    onPressed: isBusy.value || tokenSent.value
                        ? null
                        : sendToken,
                    label: const Text('Send Token'),
                    icon: const Icon(Icons.send),
                  ),
                  FilledButton.icon(
                    onPressed: isBusy.value ? null : verifyToken,
                    label: const Text('Submit'),
                    icon: const Icon(Icons.check),
                  ),
                ],
              ),
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
