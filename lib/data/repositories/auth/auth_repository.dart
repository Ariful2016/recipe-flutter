import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_flutter/data/models/users/app_user.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Future<UserCredential> registerUser({
    required String name,
    required String email,
    required String password,
    required String contactNo,
    required String address,
    String? photoUrl,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email, password: password);

      AppUser user = AppUser(
        uid: userCredential.user!.uid, // Set uid from Firebase
        name: name,
        email: email,
        contactNo: contactNo,
        address: address,
        photoUrl: photoUrl,
      );

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(user.toMap());
      return userCredential;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<UserCredential> loginUser(String email, String password) async{
    try{
      return _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    }catch(e){
      throw Exception('Login failed: $e');
    }
  }

  Future<void> signOut() async{
    try{
      return _auth.signOut();
    }catch(e){
      throw Exception('Sign out failed: $e');
    }
  }

  Future<AppUser?> getUserData(String uid) async{
    try{
      DocumentSnapshot doc = await _firestore.collection('users')
          .doc(uid)
          .get();
      if(doc.exists){
        return AppUser.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    }catch(e){
      throw Exception('Failed to fetch user data: $e');
    }
  }

  Stream<User?> get authStateChange => _auth.authStateChanges();
}
