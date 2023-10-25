import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pr_mb_task2/model/transaction.dart';

class TransactionList extends StatelessWidget{
  final List<Transaction> transaction;

  const TransactionList(this.transaction, {super.key});

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 300,
      child: transaction.isEmpty
      ?Column(
        children: [
          Text(
            'Нет заметок',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: Image.asset('assets/images/заметки.jpg',
            fit: BoxFit.cover))
        ],
      )
      :ListView.builder(
        itemBuilder: (ctx, index){
          return Card(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric( vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(border: Border.all(
                    color: Theme.of(context).primaryColor, width: 2)),
                    padding:  const EdgeInsets.all(10),
                    child: Text(
                      '${transaction[index].amount.toStringAsFixed(2)} рублей',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                ),
                // const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction[index].title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat('dd-MM-yyyy').format(transaction[index].date),
                      style: const TextStyle(color: Colors.grey))
                  ],)
              ],
            ),
          );
        },
        itemCount: transaction.length,
      )
    );
  }
}