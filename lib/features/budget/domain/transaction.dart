import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

enum TransactionType { income, expense }

enum RecurrenceRule { none, weekly, monthly }

class _TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const _TimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.tryParse(json);
    return null;
  }

  @override
  Object? toJson(DateTime? object) => object == null ? null : Timestamp.fromDate(object);
}

/// A single income or expense entry at `users/{uid}/transactions/{id}`.
///
/// Named `BudgetTransaction` (rather than `Transaction`) to avoid colliding
/// with `cloud_firestore`'s own `Transaction` type used by
/// `FirebaseFirestore.runTransaction`.
@freezed
abstract class BudgetTransaction with _$BudgetTransaction {
  const factory BudgetTransaction({
    required String id,
    @Default(TransactionType.expense) TransactionType type,
    required num amount,
    @Default('USD') String currency,
    String? categoryId,
    String? note,
    @_TimestampConverter() DateTime? date,
    @Default(false) bool isRecurring,
    @Default(RecurrenceRule.none) RecurrenceRule recurrenceRule,
    @_TimestampConverter() DateTime? createdAt,
  }) = _BudgetTransaction;

  const BudgetTransaction._();

  factory BudgetTransaction.fromJson(Map<String, dynamic> json) => _$BudgetTransactionFromJson(json);
}
