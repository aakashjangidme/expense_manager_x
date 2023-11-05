class AddAccountsScreenStateObject {
  final String? accountNumber;
  final String? accountName;
  final String? accountType;
  final double? accountBalance;
  final bool isLoading;
  final String? error;

  AddAccountsScreenStateObject({
    this.accountNumber,
    this.accountName,
    this.accountType,
    this.accountBalance,
    this.isLoading = false,
    this.error,
  });

  AddAccountsScreenStateObject copyWith({
    String? accountNumber,
    String? accountName,
    String? accountType,
    double? accountBalance,
    bool? isLoading,
    String? error,
  }) {
    return AddAccountsScreenStateObject(
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      accountType: accountType ?? this.accountType,
      accountBalance: accountBalance ?? this.accountBalance,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}