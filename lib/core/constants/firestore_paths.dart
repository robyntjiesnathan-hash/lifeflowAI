/// Single source of truth for Firestore collection/subcollection names.
/// Nearly everything nests under `users/{uid}/**` — see firestore.rules for
/// the corresponding per-user ownership rule.
class FirestorePaths {
  const FirestorePaths._();

  static const String users = 'users';
  static const String tasks = 'tasks';
  static const String habits = 'habits';
  static const String completions = 'completions';
  static const String goals = 'goals';
  static const String milestones = 'milestones';
  static const String reminders = 'reminders';
  static const String mealPlans = 'mealPlans';
  static const String recipes = 'recipes';
  static const String shoppingList = 'shoppingList';
  static const String budget = 'budget';
  static const String transactions = 'transactions';
  static const String bills = 'bills';
  static const String aiConversations = 'aiConversations';
  static const String messages = 'messages';
  static const String badges = 'badges';
  static const String gamification = 'gamification';
}
