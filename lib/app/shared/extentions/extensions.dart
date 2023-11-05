extension StringExtensions on String {
  bool isNullOrBlank() => this == null || trim().isEmpty;

  double? toDouble() => this != null ? double.tryParse(this) : null;
}
