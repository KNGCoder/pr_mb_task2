import 'package:flutter/material.dart';
import 'package:pr_mb_task2/widgets/new_transaction.dart';
import 'package:pr_mb_task2/widgets/transaction_list.dart';
import 'model/transaction.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practical №2',
      theme: ThemeData(
        primarySwatch: Colors.green,
        // fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          toolbarTextStyle: ThemeData.light().textTheme.copyWith().bodyMedium,
          titleTextStyle: ThemeData.light().textTheme.copyWith().titleLarge,
        )),
      home: const MyHomePage(),);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _listTransactions = [];

List<Transaction> get _recentTransactions {
  return _listTransactions.where((element) {
    return element.date.isAfter(
      DateTime.now().subtract(
        const Duration(days: 7),
      ),
    );
  }).toList();
}

void _addNewTransaction(String txtTitle, double txtAmount, DateTime chosenDate) {
  final newTx = Transaction(
    id: DateTime.now().toString(), 
    title: txtTitle,
    amount: txtAmount, 
    date: chosenDate);
    setState(() {
      _listTransactions.add(newTx);
    });
}

void _startAddNewTransaction(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (builderContext) {
      return GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.opaque,
        child: NewTransaction(_addNewTransaction),
      );
    }
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Practical 2',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed:  () => _startAddNewTransaction(context), 
            icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [TransactionList(_listTransactions)],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: const Icon(Icons.add),
      ), 
    );
  }
}
