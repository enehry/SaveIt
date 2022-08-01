import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' show NumberFormat;

class SavingsTextField extends StatelessWidget {
  const SavingsTextField({
    Key? key,
    required this.label,
    this.percentController,
    this.onPercentageChanged,
    this.validator,
    this.value,
    this.color,
  }) : super(key: key);
  final String label;

  final String? value;
  final String? Function(String?)? validator;
  final void Function(String)? onPercentageChanged;
  final TextEditingController? percentController;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    // format value to currency
    final formatter = NumberFormat.currency(
      symbol: '',
      decimalDigits: 2,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: 1.0,
                    ),
                    color: color,
                  ),
                  child: Text(
                    // format value to currency
                    formatter.format(double.parse(value ?? '0')),
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white54,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 5.0),
              SizedBox(
                width: 75.0,
                child: TextFormField(
                  onChanged: onPercentageChanged,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validator,
                  controller: percentController,
                  decoration: InputDecoration(
                    isDense: true,
                    errorStyle: const TextStyle(height: 0),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    hintText: '0%',
                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 28.0,
                        ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  // accept only a numbers
                  keyboardType: TextInputType.number,
                  style: Theme.of(context).textTheme.headline3,
                  inputFormatters: [
                    // allow only numbers from 0 - 100
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^0*(?:[1-9][0-9]?|100)$'),
                    ),
                    FilteringTextInputFormatter.digitsOnly,
                    // format input to currency
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
