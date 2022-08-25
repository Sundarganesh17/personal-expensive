import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItems extends StatefulWidget {
  const TransactionItems({
    Key key,
    @required this.transactions,
    @required this.delztx,
  }) : super(key: key);

  final Transaction transactions;
  final Function delztx;

  @override
  State<TransactionItems> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItems> {
  // Color _BackClr;
  // @override
  // void initState() {
  // TODO: implement initState
  //   final availableColors = {
  //    Colors.red,
  //   Colors.black,
  //  Colors.blue,
  // Colors.purple,
  //};
  // _BackClr = availableColors[Random.];
  // super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          // backgroundColor: _BackClr,
          radius: 60,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Text('\$${widget.transactions.amount}'),
          ),
        ),
        title: Text(
          widget.transactions.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMd().format(widget.transactions.date),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
                onPressed: () => widget.delztx(widget.transactions.id),
                icon: Icon(Icons.delete),
                textColor: Theme.of(context).errorColor,
                label: Text('delete'),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => widget.delztx(widget.transactions.id),
              ),
      ),
    );
  }
}
