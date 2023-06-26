import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const IconTextButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(8.0),
            // shape: const CircleBorder(),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24))
            ),
            backgroundColor: const Color(0xFF1e8bfa)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(icon, size: 44.0, color: Colors.white,),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          text,
          style: const TextStyle(fontSize: 14.0),
        ),
      ],
    );
  }
}
