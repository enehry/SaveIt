import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:save_it/src/components/container_percentage.dart';
import 'package:save_it/src/controller/challenges_provider.dart';
import 'package:save_it/src/pages/layout/local_app_bar.dart';

class ViewChallenge extends StatelessWidget {
  const ViewChallenge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double inputAmount = 0;
    return Builder(builder: (context) {
      final challenge = Provider.of<ChallengesProvider>(context).challenge!;

      final double width = MediaQuery.of(context).size.width - 112;

      String toCurrency(double amount) =>
          NumberFormat.currency(decimalDigits: 2, symbol: '').format(amount);
      // sum the deposits for the challenge
      double depositAmount() {
        if (challenge.deposits.isEmpty) {
          return 0.00;
        }
        // calculate the total deposit amount
        double total = 0.00;
        for (final deposit in challenge.deposits) {
          total += deposit.amount;
        }
        return total;
      }

      // calculate the day till finish
      int daysTillFinish =
          challenge.endDate.difference(DateTime.now()).inDays + 1;

      // calculate the percent of the challenge completed
      double containerWidth = (width * challenge.percentCompleted()) > width
          ? width
          : width * challenge.percentCompleted();

      return LocalAppBar(
        title: challenge.title,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => GoRouter.of(context).pushNamed('edit-challenge'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(
              Icons.edit_outlined,
              color: Colors.white60,
              size: 35.0,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Hero(
                      tag: challenge.id,
                      child: Icon(
                        IconData(challenge.iconCode,
                            fontFamily: 'MaterialIcons'),
                        size: 70.0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        children: [
                          ContainerPercentage(
                            width: containerWidth,
                            isCompleted: challenge.isCompleted(),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(toCurrency(depositAmount())),
                              Text(toCurrency(challenge.total)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: challenge.isCompletedDaily() ||
                              challenge.isCompleted()
                          ? null
                          : () => {
                                //show dialog
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Row(children: const [
                                      Icon(
                                        Icons.info_outline,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(width: 10.0),
                                      Text('Confirmation')
                                    ]),
                                    content: Text(
                                        'Are you sure you want to complete ${challenge.frequency}?'),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          'No',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      TextButton(
                                        child: Text(
                                          'Yes',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        onPressed: () {
                                          // add the deposit
                                          Provider.of<ChallengesProvider>(
                                                  context,
                                                  listen: false)
                                              .depositToChallenge(
                                            Provider.of<ChallengesProvider>(
                                                    context,
                                                    listen: false)
                                                .calculateUpdateAmountPerFrequency()
                                                .toDouble(),
                                          );

                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.primary,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 0.0,
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(130, 45),
                      ),
                      child: Text(
                        'Complete ${challenge.frequency}',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: challenge.isCompleted()
                          ? null
                          : () {
                              // show dialog with input amount
                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return AlertDialog(
                                      title: Row(
                                        children: [
                                          const Icon(
                                            Icons.info_outline,
                                            color: Colors.amber,
                                          ),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'Advance amount input',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
                                          ),
                                        ],
                                      ),
                                      content: TextFormField(
                                        keyboardType: TextInputType.number,
                                        onChanged: ((value) => inputAmount =
                                            double.parse(value.replaceAll(
                                                RegExp(r','), ''))),
                                        autofocus: true,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter an amount';
                                          }
                                          if (double.parse(value.replaceAll(
                                                  RegExp(r','), '')) >
                                              challenge.remainingAmount()) {
                                            return 'Cannot be greater than remaining amount';
                                          }

                                          return null;
                                        },
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          CurrencyTextInputFormatter(
                                            decimalDigits: 2,
                                            symbol: '',
                                          )
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            child: Text(
                                              'Cancel',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                        TextButton(
                                            child: Text(
                                              'Ok',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            onPressed: () {
                                              if (inputAmount <=
                                                  challenge.remainingAmount()) {
                                                context
                                                    .read<ChallengesProvider>()
                                                    .depositToChallenge(
                                                        inputAmount);
                                                Navigator.pop(context);
                                              }
                                            }),
                                      ],
                                    );
                                  });
                            },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.primary,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 0.0,
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(130, 45),
                      ),
                      child: Text(
                        'Advance',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                Text(
                  'Challenge Information',
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Days till Finish',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  '$daysTillFinish',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Total Amount',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  toCurrency(challenge.total),
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Date To Started',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  DateFormat.yMd().format(challenge.startDate),
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Date To Finish',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  DateFormat.yMd().format(challenge.endDate),
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Savings Interval',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  challenge.frequency,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Amount Per Interval',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  toCurrency(
                    // amount per interval
                    Provider.of<ChallengesProvider>(context, listen: false)
                        .calculateUpdateAmountPerFrequency()
                        .toDouble(),
                  ),
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 40.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () => GoRouter.of(context).pushNamed(
                      'challenge-history',
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.primary,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      minimumSize: const Size(130, 45),
                    ),
                    child: Text(
                      'History',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
