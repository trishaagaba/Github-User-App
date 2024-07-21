import 'package:flutter/material.dart';


 AppBar buildAppbar(BuildContext context) {
   return AppBar(
     leading: const BackButton(),
     backgroundColor: Colors.transparent,
     elevation: 0,
     actions: [
       IconButton(
           onPressed: (){},
             icon: const Icon(Icons.dark_mode_outlined))
     ],
   );
 }

