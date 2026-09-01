import 'package:flutter/material.dart';

import '../../../core/widgets/empty_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
            child: Text(
              'История',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          const Expanded(
            child: EmptyState(
              icon: Icons.bar_chart_rounded,
              title: 'История пока пуста',
              description:
                  'Завершённые тренировки появятся здесь вместе с упражнениями, весом и повторениями.',
            ),
          ),
        ],
      ),
    );
  }
}
