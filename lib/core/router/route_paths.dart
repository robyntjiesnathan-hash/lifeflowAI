/// String path constants for every route, so screens never hardcode paths.
class RoutePaths {
  const RoutePaths._();

  static const String splash = '/splash';
  static const String onboarding = '/onboarding';

  static const String authWelcome = '/auth/welcome';
  static const String authSignIn = '/auth/sign-in';
  static const String authSignUp = '/auth/sign-up';
  static const String authForgotPassword = '/auth/forgot-password';

  static const String home = '/home';
  static const String planner = '/planner';
  static const String goals = '/goals';
  static const String profile = '/profile';

  static const String coach = '/coach';
  static const String habits = '/habits';
  static const String meals = '/meals';
  static const String mealsShoppingList = '/meals/shopping-list';
  static const String budget = '/budget';
  static const String budgetBills = '/budget/bills';
  static const String reminders = '/reminders';
  static const String notificationsSettings = '/notifications-settings';
  static const String premium = '/premium';
  static const String profileEdit = '/profile/edit';
  static const String profileAccount = '/profile/account';

  static String plannerTask(String taskId) => '/planner/task/$taskId';
  static String goalDetail(String goalId) => '/goals/$goalId';
  static String coachConversation(String conversationId) => '/coach/$conversationId';
  static String habitDetail(String habitId) => '/habits/$habitId';
  static String mealRecipe(String recipeId) => '/meals/recipe/$recipeId';
  static String budgetTransaction(String transactionId) => '/budget/transaction/$transactionId';
}
