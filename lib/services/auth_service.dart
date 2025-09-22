import 'package:calorie_calculator/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestoreService = FirestoreService();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  
  Future<User?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final user = userCredential.user;
      if (user != null) {
        final existingUser = await firestoreService.getUserById(user.uid);
        if (existingUser == null) {
          await _saveUser(
            user: user,
            name: user.displayName ?? "",
          );
        }
      }
      return user;
    } catch (e) {
      print('Google sign-in failed: $e');
      return null;
    }
  }

  Future<User?> loginWithFacebook() async {
    try {
      final LoginResult loginResult = await _facebookAuth.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(
              '${loginResult.accessToken?.tokenString}');

      final UserCredential userCredential =
          await _auth.signInWithCredential(facebookAuthCredential);

      final user = userCredential.user;

      if (user != null) {
        final existingUser = await firestoreService.getUserById(user.uid);
        if (existingUser == null) {
          await _saveUser(
            user: user,
            name: user.displayName ?? "",
          );
        }
      }
      return user;
    } catch (e) {
      print('Facebook sign-in failed: $e');
      return null;
    }
  }

  Future<void> _saveUser({
    required User user,
    required String name,
  }) async {
    await firestoreService.addUser(
      uid: user.uid,
      name: name,
      email: user.email ?? "",
      createdAt: Timestamp.now(),
    );
  }

  Future<String?> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      await _saveUser(user: user!, name: name);

      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.reload();

      await logout();

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'This email is already in use. Please log in or use a different email.';
      } else if (e.code == 'invalid-email') {
        return 'The email address is not valid.';
      } else if (e.code == 'weak-password') {
        return 'The password is too weak.';
      } else {
        return 'Registration failed. Please try again.';
      }
    } catch (e) {
      print('Registration error: $e');
      return 'An unknown error occurred.';
    }
  }

  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found with that email.';
      } else if (e.code == 'wrong-password') {
        return 'Incorrect password.';
      } else {
        return 'Invalid email or password. Please try again.';
      }
    } catch (_) {
      return 'An unknown error occurred.';
    }
  }

  Future<String> getCurrentUserId() async {
    final user = _auth.currentUser;
    if (user == null) {
      return '';
    }
    return user.uid;
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await _facebookAuth.logOut();
  }
}
