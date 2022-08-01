import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:save_it/src/components/empty.dart';
import 'package:save_it/src/controller/challenges_provider.dart';
import 'package:save_it/src/pages/layout/local_app_bar.dart';
import 'package:save_it/src/utils/helper.dart';

class ChallengeHistory extends StatelessWidget {
  const ChallengeHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocalAppBar(
      title: 'History',
      child: Consumer<ChallengesProvider>(
        builder: (context, provider, _) => provider.challenge == null ||
                provider.challenge!.deposits.isEmpty
            ? const Empty(
                label:
                    'History is empty \n clicking the complete or advance button will add new  data in the history.')
            : ListView.builder(
                itemCount: provider.challenge?.depositsView.length ?? 0,
                itemBuilder: (context, index) => ListTile(
                  dense: true,
                  title: Text(
                    hCurrency(provider.challenge!.depositsView[index].amount),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  subtitle: const Text('Amount'),
                  trailing: Text(
                    DateFormat.yMd().format(
                        provider.challenge!.depositsView[index].createdAt),
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
      ),
    );
  }
}
