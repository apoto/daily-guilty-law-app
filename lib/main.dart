import 'package:flutter/material.dart';

void main() {
  runApp(const DailyGuiltyLawApp());
}

class DailyGuiltyLawApp extends StatelessWidget {
  const DailyGuiltyLawApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Guilty Law',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A), // 深い青（法律らしい権威ある色）
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E3A8A),
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3A8A),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Color(0xFF374151),
          ),
        ),
      ),
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
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeTabContent(),
    const QuizTabContent(),
    const QATabContent(),
    const StudyTabContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Guilty Law'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // 通知画面への遷移
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'ホーム',
          ),
          NavigationDestination(
            icon: Icon(Icons.quiz_outlined),
            selectedIcon: Icon(Icons.quiz),
            label: 'クイズ',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_outlined),
            selectedIcon: Icon(Icons.chat),
            label: 'Q&A',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: '学習',
          ),
        ],
      ),
    );
  }
}

class HomeTabContent extends StatelessWidget {
  const HomeTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ウェルカムセクション
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '今日の面白判例',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '法律を楽しく学ぼう！',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // 今日のクイズへ遷移
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('今日のクイズを始める'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 機能カード
          Text(
            '機能一覧',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _FeatureCard(
                  icon: Icons.quiz,
                  title: '面白判例クイズ',
                  description: '実際の変わった事件を\nクイズで学習',
                  color: Colors.orange,
                  onTap: () {
                    // クイズ画面へ
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _FeatureCard(
                  icon: Icons.chat_bubble,
                  title: 'AI法律相談',
                  description: '法律の疑問を\nAIに質問',
                  color: Colors.blue,
                  onTap: () {
                    // Q&A画面へ
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _FeatureCard(
                  icon: Icons.school,
                  title: '学習モード',
                  description: '法律用語を\n効率的に暗記',
                  color: Colors.green,
                  onTap: () {
                    // 学習画面へ
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _FeatureCard(
                  icon: Icons.trending_up,
                  title: '学習履歴',
                  description: '進捗を確認して\nモチベーション維持',
                  color: Colors.purple,
                  onTap: () {
                    // 履歴画面へ
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // 最近の学習
          Text(
            '最近の学習',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),

          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.orange,
                child: Icon(Icons.quiz, color: Colors.white),
              ),
              title: const Text('民法クイズ'),
              subtitle: const Text('昨日 • 正答率 80%'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // 学習詳細へ
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.chat, color: Colors.white),
              ),
              title: const Text('契約書について質問'),
              subtitle: const Text('3日前 • AI回答済み'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // 質問詳細へ
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color,
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// プレースホルダーページ
class QuizTabContent extends StatelessWidget {
  const QuizTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.quiz,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'クイズ機能',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('面白い判例クイズを実装予定'),
        ],
      ),
    );
  }
}

class QATabContent extends StatelessWidget {
  const QATabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'AI Q&A機能',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('AI法律相談機能を実装予定'),
        ],
      ),
    );
  }
}

class StudyTabContent extends StatelessWidget {
  const StudyTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            '学習機能',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('フラッシュカード学習を実装予定'),
        ],
      ),
    );
  }
}
