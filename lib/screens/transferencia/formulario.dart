import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Criando Transferência';

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controllerCampoNrConta = TextEditingController();
  final TextEditingController _controllerCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controller: _controllerCampoNrConta,
              label: 'Número da conta',
              hint: '0000',
            ),
            Editor(
              controller: _controllerCampoValor,
              label: 'Valor da transferencia',
              hint: '0.00',
              icon: Icons.monetization_on,
            ),
            ElevatedButton(
              onPressed: () => _criaTransferencia(context),
              child: Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int nrConta = int.tryParse(_controllerCampoNrConta.text);
    final double valor = double.tryParse(_controllerCampoValor.text);
    Transferencia transferencia;
    if (nrConta != null && valor != null) {
      transferencia = Transferencia(valor, nrConta);
      Navigator.pop(context, transferencia);
    }
  }
}
