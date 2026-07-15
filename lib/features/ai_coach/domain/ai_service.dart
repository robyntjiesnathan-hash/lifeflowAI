import '../../profile/domain/user_profile.dart';
import 'ai_message.dart';

/// Abstraction over "whatever answers the user in the AI Coach chat."
///
/// [MockAiService] (see `data/mock_ai_service.dart`) is the only
/// implementation shipped this pass — canned, keyword-matched responses
/// streamed word-by-word to simulate typing. Swapping in a real LLM later
/// (e.g. the Claude API) means writing a new class that implements this
/// exact interface and pointing `aiServiceProvider`
/// (`application/ai_service_provider.dart`) at it, or overriding it via
/// `ProviderScope(overrides: [aiServiceProvider.overrideWithValue(...)])` —
/// nothing else in the ai_coach feature needs to change.
abstract class AiService {
  /// Streams the assistant's reply to [userMessage] as incremental text
  /// chunks (each emitted value is the chunk itself, not the accumulated
  /// text so far — callers accumulate). [history] is the structured
  /// conversation-so-far (oldest first) so a real LLM implementation can
  /// replay it as proper role-tagged turns. [coachingStyle] optionally
  /// tunes tone (supportive/direct/analytical/playful) per the signed-in
  /// user's profile preference.
  Stream<String> sendMessage({
    required String conversationId,
    required List<AiMessage> history,
    required String userMessage,
    CoachingStyle? coachingStyle,
  });
}
