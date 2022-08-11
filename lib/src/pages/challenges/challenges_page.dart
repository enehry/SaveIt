import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:save_it/src/components/empty.dart';
import 'package:save_it/src/controller/auth_provider.dart';
import 'package:save_it/src/controller/challenges_provider.dart';
import 'package:save_it/src/models/challenge.dart';
import 'package:save_it/src/pages/challenges/challenge_row.dart';
import 'package:save_it/src/utils/helper.dart';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({Key? key}) : super(key: key);
  final title = 'Challenges';
  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  String filter = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<User?>(
            stream: context.read<AuthProvider>().userStream,
            builder: (_, snapshot) => snapshot.hasData
                ? Container(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Text(
                      'Hello! ${snapshot.data!.displayName}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable:
                  Provider.of<ChallengesProvider>(context).getChallenges(),
              builder: (context, Box<Challenge> box, __) {
                if (box.isEmpty) {
                  return const Empty(
                    label:
                        'Challenge is empty,\n you can  add by click the + button',
                  );
                }

                // sum all deposit of all challenges
                double sum = 0;
                for (var challenge in box.values) {
                  sum += challenge.deposits
                      .fold(0, (sum, deposit) => sum + deposit.amount);
                }

                final List<Challenge> challenges = box.values
                    .toList()
                    .where(
                      (challenge) => challenge.title.toLowerCase().contains(
                            filter.toLowerCase(),
                          ),
                    )
                    .toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 100.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    child: Text(
                                      hCurrency(sum),
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  'Deposits',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 100.0,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    child: Text(
                                      box.values.length.toString(),
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    'Challenges',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // search bar
                    TextField(
                      onChanged: (value) => setState(() => filter = value),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.search,
                          size: 30.0,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        isDense: true,
                        hintText: 'Search a challenge...',
                        hintStyle: Theme.of(context).textTheme.caption,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text('List of challenges',
                        style: Theme.of(context).textTheme.caption),
                    Expanded(
                      child: challenges.isEmpty
                          ? const Empty(
                              label: 'Empty result',
                            )
                          : ListView.builder(
                              itemCount: challenges.length,
                              itemBuilder: (context, index) {
                                return ChallengeRow(
                                    key: Key(challenges[index].id),
                                    challenge: challenges[index],
                                    isCompleted:
                                        challenges[index].isCompleted(),
                                    onDelete: (deleted) {
                                      // show warning dialog
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Row(
                                            children: const [
                                              Icon(
                                                Icons.info_outline,
                                                color: Colors.red,
                                              ),
                                              SizedBox(width: 10),
                                              Text('Delete Challenge'),
                                            ],
                                          ),
                                          content: const Text(
                                              'Are you sure you want to delete this challenge?'),
                                          actions: [
                                            TextButton(
                                              child: const Text('Cancel'),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                            ),
                                            TextButton(
                                              child: const Text('Delete'),
                                              onPressed: () {
                                                deleted();
                                                context
                                                    .read<ChallengesProvider>()
                                                    .deleteChallenge(
                                                        challenges[index]);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GoRouter.of(context).pushNamed('create-challenge'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white70,
          size: 35.0,
        ),
      ),
    );
  }
}
