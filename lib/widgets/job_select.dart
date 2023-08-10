import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';

class JobTipoWidget extends StatefulWidget {
  final Function(String) onJobSelected;

  const JobTipoWidget({super.key, required this.onJobSelected});

  @override
  State<JobTipoWidget> createState() => _JobTipoWidgetState();
}

class _JobTipoWidgetState extends State<JobTipoWidget> {
  //Esta variable almacena la opción seleccionada.
  String _selectedOption = 'AUH';
  //Lista de opciones del menú desplegable:
  List<String> _options = [
    'AUH',
    'EMPLEADO',
    'MONOTRIBUTISTA',
    'RESPONSABLE INSCRIPTO',
  ];
  @override
  Widget build(BuildContext context) {
    final providerSelectJobs = Provider.of<UserInfoProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Tipo de recibo del cliente:',
          border: OutlineInputBorder(),
          filled: true,
        ),
        value: _selectedOption,
        items: _options.map((String option) {
          return DropdownMenuItem(value: option, child: Text(option));
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedOption = newValue!;
            widget.onJobSelected(newValue);
            providerSelectJobs.userInfo.trabajo = _selectedOption;
          });
        },
      ),
    );
  }
}
