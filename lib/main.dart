import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const purple = Color(0xFF6C3FD9);
const navy = Color(0xFF172B4D);
const lightPurple = Color(0xFFF4F0FF);
const gold = Color(0xFFFFC857);

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
        fontFamily: 'Arial',
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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: lightPurple,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text('🎓', style: TextStyle(fontSize: 85)),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'المتفوق',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'ركّز اليوم، واصنع مستقبلك',
                  style: TextStyle(
                    fontSize: 19,
                    color: purple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'تطبيق يساعدك على تنظيم وقت دراستك، '
                  'زيادة تركيزك، ومتابعة تقدمك يومًا بعد يوم.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.6,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'ابدأ رحلتك',
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'المطور / المرتضى مسعّد',
                  style: TextStyle(color: Colors.black45),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> next() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('أكمل بيانات الحساب أولًا')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('student_name', nameController.text.trim());
    await prefs.setString('student_email', emailController.text.trim());

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DurationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Page(
      title: 'إنشاء الحساب',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.person_add_alt_1, size: 70, color: purple),
          const SizedBox(height: 20),
          const Text(
            'أنشئ حسابك',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          Field(controller: nameController, label: 'اسم الطالب', icon: Icons.person),
          Field(controller: emailController, label: 'البريد الإلكتروني', icon: Icons.email),
          Field(
            controller: passwordController,
            label: 'كلمة المرور',
            icon: Icons.lock,
            obscure: true,
          ),
          const Spacer(),
          FilledButton(
            onPressed: next,
            child: const Text('متابعة', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}

class DurationScreen extends StatefulWidget {
  const DurationScreen({super.key});

  @override
  State<DurationScreen> createState() => _DurationScreenState();
}

class _DurationScreenState extends State<DurationScreen> {
  int selected = 120;
  final options = [30, 60, 90, 120, 180, 240];

  Future<void> next() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('daily_goal_minutes', selected);

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const StudyTimeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Page(
      title: 'مدة الدراسة',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.timer, size: 70, color: purple),
          const SizedBox(height: 15),
          const Text(
            'كم تريد أن تدرس يوميًا؟',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          Expanded(
            child: ListView(
              children: options.map((minutes) {
                final active = minutes == selected;
                return Card(
                  color: active ? lightPurple : Colors.white,
                  child: ListTile(
                    leading: Icon(
                      active ? Icons.check_circle : Icons.circle_outlined,
                      color: active ? purple : Colors.grey,
                    ),
                    title: Text(
                      '$minutes دقيقة',
                      style: const TextStyle(fontSize: 18),
                    ),
                    onTap: () => setState(() => selected = minutes),
                  ),
                );
              }).toList(),
            ),
          ),
          FilledButton(
            onPressed: next,
            child: const Text('متابعة', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}

class StudyTimeScreen extends StatefulWidget {
  const StudyTimeScreen({super.key});

  @override
  State<StudyTimeScreen> createState() => _StudyTimeScreenState();
}

class _StudyTimeScreenState extends State<StudyTimeScreen> {
  TimeOfDay selected = const TimeOfDay(hour: 18, minute: 0);

  Future<void> chooseTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selected,
    );

    if (time != null) {
      setState(() => selected = time);
    }
  }

  Future<void> next() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('study_hour', selected.hour);
    await prefs.setInt('study_minute', selected.minute);

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AppsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Page(
      title: 'وقت الدراسة',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.schedule, size: 75, color: purple),
          const SizedBox(height: 20),
          const Text(
            'متى يبدأ وقت الدراسة؟',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 35),
          Card(
            color: lightPurple,
            child: ListTile(
              leading: const Icon(Icons.access_time, color: purple),
              title: Text(
                selected.format(context),
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text('اضغط لتغيير الوقت'),
              onTap: chooseTime,
            ),
          ),
          const Spacer(),
          FilledButton(
            onPressed: next,
            child: const Text('متابعة', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}

class AppsScreen extends StatefulWidget {
  const AppsScreen({super.key});

  @override
  State<AppsScreen> createState() => _AppsScreenState();
}

class _AppsScreenState extends State<AppsScreen> {
  final apps = <String, bool>{
    'TikTok': true,
    'Instagram': true,
    'Snapchat': true,
    'YouTube': false,
    'Facebook': true,
    'WhatsApp': false,
    'Telegram': false,
  };

  Future<void> start() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'blocked_apps',
      apps.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList(),
    );

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FocusScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final count = apps.values.where((v) => v).length;

    return Page(
      title: 'التطبيقات المشتتة',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.phone_android, size: 70, color: purple),
          const SizedBox(height: 15),
          const Text(
            'اختر التطبيقات التي تشتتك',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'سيتم تجهيز وضع التركيز لمنع التشتت أثناء الدراسة',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView(
              children: apps.keys.map((app) {
                return SwitchListTile(
                  title: Text(app),
                  secondary: const Icon(Icons.apps, color: purple),
                  value: apps[app]!,
                  onChanged: (value) {
                    setState(() => apps[app] = value);
                  },
                );
              }).toList(),
            ),
          ),
          Text(
            'تم اختيار $count تطبيقات',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          FilledButton(
            onPressed: start,
            child: const Text('بدء التركيز', style: TextStyle(fontSize: 18)),
          ),
        ],
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
  Timer? timer;
  int seconds = 60 * 60;
  bool running = false;

  void toggle() {
    if (running) {
      timer?.cancel();
      setState(() => running = false);
      return;
    }

    setState(() => running = true);

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds <= 1) {
        timer?.cancel();
        setState(() {
          seconds = 0;
          running = false;
        });
      } else {
        setState(() => seconds--);
      }
    });
  }

  void reset() {
    timer?.cancel();
    setState(() {
      seconds = 60 * 60;
      running = false;
    });
  }

  String get timeText {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;

    return '${h.toString().padLeft(2, '0')}:'
        '${m.toString().padLeft(2, '0')}:'
        '${s.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Page(
      title: 'جلسة التركيز',
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Icon(Icons.menu_book, size: 85, color: purple),
          const SizedBox(height: 25),
          const Text(
            'وقت التركيز',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          Text(
            timeText,
            style: const TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),
          const SizedBox(height: 25),
          LinearProgressIndicator(
            value: seconds / 3600,
            minHeight: 10,
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: FilledButton.icon(
              onPressed: toggle,
              icon: Icon(running ? Icons.pause : Icons.play_arrow),
              label: Text(
                running ? 'إيقاف مؤقت' : 'ابدأ المؤقت',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: reset,
            child: const Text('إعادة ضبط'),
          ),
        ],
      ),
    );
  }
}

class Page extends StatelessWidget {
  final String title;
  final Widget child;

  const Page({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: navy,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(22),
          child: child,
        ),
      ),
    );
  }
}

class Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscure;

  const Field({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
