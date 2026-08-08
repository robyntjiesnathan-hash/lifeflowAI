import 'bill.dart';
import 'budget_profile.dart';
import 'transaction.dart';

abstract class BudgetRepository {
  Stream<BudgetProfile> watchProfile(String uid);

  Future<void> saveProfile(String uid, BudgetProfile profile);

  Stream<List<BudgetTransaction>> watchTransactions(String uid);

  Future<BudgetTransaction> addTransaction(String uid, BudgetTransaction transaction);

  Future<void> deleteTransaction(String uid, String transactionId);

  Stream<List<Bill>> watchBills(String uid);

  Future<Bill> addBill(String uid, Bill bill);

  Future<void> updateBill(String uid, Bill bill);

  Future<void> deleteBill(String uid, String billId);
}
