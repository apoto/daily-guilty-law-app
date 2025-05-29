import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/daily_case.dart';
import '../providers/legal_providers.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  bool showResult = false;
  List<QuizResult> results = [];
  DateTime? questionStartTime;

  // モックデータ
  final List<QuizQuestion> mockQuestions = [
    QuizQuestion(
      id: 'q1',
      question: '隣人の猫が毎日自分の庭に入ってきて糞をしていく場合、法的にはどのような対応が可能でしょうか？',
      options: ['猫を捕獲して保健所に連れて行く', '隣人に対して損害賠償を請求する', '猫に直接危害を加える', '何もできない'],
      correctAnswerIndex: 1,
      explanation:
          '民法709条の不法行為に基づき、隣人に対して損害賠償を請求することが可能です。ただし、猫の飼い主としての注意義務違反を立証する必要があります。',
      category: '民法',
      difficulty: 3,
      lawRefs: ['民法第709条（不法行為による損害賠償）'],
    ),
    QuizQuestion(
      id: 'q2',
      question: 'SNSで他人の悪口を書き込んだ場合、どのような法的責任を負う可能性がありますか？',
      options: ['名誉毀損罪のみ', '侮辱罪のみ', '名誉毀損罪または侮辱罪', '法的責任はない'],
      correctAnswerIndex: 2,
      explanation:
          '具体的事実を摘示した場合は名誉毀損罪（刑法230条）、抽象的な悪口の場合は侮辱罪（刑法231条）に該当する可能性があります。',
      category: '刑法',
      difficulty: 2,
      lawRefs: ['刑法第230条（名誉毀損）', '刑法第231条（侮辱）'],
    ),
    QuizQuestion(
      id: 'q3',
      question: '会社員が副業を理由に解雇された場合、この解雇は有効でしょうか？',
      options: ['常に有効', '常に無効', '就業規則や副業の内容による', '労働基準監督署の判断による'],
      correctAnswerIndex: 2,
      explanation:
          '副業を理由とする解雇は、就業規則での禁止規定の有無、副業が本業に与える影響、競業避止義務違反の有無などを総合的に判断して決まります。',
      category: '労働法',
      difficulty: 4,
      lawRefs: ['労働契約法第16条（解雇）'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    questionStartTime = DateTime.now();
  }

  void selectAnswer(int index) {
    setState(() {
      selectedAnswerIndex = index;
    });
  }

  void submitAnswer() {
    if (selectedAnswerIndex == null) return;

    final question = mockQuestions[currentQuestionIndex];
    final isCorrect = selectedAnswerIndex == question.correctAnswerIndex;
    final timeSpent = DateTime.now().difference(questionStartTime!).inSeconds;

    final result = QuizResult(
      questionId: question.id,
      selectedAnswerIndex: selectedAnswerIndex!,
      isCorrect: isCorrect,
      answeredAt: DateTime.now(),
      timeSpentSeconds: timeSpent,
    );

    setState(() {
      results.add(result);
      showResult = true;
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < mockQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        showResult = false;
        questionStartTime = DateTime.now();
      });
    } else {
      // クイズ終了
      showQuizComplete();
    }
  }

  void showQuizComplete() {
    final correctCount = results.where((r) => r.isCorrect).length;
    final totalCount = results.length;
    final percentage = (correctCount / totalCount * 100).round();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('クイズ完了！'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              percentage >= 80 ? Icons.emoji_events : Icons.thumb_up,
              size: 64,
              color: percentage >= 80 ? Colors.amber : Colors.blue,
            ),
            const SizedBox(height: 16),
            Text(
              '正解率: $percentage%',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('$correctCount/$totalCount問正解'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetQuiz();
            },
            child: const Text('もう一度'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('終了'),
          ),
        ],
      ),
    );
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      selectedAnswerIndex = null;
      showResult = false;
      results.clear();
      questionStartTime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final question = mockQuestions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / mockQuestions.length;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress bar
              Row(
                children: [
                  Text(
                    '問題 ${currentQuestionIndex + 1}/${mockQuestions.length}',
                    style: theme.textTheme.titleMedium,
                  ),
                  const Spacer(),
                  Text(
                    question.category,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
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
                      index < question.difficulty
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 20,
                    );
                  }),
                ],
              ),

              const SizedBox(height: 24),

              // Question
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.question,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Options
                      ...question.options.asMap().entries.map((entry) {
                        final index = entry.key;
                        final option = entry.value;
                        final isSelected = selectedAnswerIndex == index;
                        final isCorrect = index == question.correctAnswerIndex;

                        Color? backgroundColor;
                        Color? borderColor;
                        if (showResult) {
                          if (isCorrect) {
                            backgroundColor = Colors.green.withOpacity(0.1);
                            borderColor = Colors.green;
                          } else if (isSelected && !isCorrect) {
                            backgroundColor = Colors.red.withOpacity(0.1);
                            borderColor = Colors.red;
                          }
                        } else if (isSelected) {
                          backgroundColor = theme.colorScheme.primaryContainer;
                          borderColor = theme.colorScheme.primary;
                        }

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            onTap: showResult
                                ? null
                                : () => selectAnswer(index),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                      borderColor ?? theme.colorScheme.outline,
                                  width: borderColor != null ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? theme.colorScheme.primary
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: theme.colorScheme.outline,
                                      ),
                                    ),
                                    child: isSelected
                                        ? const Icon(
                                            Icons.check,
                                            size: 16,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      option,
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  if (showResult && isCorrect)
                                    const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    ),
                                  if (showResult && isSelected && !isCorrect)
                                    const Icon(Icons.cancel, color: Colors.red),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),

                      if (showResult) ...[
                        const SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '解説',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                question.explanation,
                                style: theme.textTheme.bodyMedium,
                              ),
                              if (question.lawRefs.isNotEmpty) ...[
                                const SizedBox(height: 12),
                                Text(
                                  '関連条文',
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ...question.lawRefs.map(
                                  (ref) => Text(
                                    '• $ref',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Action button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: showResult
                      ? nextQuestion
                      : (selectedAnswerIndex != null ? submitAnswer : null),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    showResult
                        ? (currentQuestionIndex < mockQuestions.length - 1
                              ? '次の問題'
                              : '結果を見る')
                        : '回答する',
                    style: const TextStyle(fontSize: 16),
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
