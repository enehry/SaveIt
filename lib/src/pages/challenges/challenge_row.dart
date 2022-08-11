import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:save_it/src/components/container_percentage.dart';
import 'package:save_it/src/controller/challenges_provider.dart';
import 'package:save_it/src/models/challenge.dart';

class ChallengeRow extends StatefulWidget {
  const ChallengeRow({
    required this.challenge,
    required this.onDelete,
    this.isCompleted = false,
    Key? key,
  }) : super(key: key);

  final Challenge challenge;
  final void Function(Function) onDelete;
  final bool isCompleted;

  @override
  State<ChallengeRow> createState() => _ChallengeRowState();
}

class _ChallengeRowState extends State<ChallengeRow> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    // calculate the deposit amount
    double depositAmount() {
      if (widget.challenge.deposits.isEmpty) {
        return 0.00;
      }
      // calculate the total deposit amount
      double total = 0.00;
      for (final deposit in widget.challenge.deposits) {
        total += deposit.amount;
      }

      return total;
    }

    // calculate the percent of the challenge completed
    double percentCompleted() => depositAmount() / widget.challenge.total;

    final double width = MediaQuery.of(context).size.width - 92;

    double getWidth() => (width * percentCompleted()) > width
        ? width
        : width * percentCompleted();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              padding: EdgeInsets.zero,
              onPressed: (context) {
                widget.onDelete(() {
                  setState(() {
                    _visible = false;
                  });
                });
              },
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).colorScheme.primary,
              icon: Icons.delete,
            ),
          ],
        ),
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: InkWell(
            onTap: () {
              context.read<ChallengesProvider>().setChallenge(widget.challenge);
              GoRouter.of(context).pushNamed('view-challenge');
            },
            child: Row(
              children: [
                Hero(
                  tag: widget.challenge.id,
                  child: Icon(
                    IconData(widget.challenge.iconCode,
                        fontFamily: 'MaterialIcons'),
                    size: 50,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.challenge.title,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 5),
                      ContainerPercentage(
                        width: getWidth(),
                        isCompleted: widget.isCompleted,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            NumberFormat.currency(
                              symbol: '',
                              decimalDigits: 2,
                            ).format(depositAmount()),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            NumberFormat.currency(
                              symbol: '',
                            ).format(
                              widget.challenge.total,
                            ),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
