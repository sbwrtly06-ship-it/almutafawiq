import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color navy = Color(0xFF172B4D);
const Color purple = Color(0xFF6542D3);
const Color lightPurple = Color(0xFFF3F0FF);

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
        colorScheme: ColorScheme.fromSeed(seedColor: purple),
        scaffoldBackgroundColor: const Color(0xFFFBFAFF),
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
        builder: (_) =>
            created ? const HomeScreen() : const WelcomeScreen(),
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

        openNext(context);

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: purple),
          ),
        );
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Future<void> createAccount(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('account_created', true);

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 18,
          ),
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
                style: TextStyle(
                  fontSize: 17,
                  color: navy,
                ),
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
                    Text(
                      '👨‍🎓',
                      style: TextStyle(fontSize: 110),
                    ),
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
                      'نساعدك على تنظيم وقتك وتحقيق أحلامك الدراسية',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: FilledButton(
                  onPressed: () => createAccount(context),
                  child: const Text(
                    'ابدأ رحلتك',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'المطور / المرتضى مسعّد',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 15),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '🎯',
              style: TextStyle(fontSize: 70),
            ),
            const SizedBox(height: 20),
            const Text(
              'مرحبًا بك في المتفوق',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: navy,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'استعد لبدء رحلة التركيز والدراسة',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
