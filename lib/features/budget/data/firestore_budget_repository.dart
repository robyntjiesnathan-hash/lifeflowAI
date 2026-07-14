import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/firestore_paths.dart';
import '../domain/bill.dart';
import '../domain/budget_profile.dart';
import '../domain/budget_repository.dart';
import '../domain/transaction.dart';

class FirestoreBudgetRepository implements BudgetRepository {
  FirestoreBudgetRepository(this._firestore);

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _profileDoc(String uid) => _firestore
      .collection(FirestorePaths.users)
      .doc(uid)
      .collection(FirestorePaths.budget)
      .doc('profile');

  CollectionReference<Map<String, dynamic>> _transactionsCol(String uid) =>
      _firestore.collection(FirestorePaths.users).doc(uid).collection(FirestorePaths.transactions);

  CollectionReference<Map<String, dynamic>> _billsCol(String uid) =>
      _firestore.collection(FirestorePaths.users).doc(uid).collection(FirestorePaths.bills);

  @override
  Stream<BudgetProfile> watchProfile(String uid) {
    return _profileDoc(uid)
        .snapshots()
        .map((snap) => snap.exists && snap.data() != null ? BudgetProfile.fromJson(snap.data()!) : BudgetProfile.defaultProfile());
  }

  @override
  Future<void> saveProfile(String uid, BudgetProfile profile) =>
      _profileDoc(uid).set(profile.toJson(), SetOptions(merge: true));

  @override
  Stream<List<BudgetTransaction>> watchTransactions(String uid) {
    return _transactionsCol(uid).orderBy('date', descending: true).snapshots().map(
          (snap) => snap.docs.map((d) => BudgetTransaction.fromJson({...d.data(), 'id': d.id})).toList(),
        );
  }

  @override
  Future<BudgetTransaction> addTransaction(String uid, BudgetTransaction transaction) async {
    final doc = _transactionsCol(uid).doc();
    final withId = transaction.copyWith(id: doc.id, createdAt: DateTime.now());
    await doc.set(withId.toJson()..remove('id'));
    return withId;
  }

  @override
  Future<void> deleteTransaction(String uid, String transactionId) => _transactionsCol(uid).doc(transactionId).delete();

  @override
  Stream<List<Bill>> watchBills(String uid) {
    return _billsCol(uid).orderBy('dueDay').snapshots().map(
          (snap) => snap.docs.map((d) => Bill.fromJson({...d.data(), 'id': d.id})).toList(),
        );
  }

  @override
  Future<Bill> addBill(String uid, Bill bill) async {
    final doc = _billsCol(uid).doc();
    final withId = bill.copyWith(id: doc.id);
    await doc.set(withId.toJson()..remove('id'));
    return withId;
  }

  @override
  Future<void> updateBill(String uid, Bill bill) =>
      _billsCol(uid).doc(bill.id).set(bill.toJson()..remove('id'), SetOptions(merge: true));

  @override
  Future<void> deleteBill(String uid, String billId) => _billsCol(uid).doc(billId).delete();
}
