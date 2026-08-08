import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_paths.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/flow_mascot.dart';
import '../../application/ai_coach_providers.dart';
import '../../domain/ai_coach_exceptions.dart';
import '../../domain/ai_message.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/suggested_prompt_chip.dart';

/// AI Coach chat screen. Serves both `/coach` (no conversation specified —
/// resumes the most recently updated conversation if one exists, otherwise
/// shows a welcome bubble + suggested prompts and lazily creates a
/// conversation on the first message) and `/coach/:conversationId` (resumes
/// that specific thread) — see [conversationId].
class AiCoachScreen extends ConsumerStatefulWidget {
  const AiCoachScreen({super.key, this.conversationId});

  /// The conversation to resume, or `null` to auto-select the most recent
  /// conversation (if any exist) or start a fresh one on first send.
  final String? conversationId;

  @override
  ConsumerState<AiCoachScreen> createState() => _AiCoachScreenState();
}

class _AiCoachScreenState extends ConsumerState<AiCoachScreen> {
  static const List<String> _suggestedPrompts = [
    'Plan my day.',
    'Help me save money.',
    'What should I cook?',
    'Motivate me.',
  ];

  String? _conversationId;
  bool _autoPickAttempted = false;
  bool _sending = false;

  final _inputController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _conversationId = widget.conversationId;
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _send(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || _sending) return;
    _inputController.clear();
    setState(() => _sending = true);
    _scrollToBottom();
    try {
      final usedId = await ref.read(aiCoachControllerProvider.notifier).sendMessage(_conversationId, trimmed);
      if (mounted && usedId.isNotEmpty && usedId != _conversationId) {
        setState(() => _conversationId = usedId);
      }
    } on AiCoachMessageLimitReached {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("You've reached the free limit of $kFreeMessageLimit messages with Flow."),
          action: SnackBarAction(label: 'Upgrade', onPressed: () => context.push(RoutePaths.premium)),
        ),
      );
    } finally {
      if (mounted) setState(() => _sending = false);
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Auto-select the most recently updated conversation the first time we
    // render with no explicit conversationId and none chosen yet.
    if (widget.conversationId == null && _conversationId == null && !_autoPickAttempted) {
      final conversations = ref.watch(conversationsProvider).value;
      if (conversations != null) {
        _autoPickAttempted = true;
        if (conversations.isNotEmpty) {
          final pickedId = conversations.first.id;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _conversationId = pickedId);
          });
        }
      }
    }

    final activeId = _conversationId;
    final messagesAsync = activeId == null
        ? const AsyncValue<List<AiMessage>>.data(<AiMessage>[])
        : ref.watch(conversationMessagesProvider(activeId));
    final streaming = ref.watch(aiCoachStreamingReplyProvider);
    final isStreamingHere = streaming != null && streaming.conversationId == activeId;

    final messages = messagesAsync.value ?? const <AiMessage>[];
    final showWelcome = messages.isEmpty && !isStreamingHere;

    if (messages.isNotEmpty || isStreamingHere) _scrollToBottom();

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Coach'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: AppSpacing.md),
            child: FlowMascot(size: 32, animate: false),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  if (showWelcome) ...[
                    const ChatBubble(
                      message: AiMessage(
                        id: 'welcome',
                        role: AiMessageRole.assistant,
                        content: 'Hi! How can I help you today?',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        for (final prompt in _suggestedPrompts)
                          SuggestedPromptChip(label: prompt, onTap: () => _send(prompt)),
                      ],
                    ),
                  ],
                  for (final message in messages) ChatBubble(message: message),
                  if (isStreamingHere)
                    streaming.text.isEmpty
                        ? const _TypingBubble()
                        : ChatBubble(
                            message: AiMessage(
                              id: 'streaming',
                              role: AiMessageRole.assistant,
                              content: streaming.text,
                            ),
                          ),
                ],
              ),
            ),
            _ComposerBar(controller: _inputController, sending: _sending, onSend: _send),
          ],
        ),
      ),
    );
  }
}

class _ComposerBar extends StatelessWidget {
  const _ComposerBar({required this.controller, required this.sending, required this.onSend});

  final TextEditingController controller;
  final bool sending;
  final ValueChanged<String> onSend;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.md),
      child: Row(
        children: [
          // Attach stub: file/photo attachments are out of scope for this
          // pass — intentionally a no-op.
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded),
            onPressed: () {},
            tooltip: 'Attach (coming soon)',
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: BorderRadius.circular(AppRadii.pill),
              ),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: sending ? null : onSend,
                decoration: const InputDecoration(
                  hintText: 'Message Flow...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          IconButton.filled(
            onPressed: sending ? null : () => onSend(controller.text),
            icon: sending
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.arrow_upward_rounded),
          ),
        ],
      ),
    );
  }
}

/// Left-aligned bubble with three pulsing dots, shown while Flow's reply is
/// streaming in but no text has arrived yet.
class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const FlowMascot(size: 28, animate: false),
          const SizedBox(width: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 14),
            decoration: BoxDecoration(
              color: theme.cardTheme.color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadii.lg),
                topRight: Radius.circular(AppRadii.lg),
                bottomRight: Radius.circular(AppRadii.lg),
                bottomLeft: Radius.circular(4),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child:
                      Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle),
                          )
                          .animate(onPlay: (c) => c.repeat())
                          .fadeIn(delay: (i * 150).ms, duration: 400.ms)
                          .then()
                          .fadeOut(duration: 400.ms),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
