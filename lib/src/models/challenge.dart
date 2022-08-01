import 'dart:collection';

import 'package:hive/hive.dart';
import 'package:save_it/src/models/deposit.dart';

part 'challenge.g.dart';

@HiveType(typeId: 1, adapterName: 'ChallengesAdapter')
class Challenge extends HiveObject {
  @HiveField(0)
  final String id;
  // Hive fields go here
  @HiveField(1)
  String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  int iconCode;

  @HiveField(5)
  double total;

  @HiveField(7)
  DateTime dateCreated;

  @HiveField(8)
  DateTime? dateUpdated;

  @HiveField(9)
  DateTime startDate;

  @HiveField(10)
  DateTime endDate;

  @HiveField(11)
  String frequency;

  @HiveField(12)
  List<Deposit> deposits;

  Challenge({
    required this.id,
    required this.title,
    required this.iconCode,
    required this.total,
    required this.dateCreated,
    required this.startDate,
    required this.endDate,
    required this.frequency,
    // optional parameters
    this.description,
    this.dateUpdated,
    this.deposits = const [],
  });

  // copy with
  Challenge copyWith({
    String? id,
    String? title,
    String? description,
    int? iconCode,
    double? total,
    DateTime? dateCreated,
    DateTime? dateUpdated,
    DateTime? startDate,
    DateTime? endDate,
    String? frequency,
    List<Deposit>? deposits,
  }) {
    return Challenge(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      iconCode: iconCode ?? this.iconCode,
      total: total ?? this.total,
      dateCreated: dateCreated ?? this.dateCreated,
      dateUpdated: dateUpdated ?? this.dateUpdated,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      frequency: frequency ?? this.frequency,
      deposits: deposits ?? this.deposits,
    );
  }

  // this will check if the challenge is completed by checking the total amount and the current amount
  bool isCompleted() => depositAmount() >= total;

  // check if there is already a deposit for the given date
  bool isCompletedDaily() {
    if (deposits.isEmpty) {
      return false;
    }
    final lastDeposit = deposits.last;
    final lastDepositDate = lastDeposit.createdAt;
    final difference = DateTime.now().difference(lastDepositDate);
    return difference.inDays == 0;
  }

  double depositAmount() {
    double currentAmount = 0;
    for (Deposit deposit in deposits) {
      currentAmount += deposit.amount;
    }
    return currentAmount;
  }

  // get remaining amount to complete the challenge
  double remainingAmount() => total - depositAmount();

  double percentCompleted() => depositAmount() / total;

  UnmodifiableListView<Deposit> get depositsView =>
      UnmodifiableListView(deposits.reversed);
}
