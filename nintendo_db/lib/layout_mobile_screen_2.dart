// Aquest widget de layout, necessita saber a quina ‘seccio’ i quin item (index) ha de mostrar
import 'package:flutter/material.dart';
import 'package:nintendo_db/layout_consola.dart';
import 'package:nintendo_db/layout_desktop.dart';
import 'package:nintendo_db/layout_jocs.dart';
import 'package:nintendo_db/layout_personatge.dart';
import 'package:provider/provider.dart';
import 'app_data.dart';

class LayoutMobileScreen2 extends StatefulWidget {
  final String seccio;
  final int index;

  const LayoutMobileScreen2(
      {Key? key, required this.seccio, required this.index})
      : super(key: key);
  @override
  State<LayoutMobileScreen2> createState() => _StateLayoutMobileScreen2();
}

// ... A la següent diapositiva hi ha la definició de l’estat ...
// ... Segueix amb la definició de l’estat ...
// Aquest cop necessitem saber les dades per mostrar el nom al títol,
// per això es demana l’AppData al ‘build‘
// enlloc de al ‘_setBody’
class _StateLayoutMobileScreen2 extends State<LayoutMobileScreen2> {
  _StateLayoutMobileScreen2();
// Aquí falta la funció ‘_setBody’ definida a la següent diapositiva
  Widget _setBody(BuildContext context, dynamic itemData) {
    switch (widget.seccio) {
      case 'Personatges':
        return LayoutPersonatge(itemData: itemData);
      case 'Consoles':
        return Layoutconsola(itemData: itemData);
      case 'Jocs':
        return LayoutJocs(itemData: itemData);
    }
    return Text('Unknown layout: ${widget.seccio}');
  }

  @override
  Widget build(BuildContext context) {
// Referència a l’objecte que gestiona les dades de l’aplicació
    AppData appData = Provider.of<AppData>(context);
    dynamic itemData = appData.getItemData(widget.seccio, widget.index);
// Si no tenim les dades, carregar-les i mostrar un 'loading'
    if (!appData.dataReady(widget.seccio)) {
      appData.load(widget.seccio);
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(itemData['nom']),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: _setBody(context, itemData));
    }
  }
}
