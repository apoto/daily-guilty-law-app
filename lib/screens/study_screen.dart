import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudyScreen extends ConsumerStatefulWidget {
  const StudyScreen({super.key});

  @override
  ConsumerState<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends ConsumerState<StudyScreen> {
  int currentCardIndex = 0;
  bool showAnswer = false;
  List<StudyCard> studyCards = [];

  @override
  void initState() {
    super.initState();
    loadStudyCards();
  }

  void loadStudyCards() {
    // モックデータ
    studyCards = [
      StudyCard(
        id: 'card1',
        category: '民法',
        question: '不法行為とは何ですか？',
        answer: '故意または過失によって他人の権利または法律上保護される利益を侵害する行為のこと。民法709条に規定されている。',
        lawRef: '民法第709条',
        difficulty: 2,
        tags: ['不法行為', '損害賠償'],
      ),
      StudyCard(
        id: 'card2',
        category: '刑法',
        question: '正当防衛の要件は？',
        answer: '①急迫不正の侵害があること ②自己または他人の権利を防衛するため ③やむを得ずにした行為であること',
        lawRef: '刑法第36条',
        difficulty: 3,
        tags: ['正当防衛', '違法性阻却事由'],
      ),
      StudyCard(
        id: 'card3',
        category: '憲法',
        question: '基本的人権の特徴は？',
        answer: '①固有性（生まれながらに持つ） ②不可侵性（侵すことができない） ③普遍性（すべての人が持つ）',
        lawRef: '憲法第11条、第97条',
        difficulty: 2,
        tags: ['基本的人権', '人権の本質'],
      ),
      StudyCard(
        id: 'card4',
        category: '労働法',
        question: '解雇権濫用法理とは？',
        answer: '解雇が客観的に合理的な理由を欠き、社会通念上相当であると認められない場合は、その権利を濫用したものとして無効とする法理。',
        lawRef: '労働契約法第16条',
        difficulty: 4,
        tags: ['解雇', '権利濫用'],
      ),
      StudyCard(
        id: 'card5',
        category: '商法',
        question: '株式会社の機関設計で必須の機関は？',
        answer: '株主総会と取締役（取締役会設置会社の場合は取締役会）。監査役や会計監査人は会社の規模等により設置義務がある。',
        lawRef: '会社法第295条等',
        difficulty: 3,
        tags: ['株式会社', '機関設計'],
      ),
    ];
  }

  void nextCard() {
    setState(() {
      if (currentCardIndex < studyCards.length - 1) {
        currentCardIndex++;
      } else {
        currentCardIndex = 0; // 最初に戻る
      }
      showAnswer = false;
    });
  }

  void previousCard() {
    setState(() {
      if (currentCardIndex > 0) {
        currentCardIndex--;
      } else {
        currentCardIndex = studyCards.length - 1; // 最後に移動
      }
      showAnswer = false;
    });
  }

  void toggleAnswer() {
    setState(() {
      showAnswer = !showAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (studyCards.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final currentCard = studyCards[currentCardIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('法律学習カード'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () {
              setState(() {
                studyCards.shuffle();
                currentCardIndex = 0;
                showAnswer = false;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Progress indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${currentCardIndex + 1} / ${studyCards.length}',
                  style: theme.textTheme.titleMedium,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    currentCard.category,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            LinearProgressIndicator(
              value: (currentCardIndex + 1) / studyCards.length,
              backgroundColor: theme.colorScheme.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.primary,
              ),
            ),

            const SizedBox(height: 24),

            // Difficulty indicator
            Row(
              children: [
                const Text('難易度: '),
                ...List.generate(5, (index) {
                  return Icon(
                    index < currentCard.difficulty
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.amber,
                    size: 20,
                  );
                }),
                const Spacer(),
                // Tags
                ...currentCard.tags
                    .take(2)
                    .map(
                      (tag) => Container(
                        margin: const EdgeInsets.only(left: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(tag, style: theme.textTheme.labelSmall),
                      ),
                    ),
              ],
            ),

            const SizedBox(height: 32),

            // Card
            Expanded(
              child: GestureDetector(
                onTap: toggleAnswer,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (!showAnswer) ...[
                            // Question side
                            Icon(
                              Icons.help_outline,
                              size: 48,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              '問題',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              currentCard.question,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Spacer(),
                            Text(
                              'タップして答えを表示',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ] else ...[
                            // Answer side
                            Icon(
                              Icons.lightbulb_outline,
                              size: 48,
                              color: Colors.amber,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              '答え',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.amber[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              currentCard.answer,
                              style: theme.textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surfaceVariant,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.gavel,
                                    size: 16,
                                    color: theme.colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    currentCard.lawRef,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'タップして問題に戻る',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Navigation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: previousCard,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('前へ'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: toggleAnswer,
                  icon: Icon(showAnswer ? Icons.quiz : Icons.lightbulb),
                  label: Text(showAnswer ? '問題' : '答え'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: nextCard,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('次へ'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StudyCard {
  final String id;
  final String category;
  final String question;
  final String answer;
  final String lawRef;
  final int difficulty;
  final List<String> tags;

  StudyCard({
    required this.id,
    required this.category,
    required this.question,
    required this.answer,
    required this.lawRef,
    required this.difficulty,
    required this.tags,
  });
}
