import 'package:flutter/material.dart';

void main() => runApp(BiteBankApp());

class BiteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controllerCampoNrConta = TextEditingController();
  final TextEditingController _controllerCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: Column(
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
          )
        ],
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int nrConta = int.tryParse(_controllerCampoNrConta.text);
    final double valor = double.tryParse(_controllerCampoValor.text);
    Transferencia transferencia;
    if (nrConta != null && valor != null) {
      transferencia = Transferencia(valor, nrConta);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(transferencia.toString()),
      ),
    );
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;

  Editor({this.controller, this.label, this.hint, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: hint,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: Column(
        children: [
          ItemTransferencia(Transferencia(100.00, 1000)),
          ItemTransferencia(Transferencia(200.00, 1000)),
          ItemTransferencia(Transferencia(300.00, 1000)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferência de: ' +
        valor.toString() +
        ' Para a Conta: ' +
        numeroConta.toString();
  }
}
