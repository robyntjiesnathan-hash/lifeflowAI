import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/mock_ai_service.dart';
import '../domain/ai_service.dart';

part 'ai_service_provider.g.dart';

/// The single seam a future real-LLM integration (e.g. Anthropic's Claude
/// API) replaces: swap the implementation constructed here, or override it
/// at the top of the widget tree with
/// `ProviderScope(overrides: [aiServiceProvider.overrideWithValue(RealAiService(...))])`.
/// Nothing else in the ai_coach feature depends on which [AiService]
/// implementation is wired up here.
@riverpod
AiService aiService(Ref ref) => MockAiService();
