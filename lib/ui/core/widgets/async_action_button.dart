import 'package:flutter/material.dart';

class AsyncActionButton extends StatefulWidget {
  const AsyncActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final Future<void> Function() onPressed;
  final IconData? icon;

  @override
  State<AsyncActionButton> createState() => _AsyncActionButtonState();
}

class _AsyncActionButtonState extends State<AsyncActionButton> {
  bool _isRunning = false;

  Future<void> _run() async {
    if (_isRunning) return;
    setState(() => _isRunning = true);

    // Let Flutter paint the pressed state before the operation can complete.
    await WidgetsBinding.instance.endOfFrame;
    try {
      await widget.onPressed();
    } finally {
      if (mounted) setState(() => _isRunning = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: _isRunning ? null : _run,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        child: _isRunning
            ? Row(
                key: const ValueKey('async-action-progress'),
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 10),
                  Text(widget.label),
                ],
              )
            : Row(
                key: const ValueKey('async-action-label'),
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon),
                    const SizedBox(width: 8),
                  ],
                  Text(widget.label),
                ],
              ),
      ),
    );
  }
}
