import 'package:flutter/material.dart';

import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/flow_mascot.dart';
import '../../domain/ai_message.dart';

/// A single chat bubble for the AI Coach thread. Assistant messages are
/// left-aligned with a small [FlowMascot] avatar in a light surface bubble;
/// user messages are right-aligned in a primary-gradient-tinted bubble.
///
/// Assistant content whose lines are prefixed with "✓ " renders those lines
/// as an inline checklist (matching the reference design's "Sure! Here's a
/// plan for you:" response with its checklist card).
class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});

  final AiMessage message;

  static const String checkPrefix = '✓ ';

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            const FlowMascot(size: 28, animate: false),
            const SizedBox(width: AppSpacing.sm),
          ],
          Flexible(child: _Bubble(isUser: isUser, content: message.content)),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.isUser, required this.content});

  final bool isUser;
  final String content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lines = content.split('\n');
    final hasChecklist = lines.any((line) => line.startsWith(ChatBubble.checkPrefix));

    return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 12),
      decoration: BoxDecoration(
        gradient: isUser ? AppGradients.primary : null,
        color: isUser ? null : theme.cardTheme.color,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(AppRadii.lg),
          topRight: const Radius.circular(AppRadii.lg),
          bottomLeft: Radius.circular(isUser ? AppRadii.lg : 4),
          bottomRight: Radius.circular(isUser ? 4 : AppRadii.lg),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.brightness == Brightness.dark
                ? Colors.black.withValues(alpha: 0.25)
                : const Color(0xFF6D5AE6).withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: hasChecklist
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: _buildLines(theme, lines),
            )
          : Text(content, style: _textStyle(theme)),
    );
  }

  List<Widget> _buildLines(ThemeData theme, List<String> lines) {
    final widgets = <Widget>[];
    for (final line in lines) {
      if (line.startsWith(ChatBubble.checkPrefix)) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  size: 16,
                  color: isUser ? Colors.white : theme.colorScheme.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Flexible(child: Text(line.substring(ChatBubble.checkPrefix.length), style: _textStyle(theme))),
              ],
            ),
          ),
        );
      } else if (line.isNotEmpty) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(line, style: _textStyle(theme)),
          ),
        );
      }
    }
    return widgets;
  }

  TextStyle _textStyle(ThemeData theme) =>
      (theme.textTheme.bodyLarge ?? const TextStyle()).copyWith(color: isUser ? Colors.white : null, height: 1.35);
}
