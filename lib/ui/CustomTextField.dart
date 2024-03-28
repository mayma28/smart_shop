import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Widget child;
  const CustomTextField({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.06,
      width: size.width / 3,
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
      decoration: BoxDecoration(
        border: Border.all(),
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
