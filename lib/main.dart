import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ByteBankApp();
  }
}

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blue[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'ByteBank',
      home: TransferList(),
    );
  }
}

class TransferForm extends StatefulWidget {
  final TextEditingController _accountNumberController =
      TextEditingController();

  final TextEditingController _valueController = TextEditingController();

  void _createTransfer(BuildContext context) {
    final int accountNumber = int.tryParse(_accountNumberController.text);
    final double value = double.tryParse(_valueController.text);

    if (accountNumber != null && value != null) {
      final transfer = Transfer(value, accountNumber);
      Navigator.pop(context, transfer);
    }
  }

  @override
  _TransferFormState createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando trasferência'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormEditor(
              controller: widget._accountNumberController,
              labelText: 'Número da Conta',
              hint: '0000',
            ),
            FormEditor(
              controller: widget._valueController,
              labelText: 'Valor',
              hint: '0.00',
              icon: Icons.monetization_on,
            ),
            RaisedButton(
              onPressed: () => widget._createTransfer(context),
              child: Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}

class FormEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String labelText;
  final IconData icon;

  FormEditor({this.controller, this.labelText, this.hint, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(signed: true),
        style: TextStyle(
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: labelText,
          hintText: hint,
        ),
      ),
    );
  }
}

class TransferList extends StatefulWidget {
  final List<Transfer> _transfers = List();

  @override
  _TransferListState createState() => _TransferListState();
}

class _TransferListState extends State<TransferList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transfer> response = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => TransferForm(),
            ),
          );

          response.then((transfer) {
            if (transfer != null) {
              setState(() {
                widget._transfers.add(transfer);
              });
            }
          });
        },
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final Transfer transfer = widget._transfers[index];
          return TransferItem(transfer);
        },
        itemCount: widget._transfers.length,
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  final Transfer _transfer;

  TransferItem(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transfer.value.toString()),
        subtitle: Text(_transfer.accountNumber.toString()),
      ),
    );
  }
}

class Transfer {
  final double value;
  final int accountNumber;

  Transfer(this.value, this.accountNumber);

  @override
  String toString() {
    return 'Transfer{value: $value, accountNumber: $accountNumber}';
  }
}
