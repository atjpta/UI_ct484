import 'package:flutter/material.dart';

class DatePickerDemo extends StatefulWidget {
  final String title;

  DatePickerDemo(this.title) {}
  @override
  _DatePickerDemoState createState() => _DatePickerDemoState(title);
  DateTime selectedDate = DateTime.now();

  void setDateSelected(DateTime dateTimeT) {
    selectedDate = dateTimeT;
    // print(selectedDate);
  }

  DateTime getDateSelected() {
    // print(selectedDate);
    return selectedDate;
  }
}

class _DatePickerDemoState extends State<DatePickerDemo> {
  String titleT;
  _DatePickerDemoState(this.titleT);
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != widget.selectedDate)
      setState(() {
        widget.selectedDate = picked;
        widget.getDateSelected();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Text(
                    this.titleT +
                        "${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.blue,
                      Color.fromARGB(255, 255, 255, 255),
                    ],
                  ),
                ),
                child: TextButton(
                  onPressed: () => _selectDate(context),
                  child: const Text(
                    'Ch???n ng??y',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
