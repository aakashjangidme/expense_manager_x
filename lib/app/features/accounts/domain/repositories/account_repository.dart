

import '../models/account.dart';

abstract class AccountRepository {
  Future<List<Account>> getAllAccounts();
  Future<void> insertAllAccounts(List<Account> accounts);
  Future<void> updateAccount(Account account);
  Future<void> insertAccount(Account account);
  Future<void> deleteAccount(Account account);
  Future<void> deleteAllAccounts();
  Future<Account?> getAccountById(Account account);
}