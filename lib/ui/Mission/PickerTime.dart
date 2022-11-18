import 'package:flutter/material.dart';

class TimePickerDemo extends StatefulWidget {
  final String title;

  TimePickerDemo(this.title) {}
  @override
  _TimePickerDemoState createState() => _TimePickerDemoState(title);
  TimeOfDay selectedTime = TimeOfDay.now();

  void setTime(TimeOfDay dateTimeT) {
    selectedTime = dateTimeT;
    // print(selectedDate);
  }

  TimeOfDay getTimeSelected() {
    // print(selectedDate);
    return selectedTime;
  }
}

class _TimePickerDemoState extends State<TimePickerDemo> {
  String titleT;
  _TimePickerDemoState(this.titleT);
  _selectDate(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != widget.selectedTime)
      setState(() {
        widget.selectedTime = picked;
        widget.getTimeSelected();
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
                        '${widget.selectedTime.hour} : ${widget.selectedTime.minute}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.only(
                  left: 5.0,
                  right: 5.0,
                ),
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
                    'Chọn giờ',
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
