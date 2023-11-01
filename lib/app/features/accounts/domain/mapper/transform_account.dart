import '../../data/datasources/local/hive/account_object.dart';
import '../models/account.dart';

Account transformToAccount(AccountObject accountObject) => Account(
      id: accountObject.id,
      accountNumber: accountObject.accountNumber,
      accountName: accountObject.accountName,
      accountType: accountObject.accountType,
      accountBalance: accountObject.accountBalance,
      totalCreditAmount: accountObject.totalCreditAmount,
      totalDebitAmount: accountObject.totalDebitAmount,
      key: accountObject.key,
    );

AccountObject transformToAccountObject(Account account) => AccountObject(
      id: account.id,
      accountNumber: account.accountNumber,
      accountName: account.accountName,
      accountType: account.accountType,
      accountBalance: account.accountBalance,
      totalCreditAmount: account.totalCreditAmount,
      totalDebitAmount: account.totalDebitAmount,
    );
