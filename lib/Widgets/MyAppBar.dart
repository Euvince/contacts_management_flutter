import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;

  const MyAppBar({super.key, required this.title});
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.title,
        style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.blue,
      actions: [
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Liste de vos notifications", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  backgroundColor: Colors.black,
                )
            );
          },
          tooltip: "Vos notifications",
          icon: Icon(Icons.notification_add, color: Colors.white,),
        ),
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Éffectuer une recherche", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  backgroundColor: Colors.black,
                )
            );
          },
          tooltip: "Une recherche",
          icon: Icon(Icons.search, color: Colors.white,),
        )
      ],
    );
  }
}
