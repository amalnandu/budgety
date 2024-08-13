import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const primaryColor = Color(0xFF151026);
const iconcolor=Color(0x007895cb);
const bgcolor1=Color(0xFF21214a);
const bgcolor=Color(0xFF151E3D);
const kellygreen =Color(0xFF4CBB17);
const puregreen =Color(0xFF008000);
const purered=Color(0xFFD2122E);
 const gradientStart = Color(0xFF7B1FA2); //Change start gradient color here
const gradientEnd = Color(0xFF9C27B0);


class Buttonwidget extends StatefulWidget {
   String text;
   VoidCallback onPressed;
   Color bgc;
   Buttonwidget({super.key,required this.text, required this.onPressed,required this.bgc});

  @override
  State<Buttonwidget> createState() => _ButtonwidgetState();
}

class _ButtonwidgetState extends State<Buttonwidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
fixedSize: const Size(160, 60),
        minimumSize: const Size(120, 40),
        backgroundColor: widget.bgc,
        shadowColor: Colors.black,
        elevation: 80,
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5,right: 5),
        child: Text(
          widget.text,
          style: GoogleFonts.mukta(fontSize: 16),
        ),
      ),
    );
  }
}

////////// floating elements
class FloatingElement extends StatefulWidget {
  final Color color;
  final double size;

  const FloatingElement({super.key, required this.color, required this.size});

  @override
  _FloatingElementState createState() => _FloatingElementState();
}

class _FloatingElementState extends State<FloatingElement>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust the duration as per your preference
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: Offset(Random().nextDouble() - 0.5, Random().nextDouble() - 0.5),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
        ),
      ),
    );
  }
}

////////////

