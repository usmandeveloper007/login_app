import 'package:flutter/material.dart';
class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const RoundButton({super.key, required this.title, required this.onTap, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Center(
          child: loading ? const CircularProgressIndicator(strokeWidth: 4, color: Colors.white,) : Text(title, style: const TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
