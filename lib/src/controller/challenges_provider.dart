import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:save_it/src/components/app_snack_bar.dart';
import 'package:save_it/src/models/challenge.dart';
import 'package:save_it/src/models/deposit.dart';
import 'package:save_it/src/utils/constant.dart';
import 'package:uuid/uuid.dart';

class ChallengesProvider with ChangeNotifier {
  ChallengesProvider() {
    _initChallenges();
    _connectivity();
  }

  bool? _isConnected;

  _initChallenges() async {
    //fetch data from firebase firestore
    if (FirebaseAuth.instance.currentUser == null) return;

    final email = FirebaseAuth.instance.currentUser!.email;
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

  _connectivity() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _isConnected = false;
      } else {
        _isConnected = true;
      }
      syncData();
      notifyListeners();
    });
  }

  Future<void> syncData() async {
    if (_isConnected == true) {
      // all data that are not sync will be sync
      final box = Hive.box<Challenge>(kChallengeBox);
      final data = box.values.where((element) => element.isSync == false);
      final db = FirebaseFirestore.instance;
      if (FirebaseAuth.instance.currentUser == null) return;
      final col = db
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('challenges');
      for (var element in data) {
        col.doc(element.id).set(element.toMap());
      }
    }
  }

  Future<void> addChallenge(Challenge challenge) async {
    Box<Challenge> challengeBox = Hive.box<Challenge>(kChallengeBox);

    // save deposit to the firebase
    if (_isConnected == true) {
      // check if user is logged in
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        challenge.isSync = true;
        final col = FirebaseFirestore.instance
            .collection('users')
            .doc(user.email)
            .collection('challenges');
        col.doc(challenge.id).set(challenge.toMap());
      }
    }
    challengeBox.put(challenge.id, challenge);
  }

  String? _selectedChallengeId;
  String? get selectedChallengeId => _selectedChallengeId;

  final Box<Challenge> _challengeBox = Hive.box<Challenge>(kChallengeBox);

  ValueListenable<Box<Challenge>> getChallenges() => _challengeBox.listenable();

  late Challenge _challenge;

  Challenge? get challenge => _challenge;

  void setChallenge(Challenge challenge) => _challenge = challenge;

  // delete Challenge from Box
  Future<void> deleteChallenge(Challenge challenge) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _selectedChallengeId = challenge.id;
    _challengeBox.delete(challenge.key);

    // delete challenge from firebase
    if (_isConnected == true) {
      // check if user is logged in
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final col = FirebaseFirestore.instance
            .collection('users')
            .doc(user.email)
            .collection('challenges');
        col.doc(challenge.id).delete();
      }
    }
  }

  void filterList(String filter) {
    // filter the box
  }

  // deposit money to challenge
  Future<void> depositToChallenge(double amount) async {
    final List<Deposit> tempList = [];
    tempList.addAll(_challenge.deposits);

    tempList.add(
      Deposit(
        id: const Uuid().v4(),
        amount: amount,
        createdAt: DateTime.now(),
      ),
    );
    bool isSync = false;
    // check if connectivity is available
    if (_isConnected == true) {
      // check if user is logged in
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final col = FirebaseFirestore.instance
            .collection('users')
            .doc(user.email)
            .collection('challenges')
            .doc(_challenge.id);
        col.update({
          'isSync': true,
          'deposits': tempList.map((e) => e.toMap()).toList()
        });
        isSync = true;
      }
    }

    // create a temporary challenge to update the deposits
    _challenge.deposits = tempList;
    _challenge.isSync = isSync;
    // update the challenge in the Box
    await _challengeBox.put(_challenge.key, _challenge);
    _challenge = _challenge;
    notifyListeners();
    // save deposit to the firebase

    // show snackbar
    AppSnackBar(
            icon: const Icon(
              Icons.check_outlined,
              color: Colors.green,
            ),
            message: 'Save successfully')
        .showSnackBar();
  }

  // update the challenge
  Future<void> updateChallenge(Challenge challenge) async {
    bool isSync = false;
    // check if connectivity is available
    if (_isConnected == true) {
      // check if user is logged in
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final col = FirebaseFirestore.instance
            .collection('users')
            .doc(user.email)
            .collection('challenges')
            .doc(challenge.id);
        col.update({
          'isSync': true,
          'deposits': challenge.deposits.map((e) => e.toMap()).toList()
        });
        isSync = true;
      }
    }
    challenge.isSync = isSync;
    _challengeBox.put(challenge.key, challenge);
    notifyListeners();
    // show snackbar
    AppSnackBar(
            icon: const Icon(
              Icons.check_outlined,
              color: Colors.green,
            ),
            message: 'Update successfully')
        .showSnackBar();
  }

  // calculate the  daily, weekly, monthly amount challenge
  int calculateAmountPerFrequency(
      String frequency, String startDate, String endDate, String totalAmount) {
    if (endDate.isEmpty || startDate.isEmpty || totalAmount.isEmpty) {
      return 0;
    }
    final startDateTime = DateFormat.yMd().parse(startDate);
    final endDateTime = DateFormat.yMd().parse(endDate);
    final totalAmountDouble = double.parse(totalAmount.replaceAll(',', ''));

    double frequencyCount = 0;
    switch (frequency) {
      case 'Daily':
        frequencyCount =
            totalAmountDouble / (endDateTime.difference(startDateTime).inDays);
        break;
      case 'Weekly':
        frequencyCount = totalAmountDouble /
            (endDateTime.difference(startDateTime).inDays / 7).ceil();
        break;
      case 'Monthly':
        frequencyCount = totalAmountDouble /
            (endDateTime.difference(startDateTime).inDays / 30).ceil();
        break;
      default:
        frequencyCount = 0;
    }
    return (frequencyCount.isNaN ||
            frequencyCount.isNegative ||
            frequencyCount.isInfinite)
        ? 0
        : frequencyCount.ceil();
  }

  int calculateUpdateAmountPerFrequency() {
    if (_challenge.total == 0) {
      return 0;
    }

    double frequencyCount = 0;

    switch (_challenge.frequency) {
      case 'Daily':
        frequencyCount = _challenge.remainingAmount() /
            (_challenge.endDate.difference(DateTime.now()).inDays + 1);
        break;
      case 'Weekly':
        frequencyCount = _challenge.remainingAmount() /
            ((_challenge.endDate.difference(DateTime.now()).inDays + 1) / 7)
                .ceil();
        break;
      case 'Monthly':
        frequencyCount = _challenge.remainingAmount() /
            ((_challenge.endDate.difference(DateTime.now()).inDays + 1) / 30)
                .ceil();

        break;
      default:
        frequencyCount = 0;
    }

    return (frequencyCount.isNaN ||
            frequencyCount.isNegative ||
            frequencyCount.isInfinite)
        ? 0
        : frequencyCount.ceil();
  }
}
