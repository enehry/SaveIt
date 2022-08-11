import 'package:flutter/material.dart';

class ContainerPercentage extends StatefulWidget {
  const ContainerPercentage({
    Key? key,
    this.width = 0,
    this.isCompleted = false,
  }) : super(key: key);
  final double width;
  final bool isCompleted;

  @override
  State<ContainerPercentage> createState() => _ContainerPercentageState();
}

class _ContainerPercentageState extends State<ContainerPercentage> {
  bool _visited = false;

  @override
  void initState() {
    super.initState();
    // check if mounted in order to avoid calling setState() on a disposed widget

    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) {
        setState(() {
          _visited = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // dispose the animation container
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // center text
        Stack(
          children: [
            Container(
              height: 20.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: _visited ? widget.width : 0.0,
              height: 20.0,
              curve: Curves.easeIn,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        // center text
        Align(
            alignment: Alignment.center,
            child: widget.isCompleted
                ? const Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: Text(
                      'COMPLETED',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                  )
                : const SizedBox.shrink()),
      ],
    );
  }
}
