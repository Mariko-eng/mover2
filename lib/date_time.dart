import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';

class MyDate extends StatelessWidget {
  const MyDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datetime Picker'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: (){
            dateTimePickerWidget(context);
          },
            child: Text("Show Date"))
      ),
    );
  }

  dateTimePickerWidget(BuildContext context) {
    return DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM yyyy HH:mm',
      initialDateTime: DateTime.now(),
      minDateTime: DateTime(DateTime.now().year),
      maxDateTime: DateTime(DateTime.now().year + 1),
      onMonthChangeStartWithFirstDate: true,
      onConfirm: (dateTime, List<int> index) {
        DateTime selectdate = dateTime;
        final selIOS = DateFormat('dd-MMM-yyyy - HH:mm').format(selectdate);
        print(selectdate.toUtc());
        print(selIOS);
      },
    );
  }
}