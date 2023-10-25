import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction(this.addTx,{super.key});

  @override
  State<NewTransaction> createState()=> _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty){return;}
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount<= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }
  void _presentDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2023), 
      lastDate: DateTime.now(),
      ).then((value) {
        if (value == null) {
          return;
        }
        setState(() {
          _selectedDate = value;
        });
      });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding:  const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            decoration: const InputDecoration(labelText: 'наименование'),
          onSubmitted: (_) => _submitData,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'цена'),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData(),
          ),
          SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child:Text(_selectedDate == null
                    ?'Дата не выбрана'
                    :'Выбранная дата : ${DateFormat.yMd().format(_selectedDate!)}'),
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: const Text(
                    'Выбрать дату',
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  ))
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _submitData,
            style: TextButton.styleFrom(backgroundColor: Colors.green),
             child: const Text(
              'Добавить в список',
              style: TextStyle( color: Colors.white),
             ))
        ],),
      ),
    );
  }
}