import 'dart:async';

import 'package:uuid/uuid.dart';

import '../domain/bill.dart';
import '../domain/budget_profile.dart';
import '../domain/budget_repository.dart';
import '../domain/transaction.dart';

/// In-memory budget store for fake-auth mode, keyed by uid so each fake
/// session is isolated but persists for the app's lifetime. Mirrors
/// `FakeHabitsRepository`'s use of broadcast `StreamController`s that
/// re-emit on every mutation.
class FakeBudgetRepository implements BudgetRepository {
  static final Map<String, BudgetProfile> _profiles = {};
  static final Map<String, List<BudgetTransaction>> _transactions = {};
  static final Map<String, List<Bill>> _bills = {};

  static final Map<String, StreamController<BudgetProfile>> _profileControllers = {};
  static final Map<String, StreamController<List<BudgetTransaction>>> _transactionControllers = {};
  static final Map<String, StreamController<List<Bill>>> _billControllers = {};

  final _uuid = const Uuid();

  BudgetProfile _profileFor(String uid) => _profiles.putIfAbsent(uid, BudgetProfile.defaultProfile);

  StreamController<BudgetProfile> _profileControllerFor(String uid) =>
      _profileControllers.putIfAbsent(uid, () => StreamController<BudgetProfile>.broadcast());

  void _emitProfile(String uid) => _profileControllerFor(uid).add(_profileFor(uid));

  StreamController<List<BudgetTransaction>> _transactionControllerFor(String uid) =>
      _transactionControllers.putIfAbsent(uid, () => StreamController<List<BudgetTransaction>>.broadcast());

  void _emitTransactions(String uid) =>
      _transactionControllerFor(uid).add(List.unmodifiable(_transactions[uid] ?? const []));

  StreamController<List<Bill>> _billControllerFor(String uid) =>
      _billControllers.putIfAbsent(uid, () => StreamController<List<Bill>>.broadcast());

  void _emitBills(String uid) => _billControllerFor(uid).add(List.unmodifiable(_bills[uid] ?? const []));

  @override
  Stream<BudgetProfile> watchProfile(String uid) {
    final controller = _profileControllerFor(uid);
    Future.microtask(() => _emitProfile(uid));
    return controller.stream;
  }

  @override
  Future<void> saveProfile(String uid, BudgetProfile profile) async {
    _profiles[uid] = profile;
    _emitProfile(uid);
  }

  @override
  Stream<List<BudgetTransaction>> watchTransactions(String uid) {
    final controller = _transactionControllerFor(uid);
    Future.microtask(() => _emitTransactions(uid));
    return controller.stream.map((list) => [...list]..sort((a, b) => (b.date ?? b.createdAt ?? DateTime(1970))
        .compareTo(a.date ?? a.createdAt ?? DateTime(1970))));
  }

  @override
  Future<BudgetTransaction> addTransaction(String uid, BudgetTransaction transaction) async {
    final withId = transaction.copyWith(id: _uuid.v4(), createdAt: DateTime.now());
    _transactions.putIfAbsent(uid, () => []).add(withId);
    _emitTransactions(uid);
    return withId;
  }

  @override
  Future<void> deleteTransaction(String uid, String transactionId) async {
    _transactions[uid]?.removeWhere((t) => t.id == transactionId);
    _emitTransactions(uid);
  }

  @override
  Stream<List<Bill>> watchBills(String uid) {
    final controller = _billControllerFor(uid);
    Future.microtask(() => _emitBills(uid));
    return controller.stream.map((list) => [...list]..sort((a, b) => a.dueDay.compareTo(b.dueDay)));
  }

  @override
  Future<Bill> addBill(String uid, Bill bill) async {
    final withId = bill.copyWith(id: _uuid.v4());
    _bills.putIfAbsent(uid, () => []).add(withId);
    _emitBills(uid);
    return withId;
  }

  @override
  Future<void> updateBill(String uid, Bill bill) async {
    final list = _bills[uid];
    if (list == null) return;
    final index = list.indexWhere((b) => b.id == bill.id);
    if (index == -1) return;
    list[index] = bill;
    _emitBills(uid);
  }

  @override
  Future<void> deleteBill(String uid, String billId) async {
    _bills[uid]?.removeWhere((b) => b.id == billId);
    _emitBills(uid);
  }
}
