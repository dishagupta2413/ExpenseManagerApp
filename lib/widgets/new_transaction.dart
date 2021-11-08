import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectDate=DateTime.now();

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if(_amountController.text.isEmpty){
      return;
    }
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectDate==null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectDate,
    );

    Navigator.of(context).pop();
    // to close the keyboard all by itself
  }

  void _presentDayPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData,




// onChanged: (val){
//   titleInput=val;
// },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitData,
// onChanged: (val){
//   amountInput=val;
// },
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectDate == DateTime.now()
                          ? 'No Date Chosen!'
                          : DateFormat.yMd().format(
                              (_selectDate),
                            ),
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColorDark,
                    child: Text(
                      'Choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDayPicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              color: Theme.of(context).primaryColorLight,
              textColor: Theme.of(context).textTheme.button!.color,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
