import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateTextField extends StatelessWidget {
  const CreateTextField({
    Key? key,
    required this.label,
    this.controller,
    this.hintText,
    this.inputFormatters,
  }) : super(key: key);

  final String label;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.headline5,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.headline4,
            validator: (value) =>
                value == null || value.isEmpty || value == '0.00'
                    ? 'Please enter a value'
                    : null,
            controller: controller,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.caption,
            ),
            inputFormatters: inputFormatters,
          ),
        ],
      ),
    );
  }
}
