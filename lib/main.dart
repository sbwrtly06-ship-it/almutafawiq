import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color navy = Color(0xFF172B4D);
const Color purple = Color(0xFF6542D3);
const Color lightPurple = Color(0xFFF3F0FF);
const Color gold = Color(0xFFFFC94A);

void main() {
  runApp(const AlMutafawiqApp());
}

class AlMutafawiqApp extends StatelessWidget {
  const AlMutafawiqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'المتفوق',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFFBFAFF),
        colorScheme: ColorScheme.fromSeed(seedColor: purple),
      ),
      home: const StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  Future<void> openNext(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final created = prefs.getBool('account_created') ?? false;

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => created ? const HomeScreen() : const WelcomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 500)),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: purple),
            ),
          );
        }
        return FutureBuilder(
          future: openNext(context),
          builder: (_, __) => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: purple),
            ),
          ),
        );
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                '🎓',
                style: TextStyle(fontSize: 58),
              ),
              const SizedBox(height: 8),
              const Text(
                'المتفوق',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),
              const Text(
                'طريقك نحو التفوق يبدأ من هنا',
                style: TextStyle(fontSize: 17, color: navy),
              ),
              const SizedBox(height: 35),
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: lightPurple,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: const Column(
                  children: [
                    Text('👨‍🎓', style: TextStyle(fontSize: 110)),
                    SizedBox(height: 10),
                    Text(
                      'ركّز على هدفك',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: purple,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المتفوق'),
        backgroundColor: navy,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'مرحبًا بك في تطبيق المتفوق',
          style: TextStyle(fontSize: 22, color: navy),
        ),
      ),
    );
  }
}
