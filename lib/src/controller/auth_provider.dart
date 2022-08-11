import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:save_it/src/models/challenge.dart';
import 'package:save_it/src/utils/constant.dart';

class AuthProvider with ChangeNotifier {
  // for authentication
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  final Box _authBox;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _name;
  String? get name => _name;

  void signIn() {
    _isSignedIn = true;
    notifyListeners();
  }

  AuthProvider(Box authBox) : _authBox = authBox {
    _initAuth();
  }

  void _initAuth() {
    final auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final isSkipped = _authBox.get('isSkippedAuth') ?? false;
    if (user != null || isSkipped) {
      _isSignedIn = true;
    }
  }

  Future signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();
    // Trigger the authentication flow
    if (FirebaseAuth.instance.currentUser != null) {
      return;
    }
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    if (FirebaseAuth.instance.currentUser != null) {
      _isSignedIn = true;
      _isLoading = false;
      syncDataFromFirebase(FirebaseAuth.instance.currentUser!.email);
      notifyListeners();
    }
  }

  void syncDataFromFirebase(email) async {
    final firestore = FirebaseFirestore.instance;
    // fetch all data from user email
    final snapshot = await firestore
        .collection('users')
        .doc(email)
        .collection('challenges')
        .get();
    List<Challenge> data =
        snapshot.docs.map((doc) => Challenge.fromMap(doc.data())).toList();

    // populate box challenges
    final box = Hive.box<Challenge>(kChallengeBox);

    for (var element in data) {
      if (!box.containsKey(element.id)) {
        box.put(element.id, element);
      }
    }
  }

  // skip authentication
  void skipAuth() async {
    // save user name to local storage
    final box = await Hive.openBox(kAuthBox);
    box.put('isSkippedAuth', true);
    _isSignedIn = true;

    notifyListeners();
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    _isSignedIn = false;
    notifyListeners();
  }

  Stream<User?> get userStream => FirebaseAuth.instance.userChanges();

  static User? get user => FirebaseAuth.instance.currentUser;
}
