import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.icon,
      required this.selectedIcon,
      required this.isSelected,
      required this.text,
      required this.function});
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final String text;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 73,
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        IconButton(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 0),
          icon: Icon(icon),
          selectedIcon: Icon(selectedIcon),
          isSelected: isSelected,
          onPressed: function,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        )
      ]),
    );
  }
}
