import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:logger/logger.dart';
import '../models/bill_model.dart';
import '../models/user_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Logger _logger = Logger();

  User? get currentUser => _auth.currentUser;

  Future<bool> signUp(String email, String password, String name,
      String governorate, String mobileNumber, String nationalId) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'governorate': governorate,
        'mobileNumber': mobileNumber,
        'nationalId': nationalId,
      });
      return true;
    } catch (e) {
      _logger.e("Sign up error: $e");
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _logger.e("Sign in error: $e");
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String?> uploadFile(File file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      TaskSnapshot snapshot =
          await _storage.ref().child('files/$fileName').putFile(file);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      _logger.e("Upload file error: $e");
      return null;
    }
  }

  Future<void> reportIssue(Map<String, dynamic> issueData) async {
    try {
      await _firestore.collection('issues').add(issueData);
    } catch (e) {
      _logger.e("Report issue error: $e");
    }
  }

  Future<List<BillModel>> getBills(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('bills')
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs
          .map((doc) => BillModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _logger.e("Get bills error: $e");
      return [];
    }
  }

  Future<void> payBill(String userId, BillModel bill) async {
    try {
      await _firestore.collection('transactionHistory').add({
        'userId': userId,
        'details': bill.details,
        'month': bill.month,
        'price': bill.price,
        'timestamp': FieldValue.serverTimestamp(),
      });
      await _firestore.collection('bills').doc(bill.id).delete();
    } catch (e) {
      _logger.e("Pay bill error: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getTransactionHistory(
      String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('transactionHistory')
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      _logger.e("Get transaction history error: $e");
      return [];
    }
  }

  Future<UserModel> getCurrentUser() async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(currentUser!.uid).get();
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      _logger.e("Get current user error: $e");
      rethrow;
    }
  }

  Future<Map<DateTime, List<String>>> getHolidays() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('holidays').get();
      Map<DateTime, List<String>> holidays = {};
      for (var doc in querySnapshot.docs) {
        DateTime date = DateTime.parse(doc['date']);
        List<String> events = List<String>.from(doc['events']);
        holidays[date] = events;
      }
      return holidays;
    } catch (e) {
      _logger.e("Get holidays error: $e");
      return {};
    }
  }

  Future<List<String>> getGovDocuments(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('govDocuments')
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
    } catch (e) {
      _logger.e("Get government documents error: $e");
      return [];
    }
  }
}
