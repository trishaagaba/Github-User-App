import 'package:flutter/material.dart';

Widget CoverImageWidget() => Container(
  color: Colors.grey,
  width: double.infinity,
  height: 200,
  child: Image.network('https://th.bing.com/th/id/OIP.g3260YQlm7MOx4NFM3eRSgHaEK?rs=1&pid=ImgDetMain', fit: BoxFit.cover,),
  //child: Image.asset('assets/geolocator.jpg'),
  // fit: BoxFit.cover
);