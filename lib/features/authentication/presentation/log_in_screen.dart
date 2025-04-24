import 'package:batch8_provider_firestore_24_4/features/authentication/presentation/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application/sign_up_validators.dart';
import '../data/firebase_auth_repository.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                  height: 32,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final email = _emailController.text;
                        final password = _passwordController.text;

                        //TODO
                      }
                    },
                    child: Text(
                      "Anmelden",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("Passwort vergessen"),
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
                      child: Text("Noch kein Konto?"),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterPage()));
                    },
                    child: const Text("Kostenlos registrieren"),
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
