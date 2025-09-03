import 'dart:async';

import 'package:rift/components/toast.dart';
import 'package:rift/providers/supabase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VerifyEmailForm extends HookConsumerWidget {
  final String? email;
  const VerifyEmailForm({super.key, this.email});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supabase = ref.watch(supabaseProvider);
    final formKey = useMemoized(() => GlobalKey<FormState>(), []);
    final emailController = useTextEditingController(text: email);
    final otpController = useTextEditingController();
    final isBusy = useState(false);
    final tokenSent = useState(false);
    final errorMessage = useState<String?>(null);
    final countdown = useState(0);

    useEffect(() {
      Timer? timer;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        countdown.value--;
        if (countdown.value <= 0) {
          timer.cancel();
        }
      });
      return () => timer?.cancel();
    }, [countdown.value == 60]);

    Future<void> sendOTP() async {
      if (emailController.text.isEmpty) {
        errorMessage.value = 'Please enter an email';
        return;
      }
      try {
        isBusy.value = true;
        errorMessage.value = null;
        await supabase.auth.signInWithOtp(email: emailController.text);
        tokenSent.value = true;
        countdown.value = 60;
      } on AuthException catch (e) {
        if (context.mounted) {
          errorMessage.value = e.message;
        }
      } catch (e) {
        if (context.mounted) {
          errorMessage.value = e.toString();
        }
      } finally {
        isBusy.value = false;
      }
    }

    Future<void> verifyOTP() async {
      if (!formKey.currentState!.validate()) {
        return;
      }
      try {
        isBusy.value = true;
        await supabase.auth.verifyOTP(
          type: OtpType.email,
          email: emailController.text,
          token: otpController.text,
        );
        if (context.mounted) {
          showToast(context, 'Login successful', ToastType.success);
        }
      } on AuthException catch (e) {
        if (context.mounted) {
          errorMessage.value = e.message;
        }
      } catch (e) {
        if (context.mounted) {
          errorMessage.value = e.toString();
        }
      } finally {
        isBusy.value = false;
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }

                  // Basic email regex pattern
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: otpController,
                      decoration: const InputDecoration(
                        isDense: true,
                        labelText: 'OTP',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      autofillHints: const [AutofillHints.oneTimeCode],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an OTP';
                        }
                        return null;
                      },
                    ),
                  ),
                  FilledButton(
                    onPressed: isBusy.value || tokenSent.value ? null : sendOTP,
                    child: tokenSent.value
                        ? Text('Resend in ${countdown.value}s')
                        : const Text('Send Token'),
                  ),
                ],
              ),
              FilledButton(
                onPressed: isBusy.value ? null : verifyOTP,
                child: const Text('Sign in'),
              ),
              if (errorMessage.value != null)
                Text(
                  errorMessage.value!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
