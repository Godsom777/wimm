import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/transaction_model.dart';

class TransactionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      await _firestore.collection('transactions').add(transaction.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<List<TransactionModel>> getTransactions() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('transactions').get();
      return snapshot.docs.map((doc) => TransactionModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> updateTransaction(String id, TransactionModel transaction) async {
    try {
      await _firestore.collection('transactions').doc(id).update(transaction.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteTransaction(String id) async {
    try {
      await _firestore.collection('transactions').doc(id).delete();
    } catch (e) {
      print(e);
    }
  }
}