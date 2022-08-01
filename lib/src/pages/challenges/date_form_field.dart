import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormField extends StatelessWidget {
  const DateFormField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.hintText,
      this.validator})
      : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          label,
          style: Theme.of(context).textTheme.headline5,
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: Theme.of(context).textTheme.headline4,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            showDatePicker(
              context: context,
              initialDate: controller.text.isNotEmpty
                  ? DateFormat.yMd().parse(controller.text)
                  : DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2050),
            ).then((value) {
              if (value != null) {
                controller.text = DateFormat.yMd().format(value);
              }
            });
          },
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.caption,
            suffixIcon: const Icon(
              Icons.calendar_today_outlined,
            ),
          ),
        ),
      ]),
    );
  }
}
