import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../application/budget_providers.dart';
import '../../domain/budget_profile.dart';
import '../../domain/currency_catalog.dart';

/// Opens a searchable list of [currencyCatalog] and, on selection, saves the
/// chosen code onto [profile] via [BudgetController.saveProfile].
Future<void> showCurrencyPickerSheet(BuildContext context, {required BudgetProfile profile}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => _CurrencyPickerSheet(profile: profile),
  );
}

class _CurrencyPickerSheet extends ConsumerStatefulWidget {
  const _CurrencyPickerSheet({required this.profile});

  final BudgetProfile profile;

  @override
  ConsumerState<_CurrencyPickerSheet> createState() => _CurrencyPickerSheetState();
}

class _CurrencyPickerSheetState extends ConsumerState<_CurrencyPickerSheet> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = _query.trim().toLowerCase();
    final results = query.isEmpty
        ? currencyCatalog
        : currencyCatalog
            .where((c) => c.name.toLowerCase().contains(query) || c.code.toLowerCase().contains(query))
            .toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Currency', style: theme.textTheme.titleLarge),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _query = v),
                decoration: const InputDecoration(
                  hintText: 'Search currencies',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: results.isEmpty
                    ? Center(child: Text('No matching currencies', style: theme.textTheme.bodyMedium))
                    : ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final currency = results[index];
                          final selected = currency.code == widget.profile.currency;
                          return ListTile(
                            leading: Text(currency.flagEmoji, style: const TextStyle(fontSize: 22)),
                            title: Text(currency.name),
                            subtitle: Text(currency.code),
                            trailing: selected ? Icon(Icons.check_rounded, color: theme.colorScheme.primary) : null,
                            onTap: () async {
                              await ref
                                  .read(budgetControllerProvider.notifier)
                                  .saveProfile(widget.profile.copyWith(currency: currency.code));
                              if (context.mounted) Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
