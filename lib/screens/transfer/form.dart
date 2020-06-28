import 'package:byte_bank/components/form_editor.dart';
import 'package:byte_bank/models/transfer.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'Criando Transferência';

const _valueTitle = 'Valor';
const _valueHint = '0.00';

const _accountNumberTitle = 'Número da Conta';
const _accountNumberHint = '0000';

const _buttonTitle = 'Confirmar';

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
        title: Text(_appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormEditor(
              controller: widget._accountNumberController,
              labelText: _accountNumberTitle,
              hint: _accountNumberHint,
            ),
            FormEditor(
              controller: widget._valueController,
              labelText: _valueTitle,
              hint: _valueHint,
              icon: Icons.monetization_on,
            ),
            RaisedButton(
              onPressed: () => widget._createTransfer(context),
              child: Text(_buttonTitle),
            ),
          ],
        ),
      ),
    );
  }
}
