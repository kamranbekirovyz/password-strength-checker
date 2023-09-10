import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _passwordController = TextEditingController();
  bool _isStrong = false;

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Strength Checker'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
                filled: true,
              ),
            ),
            const SizedBox(height: 16.0),
            AnimatedBuilder(
              animation: _passwordController,
              builder: (context, child) {
                final password = _passwordController.text;

                return PasswordStrengthChecker(
                  onStrengthChanged: (bool value) {
                    setState(() {
                      _isStrong = value;
                    });
                  },
                  value: password,
                );
              },
            ),
            const SizedBox(height: 24.0),
            Center(
              child: FilledButton(
                onPressed: _isStrong ? () {} : null,
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
