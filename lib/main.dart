import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final selectedApps = apps.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    await prefs.setStringList('blocked_apps', selectedApps);

    await prefs.setStringList(
      'blocked_packages',
      selectedApps
          .map((name) => blockedPackages[name] ?? '')
          .where((packageName) => packageName.isNotEmpty)
          .toList(),
    );

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
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

  int totalSeconds = 120 * 60;
  int remainingSeconds = 120 * 60;

  bool running = false;
  bool loaded = false;

  Timer? monitorTimer;
  String? lastDetectedPackage;

  static const usageChannel = MethodChannel('almutafawiq/usage');

  final blockedPackages = <String, String>{
    'TikTok': 'com.zhiliaoapp.musically',
    'Instagram': 'com.instagram.android',
    'Snapchat': 'com.snapchat.android',
    'YouTube': 'com.google.android.youtube',
    'Facebook': 'com.facebook.katana',
    'WhatsApp': 'com.whatsapp',
    'Telegram': 'org.telegram.messenger',
  };

  @override
  void initState() {
    super.initState();
    loadDuration();
  }

  Future<void> loadDuration() async {
    final prefs = await SharedPreferences.getInstance();
    final minutes = prefs.getInt('daily_goal_minutes') ?? 120;

    if (!mounted) return;

    setState(() {
      totalSeconds = minutes * 60;
      remainingSeconds = totalSeconds;
      loaded = true;
    });
  }

  Future<bool> hasUsageAccess() async {
    try {
      return await usageChannel.invokeMethod<bool>('hasUsageAccess') ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<void> openUsageAccessSettings() async {
    try {
      await usageChannel.invokeMethod('openUsageAccessSettings');
    } catch (_) {}
  }

  Future<void> startMonitoring() async {
    monitorTimer?.cancel();

    monitorTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => checkForegroundApp(),
    );

    await checkForegroundApp();
  }

  void stopMonitoring() {
    monitorTimer?.cancel();
    monitorTimer = null;
    lastDetectedPackage = null;
  }

  Future<void> setFocusMode(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('focus_mode_active', enabled);
  }

  Future<void> checkForegroundApp() async {
    if (!running) return;

    try {
      final package = await usageChannel.invokeMethod<String>(
        'getForegroundPackage',
      );

      if (package == null) return;

      String? detectedName;

      for (final entry in blockedPackages.entries) {
        if (package == entry.value) {
          detectedName = entry.key;
          break;
        }
      }

      if (detectedName == null) return;

      // لا نسجل التطبيق نفسه عدة مرات متتالية.
      if (lastDetectedPackage == package) return;

      lastDetectedPackage = package;

      final prefs = await SharedPreferences.getInstance();

      final now = DateTime.now();
      final dateKey =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-'
          '${now.day.toString().padLeft(2, '0')}';

      final key = 'distraction_attempts_$dateKey';

      final attempts = prefs.getInt(key) ?? 0;
      await prefs.setInt(key, attempts + 1);

      final namesKey = 'distraction_names_$dateKey';
      final names = prefs.getStringList(namesKey) ?? <String>[];
      names.add(detectedName);
      await prefs.setStringList(namesKey, names);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تم تسجيل محاولة تشتت: $detectedName',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (_) {
      // Usage Access قد لا يكون مفعلاً بعد.
    }
  }

  Future<void> toggleTimer() async {
    if (!loaded) return;

    if (running) {
      timer?.cancel();
      stopMonitoring();
      await setFocusMode(false);

      setState(() => running = false);
      return;
    }

    final access = await hasUsageAccess();

    if (!access) {
      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('صلاحية الوصول إلى الاستخدام'),
          content: const Text(
            'يحتاج وضع التركيز إلى صلاحية Usage Access '
            'لاكتشاف التطبيقات المشتتة أثناء جلسة التركيز.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('لاحقًا'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.pop(context);
                await openUsageAccessSettings();
              },
              child: const Text('فتح الإعدادات'),
            ),
          ],
        ),
      );

      return;
    }

    setState(() => running = true);

    await setFocusMode(true);
    await startMonitoring();

    timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      if (remainingSeconds <= 1) {
        timer?.cancel();
        stopMonitoring();
        await setFocusMode(false);

        setState(() {
          remainingSeconds = 0;
          running = false;
        });

        saveSession();
      } else {
        setState(() => remainingSeconds--);
      }
    });
  }

  Future<void> saveSession() async {
    final prefs = await SharedPreferences.getInstance();

    final completed =
        prefs.getInt('completed_focus_minutes') ?? 0;

    final studiedSeconds = totalSeconds - remainingSeconds;
    final studiedMinutes = studiedSeconds ~/ 60;

    await prefs.setInt(
      'completed_focus_minutes',
      completed + studiedMinutes,
    );

    await prefs.setString(
      'last_focus_session',
      DateTime.now().toIso8601String(),
    );
  }

  Future<void> resetTimer() async {
    timer?.cancel();
    stopMonitoring();

    await saveSession();

    setState(() {
      remainingSeconds = totalSeconds;
      running = false;
    });
  }

  String formatTime() {
    final hours = remainingSeconds ~/ 3600;
    final minutes = (remainingSeconds % 3600) ~/ 60;
    final seconds = remainingSeconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  double get progress {
    if (totalSeconds == 0) return 0;
    return (totalSeconds - remainingSeconds) / totalSeconds;
  }

  @override
  void dispose() {
    timer?.cancel();
    stopMonitoring();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Page(
      title: 'وقت التركيز',
      child: Column(
        children: [
          const SizedBox(height: 10),

          const Icon(
            Icons.menu_book_rounded,
            size: 75,
            color: purple,
          ),

          const SizedBox(height: 15),

          const Text(
            'جلسة التركيز',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'ركز على دراستك وابتعد عن المشتتات',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 30),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 35,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: lightPurple,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Text(
                  loaded ? formatTime() : '--:--',
                  style: const TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),

                const SizedBox(height: 20),

                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 12,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  '${(progress * 100).round()}% من الجلسة',
                  style: const TextStyle(
                    color: purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          SizedBox(
            width: double.infinity,
            height: 58,
            child: FilledButton.icon(
              onPressed: toggleTimer,
              icon: Icon(
                running ? Icons.pause : Icons.play_arrow,
              ),
              label: Text(
                running ? 'إيقاف مؤقت' : 'ابدأ التركيز',
                style: const TextStyle(fontSize: 19),
              ),
            ),
          ),

          const SizedBox(height: 10),

          TextButton.icon(
            onPressed: resetTimer,
            icon: const Icon(Icons.restart_alt),
            label: const Text('إعادة ضبط'),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String studentName = 'الطالب';
  int goalMinutes = 120;
  int studiedMinutes = 0;

  @override
  void initState() {
    super.initState();
    loadStats();
  }

  Future<void> loadStats() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      studentName = prefs.getString('student_name') ?? 'الطالب';
      goalMinutes = prefs.getInt('daily_goal_minutes') ?? 120;
      studiedMinutes = prefs.getInt('completed_focus_minutes') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = goalMinutes <= 0
        ? 0.0
        : (studiedMinutes / goalMinutes).clamp(0.0, 1.0);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F7FC),
        appBar: AppBar(
          title: const Text(
            'المتفوق',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: navy,
          foregroundColor: Colors.white,
        ),
        body: RefreshIndicator(
          onRefresh: loadStats,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'مرحبًا، $studentName 👋',
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'جاهز لجلسة تركيز جديدة؟',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 22),

              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      purple,
                      Color(0xFF8B6AE8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  children: [
                    const Text(
                      'هدفك اليوم',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$goalMinutes دقيقة',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 18),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 12,
                        backgroundColor: Colors.white30,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(gold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${(progress * 100).round()}% من الهدف',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.timer_outlined,
                      title: 'درست اليوم',
                      value: '$studiedMinutes',
                      unit: 'دقيقة',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.flag_outlined,
                      title: 'الهدف',
                      value: '$goalMinutes',
                      unit: 'دقيقة',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.auto_graph,
                          color: purple,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'إحصائيات اليوم',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: navy,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Text(
                      studiedMinutes == 0
                          ? 'لم تبدأ الدراسة اليوم بعد.'
                          : 'أحسنت! واصل حتى تحقق هدفك اليومي.',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 58,
                child: FilledButton.icon(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FocusScreen(),
                      ),
                    );
                    loadStats();
                  },
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text(
                    'ابدأ جلسة تركيز',
                    style: TextStyle(fontSize: 19),
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

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String unit;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Icon(icon, color: purple, size: 30),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),
          Text(
            unit,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
            ),
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
