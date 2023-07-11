import 'package:flutter/material.dart';

class MenuOption extends StatelessWidget {
  const MenuOption({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: [
        _menuItem(context, 'Nuevo Cliente', Icons.person_add_alt_1, Colors.grey,
            '/opcion1',
            size: 75,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
      ],
    );
  }
}

Widget _menuItem(BuildContext context, String title, IconData icon, Color color,
    String route,
    {double size = 70, EdgeInsets padding = EdgeInsets.zero}) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed('new_client');
    },
    child: Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          )
        ],
      ),
    ),
  );
}
