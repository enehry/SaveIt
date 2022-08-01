import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:save_it/src/controller/bottom_nav_provider.dart';
import 'package:save_it/src/controller/challenges_provider.dart';
import 'package:save_it/src/controller/savings_allocation_provider.dart';

// register all providers in the controller here
final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => BottomNavProvider()),
  ChangeNotifierProvider(create: (_) => SavingsAllocationProvider()),
  ChangeNotifierProvider(create: (_) => ChallengesProvider()),
];
