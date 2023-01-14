import 'package:flutter/material.dart';

class ReuseRowCard extends StatelessWidget {
  final String title, value;
  const ReuseRowCard({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Padding(
        padding: EdgeInsets.only(top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 25, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
