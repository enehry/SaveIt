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
}
