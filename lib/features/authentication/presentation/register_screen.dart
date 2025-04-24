import 'package:batch8_provider_firestore_24_4/features/authentication/presentation/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application/sign_up_validators.dart';
import '../data/firebase_auth_repository.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _passwordRepeatController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordRepeatController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordRepeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32,
                ),
                const Text("E-Mail"),
                TextFormField(
                  controller: _emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  validator: emailErrorText,
                ),
                SizedBox(
                  height: 32,
                ),
                const Text("Passwort"),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  validator: passwordErrorText,
                ),
                SizedBox(
                  height: 16,
                ),
                const Text("Passwort wiederholen"),
                TextFormField(
                  controller: _passwordRepeatController,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  validator: passwordErrorText,
                ),
                SizedBox(
                  height: 32,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        final passwordRepeat = _passwordRepeatController.text;

                        if (password != passwordRepeat) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Passwörter stimmen nicht überein"),
                            ),
                          );
                          return;
                        } else {
                          // Register with Firebase Auth
                          context
                              .read<FirebaseAuthRepository>()
                              .register(email, password);
                        }
                      }
                    },
                    child: Text(
                      "Registrieren",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("Du hast ein Konto?"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LogInPage()));
                    },
                    child: const Text("Zum Login"),
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
