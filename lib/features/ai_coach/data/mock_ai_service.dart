import 'dart:async';
import 'dart:math';

import '../../profile/domain/user_profile.dart';
import '../domain/ai_message.dart';
import '../domain/ai_service.dart';

/// Keyword-matched, canned-response stand-in for a real LLM.
///
/// Detects a rough "intent" from the user's message via simple substring
/// matching, picks a [CoachingStyle]-flavored template (falling back to the
/// supportive variant when a style-specific one hasn't been written), and
/// streams it back word-by-word with small randomized delays so the chat UI
/// gets a realistic typing/streaming effect. This is the one class a real
/// LLM integration (see [AiService]'s doc comment) would replace.
class MockAiService implements AiService {
  @override
  Stream<String> sendMessage({
    required String conversationId,
    required List<AiMessage> history,
    required String userMessage,
    CoachingStyle? coachingStyle,
  }) {
    final intent = _detectIntent(userMessage.toLowerCase());
    final response = _responseFor(intent, coachingStyle ?? CoachingStyle.supportive);
    return _streamWords(response);
  }

  /// Splits [text] on single spaces and re-emits each token (with its
  /// separating space re-attached) as its own stream event, so joining every
  /// emitted chunk reproduces [text] exactly regardless of embedded
  /// newlines. A slightly longer pause follows tokens containing a newline
  /// so multi-line/checklist replies read with a natural beat between
  /// lines instead of a flat metronome.
  Stream<String> _streamWords(String text) async* {
    final random = Random();
    final words = text.split(' ');
    for (var i = 0; i < words.length; i++) {
      yield i == 0 ? words[i] : ' ${words[i]}';
      final hasLineBreak = words[i].contains('\n');
      await Future.delayed(Duration(milliseconds: hasLineBreak ? 90 : 25 + random.nextInt(25)));
    }
  }

  String _responseFor(String intent, CoachingStyle style) {
    final variants = _catalog[intent] ?? _catalog[_fallbackKey]!;
    return variants[style] ?? variants[CoachingStyle.supportive] ?? variants.values.first;
  }

  String _detectIntent(String message) {
    for (final entry in _intentKeywords.entries) {
      if (entry.value.any((keyword) => message.contains(keyword))) return entry.key;
    }
    return _fallbackKey;
  }

  static const String _fallbackKey = 'fallback';

  static const Map<String, List<String>> _intentKeywords = {
    'plan_day': ['plan my day', 'plan today', 'plan the day', 'schedule my day', 'organize my day', 'plan my'],
    'goal': ['goal', 'ambition', 'milestone', 'target'],
    'habit': ['habit', 'streak', 'routine', 'consistency', 'consistent'],
    'budget': ['budget', 'save money', 'saving', 'spending', 'expense', 'money'],
    'meal': ['cook', 'meal', 'recipe', 'eat', 'food', 'dinner', 'lunch', 'breakfast'],
    'stress': ['stressed', 'overwhelmed', 'anxious', 'burnt out', 'burned out', 'stress'],
    'motivate': ['motivate', 'motivation', 'unmotivated', 'lazy', 'procrastinat'],
    'study': ['study', 'exam', 'homework', 'revise', 'revision', 'studying'],
  };

