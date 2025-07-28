import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserProfile? _currentUserProfile;

  // List of authorized admin emails
  static const List<String> adminEmails = [
    'admin@ecommerce.com',
    'manager@ecommerce.com',
    'youremail@example.com', // Add your email here
    // Note: user@demo.com is NOT in admin list - will be regular user
    // Add more admin emails here
  ];

  // List of authorized admin UIDs
  static const List<String> adminUIDs = [
    'XUOn6U0G4FdXtxLQMs0nGeyLDJq1', // Your Firebase user UID
    // Add more admin UIDs here
  ];

  User? get currentUser => _auth.currentUser;
  UserProfile? get currentUserProfile => _currentUserProfile;

  bool get isLoggedIn => currentUser != null;

  bool get isAdmin {
    if (!isLoggedIn) return false;

    final userEmail = currentUser!.email;
    final userUID = currentUser!.uid;

    return adminEmails.contains(userEmail) || adminUIDs.contains(userUID);
  }

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Load user profile after successful sign in
      if (result.user != null) {
        await _loadUserProfile(result.user!.uid);
      }

      notifyListeners();
      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Load user profile from Firestore
  Future<void> _loadUserProfile(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        _currentUserProfile =
            UserProfile.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
    } catch (e) {
      debugPrint('Error loading user profile: $e');
    }
  }

  // Get user profile by UID
  Future<UserProfile?> getUserProfile(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserProfile.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting user profile: $e');
      return null;
    }
  }

  // Sign up with email, password and profile information
  Future<UserCredential?> signUpWithEmailAndProfile({
    required String email,
    required String password,
    required String name,
    required String address,
    required String contactNumber,
  }) async {
    try {
      // Create user with email and password
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user profile in Firestore
      if (result.user != null) {
        final userProfile = UserProfile(
          uid: result.user!.uid,
          email: email,
          name: name,
          address: address,
          contactNumber: contactNumber,
          createdAt: DateTime.now(),
          isAdmin: adminEmails.contains(email) ||
              adminUIDs.contains(result.user!.uid),
        );

        // Save to Firestore
        await _firestore
            .collection('users')
            .doc(result.user!.uid)
            .set(userProfile.toMap());

        _currentUserProfile = userProfile;
      }

      notifyListeners();
      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Legacy method for backward compatibility
  Future<UserCredential?> signUpWithEmail(String email, String password) async {
    return signUpWithEmailAndProfile(
      email: email,
      password: password,
      name: 'User', // Default name
      address: 'Not provided',
      contactNumber: 'Not provided',
    );
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    _currentUserProfile = null;
    notifyListeners();
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Handle Firebase Auth exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Try again later.';
      default:
        return 'An error occurred: ${e.message}';
    }
  }
}
