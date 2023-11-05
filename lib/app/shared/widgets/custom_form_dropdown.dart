import 'package:flutter/material.dart';

class CustomFormDropdown<T> extends StatelessWidget {
  final T? selectedValue;
  final List<T> items;
  final String? hintText;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;

  const CustomFormDropdown({
    super.key,
    required this.selectedValue,
    required this.items,
    this.hintText,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButtonFormField<T>(
      validator: validator,
      value: selectedValue,
      elevation: 2,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurface.withOpacity(1),
      ),
      hint: Text(
        hintText ?? 'choose.',
        style: theme.textTheme.headlineSmall?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(1),
        ),
      ),
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString()),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
