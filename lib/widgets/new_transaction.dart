import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx) {
    print('constructor NewTransaction State');
  }

  @override
  _NewTransactionState createState() {
    print('createState NewTransactionWidget ');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  DateTime _slecteDate;
  final amountController = TextEditingController();

  _NewTransactionState() {
    print('Constructor NewTransaction State');
  }
  @override
  void initState() {
    // TODO: implement initState
    print('initState()');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    // TODO: implement didUpdateWidget
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (amountController.text == null) {
      return;
    }
    ;

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _slecteDate == null) {
      return;
    }
    ;

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _slecteDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _slecteDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom * 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: titleController,
                textAlign: TextAlign.start,
                decoration: InputDecoration(labelText: 'title'),
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'amount'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _slecteDate == null
                          ? 'no data choosen'
                          : 'pickeddate: ${DateFormat.yMd().format(_slecteDate)}',
                    ),
                    FlatButton(
                        onPressed: _presentDatePicker,
                        child: Text(
                          'data picker',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.button.color),
                        ))
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submitData,
                color: Theme.of(context).primaryColor,
                child: Text(
                  'add transaction',
                ),
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
