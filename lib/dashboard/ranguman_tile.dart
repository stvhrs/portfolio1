import 'package:flutter/material.dart';

class Rangkuman extends StatelessWidget {
  final MaterialColor colors;
  final String data;
  final String keterangan;
  final IconData icon;
  const Rangkuman(this.colors, this.data, this.keterangan, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.18,
        height: MediaQuery.of(context).size.height * 0.11,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.15 * 0.02,
                height: MediaQuery.of(context).size.height * 0.11,
                decoration: BoxDecoration(
                  color: colors,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(2),
                      bottomLeft: Radius.circular(2)),
                )),
            
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    keterangan,
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        color: colors,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    data,
                    style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.grey.shade400,
                size: 25,
              ),
            )
          ],
        ));
  }
}
