import 'package:flutter/material.dart';

class CategorieTitle extends StatelessWidget {
  final String title;
  const CategorieTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        
      ],
    );
  }
}
