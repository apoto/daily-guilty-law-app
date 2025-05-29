import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:card_swiper/card_swiper.dart';
import '../providers/legal_providers.dart';
import '../models/daily_case.dart';

class DailyCaseScreen extends ConsumerWidget {
  const DailyCaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyCaseAsync = ref.watch(dailyCaseProvider);

    return Scaffold(
      body: dailyCaseAsync.when(
        data: (dailyCase) => DailyCaseSwiper(cases: [dailyCase]),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                'エラーが発生しました',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(dailyCaseProvider),
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DailyCaseSwiper extends StatelessWidget {
  final List<DailyCase> cases;

  const DailyCaseSwiper({super.key, required this.cases});

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (context, index) {
        return DailyCaseCard(caseData: cases[index]);
      },
      itemCount: cases.length,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      pagination: cases.length > 1
          ? const SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeColor: Color(0xFF1E3A8A),
                color: Colors.grey,
              ),
            )
          : null,
    );
  }
}

class DailyCaseCard extends StatefulWidget {
  final DailyCase caseData;

  const DailyCaseCard({super.key, required this.caseData});

  @override
  State<DailyCaseCard> createState() => _DailyCaseCardState();
}

class _DailyCaseCardState extends State<DailyCaseCard> {
  bool showFullContent = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(16),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  children: [
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
                        '${widget.caseData.year} / ${widget.caseData.court}',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        // シェア機能
                      },
                      icon: const Icon(Icons.share_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        // いいね機能
                      },
                      icon: const Icon(Icons.favorite_border),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Title
                Text(
                  widget.caseData.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                // Answer Short (結論)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer.withOpacity(
                      0.3,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: theme.colorScheme.secondary.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    widget.caseData.answerShort,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.caseData.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tag,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                // Detailed content
                if (showFullContent) ...[
                  Text(
                    widget.caseData.answerLong,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),

                  // Law references
                  if (widget.caseData.lawRefs.isNotEmpty) ...[
                    Text(
                      '関連条文',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...widget.caseData.lawRefs.map((ref) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          '• $ref',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      );
                    }),
                  ],

                  const SizedBox(height: 16),

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
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.orange[800],
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 24),

                // Toggle button
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      setState(() {
                        showFullContent = !showFullContent;
                      });
                    },
                    icon: Icon(
                      showFullContent
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                    label: Text(showFullContent ? '閉じる' : 'もっと読む'),
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
