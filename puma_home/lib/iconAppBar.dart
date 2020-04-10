import 'package:flutter/material.dart';

class IconAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new ImageIcon(
      new AssetImage('images/iconos/appbarIcon.png'),
      color: Colors.yellowAccent,
    );
  }
}