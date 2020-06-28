import 'package:byte_bank/models/transfer.dart';
import 'package:byte_bank/screens/transfer/form.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'Transferências';

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
        title: Text(_appBarTitle),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => TransferForm(),
            ),
          ).then(
            (transfer) => _update(transfer),
          );
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

  void _update(Transfer transfer) {
    if (transfer != null) {
      setState(() {
        widget._transfers.add(transfer);
      });
    }
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
