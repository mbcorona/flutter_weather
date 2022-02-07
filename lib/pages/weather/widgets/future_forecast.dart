import 'package:flutter/material.dart';

class FutureForecast extends StatelessWidget {
  const FutureForecast({
    Key? key,
    required this.text,
    required this.iconUrl,
    this.selected = false,
    this.onTap,
  }) : super(key: key);

  final String text;
  final String iconUrl;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Material(
        color: selected ? Colors.white.withOpacity(.9) : Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Column(
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: selected ? Colors.black87 : Colors.white,
                  ),
                ),
                Image.network(
                  iconUrl,
                  width: 25,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
