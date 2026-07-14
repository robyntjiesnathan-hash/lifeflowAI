import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../auth/application/auth_providers.dart';
import '../data/fake_budget_repository.dart';
import '../data/firestore_budget_repository.dart';
import '../domain/bill.dart';
import '../domain/budget_profile.dart';
import '../domain/budget_repository.dart';
import '../domain/transaction.dart';

part 'budget_providers.g.dart';

@Riverpod(keepAlive: true)
BudgetRepository budgetRepository(Ref ref) {
  if (AppConfig.useFakeAuth) return FakeBudgetRepository();
  return FirestoreBudgetRepository(ref.watch(firestoreProvider));
}

String? _currentUid(Ref ref) => ref.watch(authStateChangesProvider).value?.uid;

@riverpod
Stream<BudgetProfile> budgetProfile(Ref ref) {
  final uid = _currentUid(ref);
  if (uid == null) return Stream.value(BudgetProfile.defaultProfile());
  return ref.watch(budgetRepositoryProvider).watchProfile(uid);
}

@riverpod
Stream<List<BudgetTransaction>> transactions(Ref ref) {
  final uid = _currentUid(ref);
  if (uid == null) return Stream.value(const []);
  return ref.watch(budgetRepositoryProvider).watchTransactions(uid);
}

@riverpod
Stream<List<Bill>> bills(Ref ref) {
  final uid = _currentUid(ref);
  if (uid == null) return Stream.value(const []);
  return ref.watch(budgetRepositoryProvider).watchBills(uid);
}

bool _isSameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

/// Minimal summary for the Home dashboard's "Budget Today" card.
///
/// - [spentToday]: sum of `expense`-type transaction amounts dated today.
/// - [budgetTarget]: the user's `monthlyBudgetTarget` from their budget
///   profile (i.e. the whole-month target, not a per-day figure — Home
///   decides how to present the pairing).
class BudgetTodaySummary {
  const BudgetTodaySummary({required this.spentToday, required this.budgetTarget});

  final num spentToday;
  final num budgetTarget;
}

@riverpod
Future<BudgetTodaySummary> todayBudgetSummary(Ref ref) async {
  final profile = await ref.watch(budgetProfileProvider.future);
  final txns = await ref.watch(transactionsProvider.future);
  final now = DateTime.now();
  final spentToday = txns
      .where((t) => t.type == TransactionType.expense && t.date != null && _isSameDay(t.date!, now))
      .fold<num>(0, (sum, t) => sum + t.amount);
  return BudgetTodaySummary(spentToday: spentToday, budgetTarget: profile.monthlyBudgetTarget);
}

@riverpod
class BudgetController extends _$BudgetController {
  @override
  FutureOr<void> build() {}

  String get _uid {
    final uid = ref.read(authStateChangesProvider).value?.uid;
    if (uid == null) throw StateError('No signed-in user');
    return uid;
  }

  Future<void> addTransaction(BudgetTransaction transaction) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(budgetRepositoryProvider).addTransaction(_uid, transaction));
  }

  Future<void> deleteTransaction(String transactionId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(budgetRepositoryProvider).deleteTransaction(_uid, transactionId));
  }

  Future<void> addBill(Bill bill) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(budgetRepositoryProvider).addBill(_uid, bill));
  }

  Future<void> updateBill(Bill bill) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(budgetRepositoryProvider).updateBill(_uid, bill));
  }

  Future<void> deleteBill(String billId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(budgetRepositoryProvider).deleteBill(_uid, billId));
  }

  Future<void> saveProfile(BudgetProfile profile) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(budgetRepositoryProvider).saveProfile(_uid, profile));
  }
}
