import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';

class InfoDniWidget extends StatefulWidget {
  @override
  State<InfoDniWidget> createState() => _InfoDniWidgetState();
}

class _InfoDniWidgetState extends State<InfoDniWidget> {
  @override
  Widget build(BuildContext context) {
    final providerFormatedDni = Provider.of<FormatedDniProvider>(context);

    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 200,
        height: 200,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.pink.shade500,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(providerFormatedDni.formatedDni,
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    );
  }
}
