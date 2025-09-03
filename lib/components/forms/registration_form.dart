import 'package:rift/components/forms/verify_email_form.dart';
import 'package:rift/components/toast.dart';
import 'package:rift/providers/supabase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegistrationForm extends HookConsumerWidget {
  const RegistrationForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>(), []);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final isBusy = useState(false);

    final supabase = ref.watch(supabaseProvider);

    Future<void> register() async {
      if (!formKey.currentState!.validate()) {
        return;
      }
      try {
        isBusy.value = true;
        await supabase.auth.signUp(
          email: emailController.text,
          password: passwordController.text,
        );
        if (context.mounted) {
          showModalBottomSheet(
            context: context,
            backgroundColor: Theme.of(context).colorScheme.surface,
            builder: (context) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 16,
                children: [
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  Expanded(child: VerifyEmailForm(email: emailController.text)),
                ],
              ),
            ),
          );
        }
      } on AuthException catch (e) {
        if (context.mounted) {
          showToast(context, e.message, ToastType.error);
        }
      } catch (e) {
        if (context.mounted) {
          showToast(context, e.toString(), ToastType.error);
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
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.visiblePassword,
                autofillHints: const [AutofillHints.password],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.visiblePassword,
                autofillHints: const [AutofillHints.password],
                validator: (value) {
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              FilledButton(
                onPressed: isBusy.value ? null : register,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