  static final Map<String, Map<CoachingStyle, String>> _catalog = {
    'plan_day': {
      CoachingStyle.supportive:
          "Sure! Here's a plan for you:\n"
          "✓ 2h Deep Work in the morning\n"
          "✓ Gym in the evening\n"
          "✓ Healthy meals\n"
          "✓ Focus on top 3 tasks\n"
          "You've got this today. Want me to add this to your planner?",
      CoachingStyle.direct:
          "Here's today's plan. Execute in order:\n"
          "✓ 2h Deep Work, first thing\n"
          "✓ Top 3 tasks — nothing else\n"
          "✓ Gym, evening\n"
          "✓ Meals prepped, no mid-day decisions\n"
          "Add this to your planner now?",
      CoachingStyle.analytical:
          "Based on your habit streaks and open tasks, here's an optimized plan:\n"
          "✓ 2h Deep Work in the morning (your highest-focus window)\n"
          "✓ Gym in the evening (protects your current streak)\n"
          "✓ Healthy meals (stabilizes afternoon energy)\n"
          "✓ Focus on top 3 tasks (best impact-to-effort ratio)\n"
          "Want me to add this to your planner and track completion?",
      CoachingStyle.playful:
          "Ooh, let's do this! Here's your plan for today:\n"
          "✓ 2h Deep Work in the morning ✨\n"
          "✓ Gym in the evening 💪\n"
          "✓ Healthy meals 🥗\n"
          "✓ Focus on top 3 tasks 🎯\n"
          "Want me to sneak this into your planner?",
    },
    'goal': {
      CoachingStyle.supportive:
          "I love that you're thinking about your goals! Break it into small milestones and "
          "celebrate every bit of progress — even 1% forward is still forward. Want help "
          "turning it into a step-by-step plan?",
      CoachingStyle.direct:
          "Pick one goal. Set a deadline. Break it into weekly milestones. Review progress every "
          "Sunday. Which goal do you want to lock in first?",
      CoachingStyle.analytical:
          "Goals stick best when they're specific and measurable. Try: current state → target → "
          "timeframe → weekly checkpoint. Which of your active goals is furthest behind its "
          "milestone pace right now?",
      CoachingStyle.playful:
          "Goals, let's gooo! 🚀 Pick your target, split it into bite-size wins, and stack up "
          "those small victories. Which goal are we leveling up today?",
    },
    'habit': {
      CoachingStyle.supportive:
          "Consistency beats intensity — one small habit done daily compounds into something "
          "huge. Don't worry about a missed day, just don't miss two in a row. What habit are "
          "you working on?",
      CoachingStyle.direct:
          "Anchor the habit to something you already do daily, keep it under 5 minutes to start, "
          "and track it visibly. Which habit needs the most attention right now?",
      CoachingStyle.playful:
          "Streaks are basically a video game you're winning at! 🔥 Keep the chain going — what "
          "habit are we protecting today?",
    },
    'budget': {
      CoachingStyle.supportive:
          "Managing money can feel stressful, but small changes add up gently over time. Try "
          "reviewing your biggest spending category this week and see if there's one easy swap. "
          "Want me to help you look at your budget?",
      CoachingStyle.direct:
          "Cut your top discretionary category by 15% this month. Automate a transfer to savings "
          "on payday, before you can spend it. Want me to pull up your current budget breakdown?",
      CoachingStyle.analytical:
          "Looking at typical spending patterns, food and shopping categories usually have the "
          "most flexible room. A 10-15% trim there, redirected to savings, compounds "
          "significantly over a year. Want a category-by-category breakdown?",
      CoachingStyle.playful:
          "Let's make your money work smarter, not harder! 💰 Find one splurge category and give "
          "it a friendly little haircut. Want to look at your budget together?",
    },
    'meal': {
      CoachingStyle.supportive:
          "Here are a few gentle ideas: a big veggie stir-fry, a warm grain bowl, or a simple "
          "sheet-pan chicken with roasted veggies. All quick, filling and nourishing. Want a full "
          "recipe for one of these?",
      CoachingStyle.direct:
          "Grilled chicken, roasted veggies, rice. 25 minutes, minimal cleanup, high protein. Want "
          "the full recipe?",
      CoachingStyle.playful:
          "Ooh, food time! 🍳 How about a rainbow veggie bowl or a cozy pasta night? Want me to "
          "pull up a recipe?",
    },
    'stress': {
      CoachingStyle.supportive:
          "That sounds really heavy right now, and it's okay to feel overwhelmed. Try picking "
          "just one small thing to do next, and let the rest wait. You don't have to carry it "
          "all at once. Want to talk through what's on your plate?",
      CoachingStyle.direct:
          "Write down everything on your mind, then cut the list to your top 3. Everything else "
          "waits until tomorrow. What's the single most urgent thing right now?",
      CoachingStyle.analytical:
          "Overwhelm usually means too many open loops at once. Try a brain-dump, then triage by "
          "urgency vs. importance — most items aren't actually urgent. Want to work through your "
          "list together?",
      CoachingStyle.playful:
          "Deep breath in, deep breath out 🌿 — one thing at a time, you've got this. What's "
          "weighing on you most right now?",
    },
    'motivate': {
      CoachingStyle.supportive:
          "You don't need to feel motivated to start — starting is what creates the motivation. "
          "Just take the smallest possible first step. I believe in you!",
      CoachingStyle.direct:
          "Motivation is unreliable. Discipline isn't. Do the smallest version of the task right "
          "now, for two minutes. Momentum will carry you from there.",
      CoachingStyle.playful:
          "You've got this, champion! 🌟 Pick the tiniest first step and just go — future-you "
          "will be so proud.",
    },
    'study': {
      CoachingStyle.supportive:
          "Break your study session into focused 25-minute chunks with short breaks in between — "
          "it's kinder to your brain than one long grind. What subject are you tackling?",
      CoachingStyle.direct:
          "25 minutes focused, 5 minute break, repeat. Phone in another room. What are you "
          "studying?",
      CoachingStyle.analytical:
          "Spaced repetition and active recall outperform re-reading by a wide margin. Try "
          "quizzing yourself instead of just reviewing notes. What's the topic?",
      CoachingStyle.playful:
          "Study time! 📚 Let's Pomodoro this — 25 minutes on, 5 off, repeat. What are we "
          "learning today?",
    },
    _fallbackKey: {
      CoachingStyle.supportive:
          "I'm here for whatever you need — planning your day, building habits, budgeting, meals, "
          "or just talking things through. What would help most right now?",
      CoachingStyle.direct:
          "Tell me what you need: plan, habits, budget, meals, or motivation. I'll get straight to "
          "it.",
      CoachingStyle.playful:
          "Hey there! ✨ I'm Flow — ask me to plan your day, help you save, suggest a meal, or "
          "just cheer you on. What's up?",
    },
  };
}
