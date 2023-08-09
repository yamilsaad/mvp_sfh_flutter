import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';

class DataSelectWidget extends StatefulWidget {
  final void Function(String)
      onDateSelected; // La función de devolución de llamada

  DataSelectWidget(
      {required this.onDateSelected}); // Constructor con la función de devolución de llamada

  @override
  State<DataSelectWidget> createState() => _DataSelectWidgetState();
}

class _DataSelectWidgetState extends State<DataSelectWidget> {
  String? dataRecibo;

  final FlutterLocalization _localization = FlutterLocalization.instance;

  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              DateTime? dateTime = await showOmniDateTimePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
                lastDate: DateTime.now().add(const Duration(days: 3652)),
                is24HourMode: false,
                isShowSeconds: false,
                minutesInterval: 1,
                secondsInterval: 1,
                isForce2Digits: true,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                constraints: const BoxConstraints(
                  maxWidth: 350,
                  maxHeight: 650,
                ),
                transitionBuilder: (context, anim1, anim2, child) {
                  return FadeTransition(
                    opacity: anim1.drive(
                      Tween(
                        begin: 0,
                        end: 1,
                      ),
                    ),
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 200),
                barrierDismissible: true,
                selectableDayPredicate: (dateTime) {
                  // Disable 25th Feb 2023
                  if (dateTime == DateTime(2023, 2, 25)) {
                    return false;
                  } else {
                    return true;
                  }
                },
              );

              if (dateTime != null) {
                setState(() {
                  _selectedDateTime = dateTime;
                  dataRecibo = _selectedDateTime!.toIso8601String();
                });

                // Llama a la función de devolución de llamada y pasa el valor seleccionado
                widget.onDateSelected(dataRecibo!);

                // Guarda la fecha seleccionada en el campo "fecha" del modelo UserInfo
                final userInfoProvider =
                    Provider.of<UserInfoProvider>(context, listen: false);
                userInfoProvider.userInfo.fechaRrecibo = dataRecibo!;
              }

              print("dateTime: $dateTime");
            },
            child: const Text(
              "Seleccione fecha de inicio de actividad",
              style: TextStyle(fontSize: 18),
            ),
          ),
          if (_selectedDateTime != null)
            Text(
              'Fecha seleccionada: ${_selectedDateTime.toString()}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
        ],
      ),
    );
  }
}
