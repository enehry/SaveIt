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
  Future<void> addChallenge(Challenge challenge) async {
    Box<Challenge> challengeBox = Hive.box<Challenge>(kChallengeBox);
    challengeBox.add(challenge);
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

    // create a temporary challenge to update the deposits
    _challenge.deposits = tempList;
    // update the challenge in the Box
    await _challengeBox.put(_challenge.key, _challenge);
    _challenge = _challenge;
    notifyListeners();
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
            (_challenge.endDate.difference(DateTime.now()).inDays);
        break;
      case 'Weekly':
        frequencyCount = _challenge.remainingAmount() /
            (_challenge.endDate.difference(DateTime.now()).inDays / 7).ceil();
        break;
      case 'Monthly':
        frequencyCount = _challenge.remainingAmount() /
            (_challenge.endDate.difference(DateTime.now()).inDays / 30).ceil();
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
