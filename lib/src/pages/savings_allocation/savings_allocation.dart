import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:save_it/src/controller/savings_allocation_provider.dart';
import 'package:save_it/src/pages/savings_allocation/savings_text_field.dart';
import 'package:save_it/src/utils/constant.dart';

class SavingsAllocation extends StatefulWidget {
  const SavingsAllocation({Key? key}) : super(key: key);
  final String title = 'Savings Allocation';

  @override
  State<SavingsAllocation> createState() => _SavingsAllocationState();
}

class _SavingsAllocationState extends State<SavingsAllocation> {
  final _needsController = TextEditingController();
  final _savingsController = TextEditingController();
  final _wantsController = TextEditingController();
  final _othersController = TextEditingController();
  final formatter = NumberFormat.currency(
    symbol: '',
    decimalDigits: 2,
  );

  @override
  void initState() {
    super.initState();

    final provider = context.read<SavingsAllocationProvider>();

    _needsController.text = provider.needsPercentage == 0.0
        ? ''
        : provider.needsPercentage.toStringAsFixed(0);
    _savingsController.text = provider.savingsPercentage == 0.0
        ? ''
        : provider.savingsPercentage.toStringAsFixed(0);

    _wantsController.text = provider.wantsPercentage == 0.0
        ? ''
        : provider.wantsPercentage.toStringAsFixed(0);
    _othersController.text = provider.othersPercentage == 0.0
        ? ''
        : provider.othersPercentage.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double width = mediaQuery.size.width - 32;

    return SingleChildScrollView(
      child: Consumer<SavingsAllocationProvider>(
        builder: (_, provider, __) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Monthly Income:',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      DropdownButton<Map>(
                          value: provider.selectedAllocation,
                          items: kAllocationModes
                              .map(
                                (e) => DropdownMenuItem<Map>(
                                  value: e,
                                  child: Text(e['name']),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            provider.selectedAllocation = value!;
                            _needsController.text = value['needs'];
                            _savingsController.text = value['savings'];
                            _wantsController.text = value['wants'];
                            _othersController.text = value['others'];
                          }),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () => {
                      // show dialog to select currency
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(
                            'Input Monthly Income',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          content: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Please enter your monthly income',
                              hintStyle: Theme.of(context).textTheme.caption,
                            ),
                            onChanged: (value) =>
                                provider.setMonthlyIncome(value),
                            // accept only a numbers
                            keyboardType: TextInputType.number,
                            style: Theme.of(context).textTheme.headline3,
                            // input formatter accept only numbers regex
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyTextInputFormatter(
                                  symbol: '', decimalDigits: 0),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      width: double.infinity,
                      height: 100.0,
                      color: Colors.black54,
                      child: Center(
                        child: provider.monthlyIncome != 0.0
                            ? Text(
                                formatter.format(provider.monthlyIncome),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                              )
                            : Text(
                                'Enter a monthly income',
                                style: Theme.of(context).textTheme.caption,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    'Percentage Distribution',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 10.0),
                  Row(children: [
                    Container(
                      width: width * (provider.needsPercentage / 100),
                      height: 60.0,
                      color: Colors.black87,
                    ),
                    Container(
                      width: width * (provider.savingsPercentage / 100),
                      height: 60.0,
                      color: Colors.black54,
                    ),
                    Container(
                      width: width * (provider.wantsPercentage / 100),
                      height: 60.0,
                      color: Colors.black45,
                    ),
                    Container(
                      width: width * (provider.othersPercentage / 100),
                      height: 60.0,
                      color: Colors.black38,
                    ),
                  ]),
                  const SizedBox(height: 30.0),
                  Text(
                    'You can edit the percentages below',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(height: 10.0),
                  SavingsTextField(
                    label: 'Needs:',
                    color: Colors.black87,
                    value: provider.needs.toString(),
                    percentController: _needsController,
                    onPercentageChanged: ((p0) =>
                        provider.setNeedsPercentage(p0)),
                    validator: (value) =>
                        provider.needsPercentageValidator(value),
                  ),
                  SavingsTextField(
                    label: 'Savings:',
                    percentController: _savingsController,
                    color: Colors.black54,
                    value: provider.savings.toString(),
                    onPercentageChanged: ((p0) =>
                        provider.setSavingsPercentage(p0)),
                    validator: (value) =>
                        provider.savingsPercentageValidator(value),
                  ),
                  SavingsTextField(
                    label: 'Wants:',
                    percentController: _wantsController,
                    color: Colors.black45,
                    value: provider.wants.toString(),
                    onPercentageChanged: ((p0) =>
                        provider.setWantsPercentage(p0)),
                    validator: (value) =>
                        provider.wantsPercentageValidator(value),
                  ),
                  SavingsTextField(
                    label: 'Others:',
                    percentController: _othersController,
                    color: Colors.black38,
                    value: provider.others.toString(),
                    onPercentageChanged: ((p0) =>
                        provider.setOthersPercentage(p0)),
                    validator: (value) =>
                        provider.othersPercentageValidator(value),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
