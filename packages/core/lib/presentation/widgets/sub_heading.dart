import 'package:core/core.dart';
import 'package:flutter/material.dart';

class SubHeading extends StatelessWidget {
  final String title;
  final bool? isPressed;
  final Function()? onTap;

  const SubHeading({
    required this.title,
    this.isPressed,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        isPressed == true
            ? GestureDetector(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Text('See More'),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
