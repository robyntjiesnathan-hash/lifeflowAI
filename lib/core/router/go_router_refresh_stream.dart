import 'package:flutter/foundation.dart';

/// A [Listenable] GoRouter can use as `refreshListenable`. Call [refresh]
/// whenever auth or profile state changes (wired via `ref.listen` in
/// `app_router.dart`) so route redirects re-evaluate.
class GoRouterRefreshNotifier extends ChangeNotifier {
  void refresh() => notifyListeners();
}
