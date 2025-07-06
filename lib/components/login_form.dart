import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rift/main.dart';
import 'package:rift/screens/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'dialog.dart';
import 'glass_card.dart';

class LoginForm extends HookConsumerWidget {
  final PageController pageController;
  final TextEditingController emailController;
  const LoginForm({
    super.key,
    required this.pageController,
    required this.emailController,
  });

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
    }

    Future<void> googleSignIn() async {
      const webClientId = '941640972756-g7om5t0ijmu7ceei1p9apeqn1m8uvkef.apps.googleusercontent.com';
      const iosClientId = '941640972756-arn15b0pbgvh632idcbnlcdf4t31360v.apps.googleusercontent.com';

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
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
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                          : const Text('Login'),
                ),
                const SizedBox(height: 16),
                // TextButton(
                //   onPressed: () async {
                //     try {
                //       await googleSignIn();
                //       if (context.mounted) {
                //         Navigator.pushReplacement(
                //           context,
                //           MaterialPageRoute(builder: (context) => const HomeScreen()),
                //         );
                //       }
                //     } on AuthException catch (e) {
                //       if (context.mounted) {
                //         DialogManager.showDialog(context, e.message, DialogType.error);
                //       }
                //     } catch (e) {
                //       if (context.mounted) {
                //         DialogManager.showDialog(context, e.toString(), DialogType.error);
                //       }
                //     }
                //   },
                //   child: const Text('Sign in with Google'),
                // ),
                TextButton(
                  onPressed: () {
                    pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text('Don\'t have an account? Sign up'),
                ),
                TextButton(
                  onPressed: () {
                    pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text('Need to verify email?'),
                ),
                TextButton(
                  onPressed: () {
                    pageController.animateToPage(
                      3,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
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
