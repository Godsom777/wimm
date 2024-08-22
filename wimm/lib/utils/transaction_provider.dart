import 'package:flutter/material.dart';
import '../auth/transaction_services.dart';
import '../models/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  final TransactionService _transactionService = TransactionService();
  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  Future<void> fetchTransactions() async {
    _transactions = await _transactionService.getTransactions();
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await _transactionService.addTransaction(transaction);
    await fetchTransactions();
  }

  Future<void> updateTransaction(String id, TransactionModel transaction) async {
    await _transactionService.updateTransaction(id, transaction);
    await fetchTransactions();
  }

  Future<void> deleteTransaction(String id) async {
    await _transactionService.deleteTransaction(id);
    await fetchTransactions();
  }
}