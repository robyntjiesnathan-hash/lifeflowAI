import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lifeflow_ai/app.dart';
import 'package:lifeflow_ai/core/config/app_config.dart';
import 'package:lifeflow_ai/core/providers/shared_preferences_provider.dart';

void main() {
  testWidgets('LifeFlowApp boots to the welcome screen without a live Firebase project', (tester) async {
    AppConfig.forceFakeAuth();
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const LifeFlowApp(),
      ),
    );
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 300));
    }

    expect(find.text('LifeFlow AI'), findsWidgets);
    expect(find.text('Continue as guest'), findsOneWidget);
  });
}
