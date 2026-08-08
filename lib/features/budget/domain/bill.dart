import 'package:freezed_annotation/freezed_annotation.dart';

part 'bill.freezed.dart';
part 'bill.g.dart';

/// A recurring monthly bill at `users/{uid}/bills/{id}`.
@freezed
abstract class Bill with _$Bill {
  const factory Bill({
    required String id,
    required String name,
    required num amount,
    @Default(1) int dueDay,
    @Default(false) bool isAutoPay,
    @Default(false) bool isPaidThisCycle,
    String? categoryId,
    String? reminderId,
  }) = _Bill;

  const Bill._();

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);
}
