import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/daily_case.dart';
import '../models/gacha_result.dart';
import '../providers/legal_providers.dart';

class QAScreen extends ConsumerStatefulWidget {
  const QAScreen({super.key});

  @override
  ConsumerState<QAScreen> createState() => _QAScreenState();
}

class _QAScreenState extends ConsumerState<QAScreen> {
  final TextEditingController _questionController = TextEditingController();
  String? _currentQuery;
  GachaResult? _result;
  String? _error;
  bool _isLoading = false;

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  void _submitQuestion() async {
    if (_questionController.text.trim().isEmpty) return;

    final question = _questionController.text.trim();

    setState(() {
      _isLoading = true;
      _result = null;
      _error = null;
    });

    try {
      // Vertex AI APIを使用して回答を生成
      final vertexAIService = ref.read(vertexAIServiceProvider);
      final result = await vertexAIService.generateQAResponse(question);

      setState(() {
        _result = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'エラーが発生しました: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI法律相談',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '法律に関する疑問をAIに質問してみましょう',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Question input
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '質問を入力してください',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _questionController,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              hintText: '例：賃貸契約で敷金が返ってこない場合、どうすればいいですか？',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _submitQuestion,
                              icon: const Icon(Icons.send),
                              label: const Text('質問する'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Answer section
                  if (_result != null) ...[
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.psychology,
                                    color: theme.colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'AI回答',
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Expanded(child: _buildAnswerContent()),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    // Sample questions
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'よくある質問',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: ListView(
                              children: [
                                _buildSampleQuestion(
                                  '賃貸契約のトラブルについて',
                                  '敷金が返ってこない場合の対処法は？',
                                  Icons.home,
                                ),
                                _buildSampleQuestion(
                                  '労働問題について',
                                  '残業代が支払われない場合はどうすれば？',
                                  Icons.work,
                                ),
                                _buildSampleQuestion(
                                  '交通事故について',
                                  '自転車事故の責任はどう判断される？',
                                  Icons.directions_bike,
                                ),
                                _buildSampleQuestion(
                                  '契約書について',
                                  'ネット通販の返品ルールは法的に有効？',
                                  Icons.shopping_cart,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Disclaimer
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.withOpacity(0.3)),
                    ),
                    child: Text(
                      '※本サービスは一般的な法律情報の提供を目的としており、個別の法律相談ではありません。具体的な法的問題については弁護士にご相談ください。',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.orange[800],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerContent() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('AIが回答を生成中...'),
          ],
        ),
      );
    } else if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(_error!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _submitQuestion(),
              child: const Text('再試行'),
            ),
          ],
        ),
      );
    } else if (_result != null) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Risk level indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getRiskColor(_result!).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _getRiskColor(_result!).withOpacity(0.5),
                ),
              ),
              child: Text(
                'リスクレベル: ${_result!.riskLevel}',
                style: TextStyle(
                  color: _getRiskColor(_result!),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Verdict phrase
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _result!.verdictPhrase,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Detail
            Text(_result!.detail, style: Theme.of(context).textTheme.bodyLarge),

            const SizedBox(height: 16),

            // Legal references
            if (_result!.refs.isNotEmpty) ...[
              Text(
                '関連条文',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ..._result!.refs.map(
                (ref) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '• $ref',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Legal disclaimer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Text(
                '※本情報は一般的解説です。個別相談は弁護士へご相談ください。',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.orange[800]),
              ),
            ),
          ],
        ),
      );
    } else {
      return const Center(child: Text('質問を入力してください'));
    }
  }

  Widget _buildSampleQuestion(String title, String question, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        subtitle: Text(question),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          _questionController.text = question;
        },
      ),
    );
  }

  Color _getRiskColor(GachaResult result) {
    switch (result.riskLevel) {
      case 'OK':
        return Colors.green;
      case 'グレー':
        return Colors.orange;
      case 'OUT':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
