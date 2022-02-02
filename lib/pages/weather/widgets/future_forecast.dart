import 'package:flutter/material.dart';

class FutureForecast extends StatelessWidget {
  const FutureForecast({
    Key? key,
    required this.text,
    required this.iconUrl,
  }) : super(key: key);

  final String text;
  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.grey),
          ),
          Image.network(iconUrl, width: 25,)
        ],
      ),
    );
  }
}
