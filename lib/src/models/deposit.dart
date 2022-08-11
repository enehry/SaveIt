// import 'package:save_it/src/utils/enums.dart';

// class Deposit {
//   Deposit({
//     required this.id,
//     required this.amount,
//     required this.createdAt,
//     required this.type,
//   });

//   final String id;
//   final double amount;
//   final DateTime createdAt;
//   final DepositType type;
// }

import 'package:hive/hive.dart';

part 'deposit.g.dart';

@HiveType(typeId: 2, adapterName: 'DepositAdapter')
class Deposit extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime createdAt;

  Deposit({
    required this.id,
    required this.amount,
    required this.createdAt,
  });

  @override
  toString() => 'Deposit(id: $id, amount: $amount, createdAt: $createdAt)';

  //  to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // from Map
  factory Deposit.fromMap(Map<String, dynamic> map) {
    return Deposit(
      id: map['id'],
      amount: map['amount'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
