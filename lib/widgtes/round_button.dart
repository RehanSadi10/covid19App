import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const RoundButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.green),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white70, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
