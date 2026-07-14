// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Bill _$BillFromJson(Map<String, dynamic> json) => _Bill(
  id: json['id'] as String,
  name: json['name'] as String,
  amount: json['amount'] as num,
  dueDay: (json['dueDay'] as num?)?.toInt() ?? 1,
  isAutoPay: json['isAutoPay'] as bool? ?? false,
  isPaidThisCycle: json['isPaidThisCycle'] as bool? ?? false,
  categoryId: json['categoryId'] as String?,
  reminderId: json['reminderId'] as String?,
);

Map<String, dynamic> _$BillToJson(_Bill instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'amount': instance.amount,
  'dueDay': instance.dueDay,
  'isAutoPay': instance.isAutoPay,
  'isPaidThisCycle': instance.isPaidThisCycle,
  'categoryId': instance.categoryId,
  'reminderId': instance.reminderId,
};
