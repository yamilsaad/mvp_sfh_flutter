import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class InfoDniWidget extends StatefulWidget {
  final String data;

  InfoDniWidget({Key? key, required this.data}) : super(key: key);

  @override
  State<InfoDniWidget> createState() => _InfoDniWidgetState();
}

class _InfoDniWidgetState extends State<InfoDniWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          height: 250,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.pink.shade500,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(widget.data,
                style: TextStyle(color: Colors.white, fontSize: 25)),
          ),
        ),
      ),
    );
  }
}
