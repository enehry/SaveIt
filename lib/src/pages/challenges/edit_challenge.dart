import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:save_it/src/controller/challenges_provider.dart';
import 'package:save_it/src/models/challenge.dart';
import 'package:save_it/src/pages/challenges/create_text_field.dart';
import 'package:save_it/src/pages/challenges/date_form_field.dart';
import 'package:save_it/src/pages/layout/local_app_bar.dart';
import 'package:save_it/src/utils/helper.dart';

class EditChallenge extends StatefulWidget {
  const EditChallenge({Key? key}) : super(key: key);

  @override
  State<EditChallenge> createState() => _EditChallengeState();
}

class _EditChallengeState extends State<EditChallenge> {
  final _formKey = GlobalKey<FormState>();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _titleController = TextEditingController();
  final _totalAmountController = TextEditingController();
  String _frequency = 'Daily';
  String _amountPerFrequency = "0.00";

  void onSave() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        // get the text from the controllers
        final startDate = _startDateController.text;
        final endDate = _endDateController.text;
        final title = _titleController.text;
        final totalAmount = _totalAmountController.text;
        final frequency = _frequency;

        //send to provider
        final provider =
            Provider.of<ChallengesProvider>(context, listen: false);

        challenge.title = title;
        challenge.iconCode = Icons.savings_outlined.codePoint;
        challenge.total = double.parse(totalAmount.replaceAll(',', ''));
        challenge.dateUpdated = DateTime.now();
        challenge.startDate = DateFormat.yMd().parse(startDate);
        challenge.endDate = DateFormat.yMd().parse(endDate);
        challenge.frequency = frequency;

        provider.updateChallenge(challenge);

        // go back to challenges page
        GoRouter.of(context).pop();
      }
    }
  }

  @override
  void dispose() {
    // dispose controllers
    _startDateController.dispose();
    _endDateController.dispose();
    _titleController.dispose();
    _totalAmountController.dispose();
    super.dispose();
  }

  late Challenge challenge;
  @override
  void initState() {
    // listen to changes in the controllers
    // initialize data from challenge provider
    final provider = Provider.of<ChallengesProvider>(context, listen: false);
    challenge = provider.challenge!;

    // get the challenge to edit

    _titleController.text = challenge.title;
    _totalAmountController.text = hCurrency(challenge.total);
    _startDateController.text = DateFormat.yMd().format(challenge.startDate);
    _endDateController.text = DateFormat.yMd().format(challenge.endDate);
    _frequency = challenge.frequency;
    amountPerFrequency();

    _startDateController.addListener(() {
      amountPerFrequency();
    });
    _endDateController.addListener(() {
      amountPerFrequency();
    });
    _titleController.addListener(() {
      amountPerFrequency();
    });
    _totalAmountController.addListener(() {
      amountPerFrequency();
    });

    super.initState();
  }

  void amountPerFrequency() {
    int perFrequency = Provider.of<ChallengesProvider>(context, listen: false)
        .calculateAmountPerFrequency(
      _frequency,
      _startDateController.text,
      _endDateController.text,
      _totalAmountController.text,
    );
    if (perFrequency.isInfinite || perFrequency.isNaN) {
      _amountPerFrequency = "0.00";
    } else {
      _amountPerFrequency = NumberFormat.currency(
        symbol: '',
        decimalDigits: 2,
      ).format(perFrequency);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LocalAppBar(
      title: 'Edit Challenge',
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (() => onSave()),
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(
            Icons.save_outlined,
            color: Colors.white60,
            size: 35.0,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CreateTextField(
                  controller: _titleController,
                  label: 'Title',
                  hintText: 'Enter title ex. "For vacation in Paris"',
                ),
                CreateTextField(
                  controller: _totalAmountController,
                  label: 'Total Amount',
                  hintText: 'Enter total amount ex. "16,400"',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyTextInputFormatter(
                      symbol: '',
                      decimalDigits: 2,
                    ),
                  ],
                ),
                // date form field picker
                DateFormField(
                  controller: _startDateController,
                  label: 'Start Date',
                  hintText: 'Select start date',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a date';
                    }
                    return null;
                  },
                ),
                DateFormField(
                  controller: _endDateController,
                  label: 'Date to Finish',
                  hintText: 'Select date when to finish challenge',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a date';
                    }
                    // if start date is after end date
                    if (DateFormat.yMd()
                        .parse(_startDateController.text)
                        .isAfter(DateFormat.yMd().parse(value))) {
                      return 'Date to finish must be after start date';
                    }
                    if (DateFormat.yMd()
                        .parse(_startDateController.text)
                        .isAtSameMomentAs(DateFormat.yMd().parse(value))) {
                      return 'Date to finish must be after start date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Savings Interval',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 20.0),
                Text('Frequency', style: Theme.of(context).textTheme.headline5),
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  style: Theme.of(context).textTheme.headline4,
                  value: _frequency,
                  items: const [
                    DropdownMenuItem(
                      value: 'Daily',
                      child: Text('Daily'),
                    ),
                    DropdownMenuItem(
                      value: 'Weekly',
                      child: Text('Weekly'),
                    ),
                    DropdownMenuItem(
                      value: 'Monthly',
                      child: Text('Monthly'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        _frequency = value;
                      }
                    });
                    amountPerFrequency();
                  },
                ),
                const SizedBox(height: 20.0),
                Text(
                  _amountPerFrequency,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
