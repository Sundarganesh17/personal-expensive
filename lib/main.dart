import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import '../models/transaction.dart';

void main() {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations(
  //   DeviceOrientation.portraitDown, DeviceOrientation.portraitUp);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        errorColor: Colors.red,
        accentColor: Colors.amber,
        fontFamily: 'Quciksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.purple),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: 'Personal Expensives',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  final List<Transaction> _userTransactions = [
    // Transaction(
    //id: 't1',
    //title: 'shoes',
    // date: DateTime.now(),
    // amount: 60.99),
    // Transaction(
    //     id: 't2',
    //      title: 'coolers',
    //      date: DateTime.now(),
    //       amount: 50.79),
  ];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTarnsaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chosenDate);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTarnsaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  bool _showshart = false;

  List<Widget> _BuildLandscape(AppBar appBar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('showchat'),
          Switch(
            value: _showshart,
            onChanged: (val) {
              setState(() {
                _showshart = val;
              });
            },
          ),
        ],
      ),
      _showshart
          ? Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.8,
              child: chart(_recentTransaction))
          : txListWidget
    ];
  }

  List<Widget> _BuildPortait(AppBar appBar, Widget txListWidget) {
    return [
      Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.25,
        child: chart(_recentTransaction),
      ),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
      textTheme: Theme.of(context).textTheme,
      title: Text(
        'Personal Expensives',
        style: TextStyle(
            fontStyle: Theme.of(context).textTheme.headline6.fontStyle),
        textAlign: TextAlign.center,
      ),
    );
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final txListWidget = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.75,
        child: TransactionList(_userTransactions, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (isLandscape) ..._BuildLandscape(appBar, txListWidget),
            if (!isLandscape) ..._BuildPortait(appBar, txListWidget),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
