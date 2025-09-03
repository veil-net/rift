import 'package:rift/components/forms/login_form.dart';
import 'package:rift/components/forms/registration_form.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthPage extends HookConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Wrap(
              spacing: 8,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth:
                        MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.width * 0.75
                        : MediaQuery.of(context).size.width * 0.4,
                  ),
                  child:
                      MediaQuery.of(context).orientation == Orientation.portrait
                      ? Image.asset('assets/images/Logo_H.png')
                      : Image.asset('assets/images/Logo_V.png'),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth:
                        MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width * 0.5,
                    maxHeight:
                        MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.5
                        : MediaQuery.of(context).size.height * 0.75,
                  ),
                  child: Card(
                    elevation: 5,
                    color: Theme.of(context).colorScheme.surface,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TabBar(
                            tabs: [
                              Tab(text: 'Login'),
                              Tab(text: 'Register'),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [LoginForm(), RegistrationForm()],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
