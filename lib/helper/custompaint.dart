
import 'package:flutter/material.dart';

class CustomPaints extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset('images/title.png',width: 300,)));
  }
}
//Copy this CustomPainter code to the Bottom of the File

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
            
Paint paint0Fill = Paint()..style=PaintingStyle.fill;
paint0Fill.color = const Color(0xffffffff).withOpacity(1);
canvas.drawRect(Rect.fromLTWH(size.width*-0.1000000,size.height*-0.1000000,size.width*1.200000,size.height*1.200000),paint0Fill);

Paint paint1Fill = Paint()..style=PaintingStyle.fill;
paint1Fill.color = const Color(0xffffffff).withOpacity(1);
canvas.drawRect(Rect.fromLTWH(size.width*-0.1000000,size.height*-0.1000000,size.width*1.200000,size.height*1.200000),paint1Fill);

Paint paint2Fill = Paint()..style=PaintingStyle.fill;
paint2Fill.color = const Color(0xffffffff).withOpacity(1);
canvas.drawRect(Rect.fromLTWH(size.width*-0.1000000,size.height*-0.1000000,size.width*1.200000,size.height*1.200000),paint2Fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
}
}