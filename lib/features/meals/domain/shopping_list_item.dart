import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shopping_list_item.freezed.dart';
part 'shopping_list_item.g.dart';

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

@freezed
abstract class ShoppingListItem with _$ShoppingListItem {
  const factory ShoppingListItem({
    required String id,
    required String name,
    @Default(1) double quantity,
    @Default('') String unit,
    @Default(false) bool isChecked,
    String? sourceMealPlanId,
    @_TimestampConverter() DateTime? addedAt,
  }) = _ShoppingListItem;

  factory ShoppingListItem.fromJson(Map<String, dynamic> json) => _$ShoppingListItemFromJson(json);
}
