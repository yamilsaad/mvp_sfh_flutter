import 'package:flutter/material.dart';

import '../components/component.dart';
import '../widgets/widget.dart';

//*Aquí está diseñado el formulario de carga de Clientes!
class NewClientLayout extends StatelessWidget {
  const NewClientLayout({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _celularController = TextEditingController();
    TextEditingController _reciboFormController = TextEditingController();
    String selectedTrabajo = '';
    return Column(
      children: [
        TextSubtitleWidget(
          titleText: '# Ingrese Información del Nuevo Cliente',
        ),
        Divider(height: 5),
        //Input de Numero telefonico.
        CelInputWidget(celularController: _celularController),
        Divider(height: 5),
        //Select de tipo de recibo en relacion al trabajo.
        JobTipoWidget(
          onJobSelected: (String) {
            //TODO: Agregar método de guardado!
            selectedTrabajo = selectedTrabajo.toString();
          },
        ),
        Divider(height: 5),
        //Formulario de ingreso de recibo
        ReciboFormWidget(
          reciboFormController: _reciboFormController,
        ),
        Divider(height: 5),
        //Selección de fecha
        DataSelectWidget(),
        Divider(height: 5),
        //Información Scanneada:
        ScannerWidget(),
        Divider(height: 5),
        //Botón de Scanner en barra inferior:
        ButtonScannerComponent(),
      ],
    );
  }
}
