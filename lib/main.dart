import 'package:flutter/material.dart';

void main() {
  runApp(const AlMutafawiqApp());
}

const purple = Color(0xFF6C3FD9);

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
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.school_rounded,
                  size: 120,
                  color: purple,
                ),
                const SizedBox(height: 25),
                const Text(
                  'المتفوق',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: purple,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'ركّز اليوم، واصنع مستقبلك',
                  style: TextStyle(fontSize: 19),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 45),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'ابدأ رحلتك',
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'المطور / المرتضى مسعّد',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('إنشاء حساب')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Icon(
                Icons.person_add,
                size: 65,
                color: purple,
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'اسم الطالب',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 15),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 15),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DurationScreen(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('متابعة'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DurationScreen extends StatelessWidget {
  const DurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('مدة الدراسة')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Icon(
                Icons.timer,
                size: 70,
                color: purple,
              ),
              const SizedBox(height: 20),
              const Text(
                'اختر مدة الدراسة اليومية',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              ...[30, 60, 90, 120, 180, 240].map(
                (minutes) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.access_time),
                    title: Text('$minutes دقيقة'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StudyTimeScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudyTimeScreen extends StatelessWidget {
  const StudyTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('وقت الدراسة')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Icon(
                Icons.schedule,
                size: 75,
                color: purple,
              ),
              const SizedBox(height: 20),
              const Text(
                'وقت بدء الدراسة',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'الوقت الافتراضي: 6:00 مساءً',
                style: TextStyle(fontSize: 18),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AppsScreen(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('متابعة'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppsScreen extends StatelessWidget {
  const AppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final apps = [
      'TikTok',
      'Instagram',
      'Snapchat',
      'YouTube',
      'Facebook',
      'WhatsApp',
      'Telegram',
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('التطبيقات المشتتة')),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'اختر التطبيقات التي تريد تقليل تشتيتها أثناء الدراسة',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: ListView(
                children: apps
                    .map(
                      (app) => SwitchListTile(
                        title: Text(app),
                        value: true,
                        onChanged: (_) {},
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FocusScreen(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('بدء التركيز'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  int seconds = 60 * 60;
  bool running = false;

  String get timeText {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:'
        '${secs.toString().padLeft(2, '0')}';
  }

  void startTimer() {
    if (running) return;

    setState(() => running = true);

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted || !running || seconds <= 0) {
        return false;
      }

      setState(() => seconds--);
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('جلسة التركيز')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.menu_book_rounded,
                  size: 100,
                  color: purple,
                ),
                const SizedBox(height: 25),
                const Text(
                  'ركز الآن 🎯',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  timeText,
                  style: const TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    color: purple,
                  ),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: startTimer,
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('ابدأ المؤقت'),
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
