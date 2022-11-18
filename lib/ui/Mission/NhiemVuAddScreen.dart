import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myshop/models/NhiemVu.dart';
import 'package:myshop/ui/Mission/NhiemVuController.dart';
import 'package:myshop/ui/NhatKy/GhiChuControler.dart';
import '../../models/GhiChu.dart';
import 'package:provider/provider.dart';
import '../Mission/PickerDate.dart';
import '../Mission/PickerTime.dart';
import '../shared/dialog_utils.dart';
import 'NhiemVuScreen.dart';

final Map<String, String> _nhiemVuData = {
  'id': '',
  'title': '',
  'content': '',
  'startDate': '',
  'startTime': '',
  'finishDate': '',
  'finishTime': '',
  'completed': '',
};

class MissionAddScreen extends StatefulWidget {
  static const routeName = '/missionAdd';
  const MissionAddScreen({Key? key}) : super(key: key);

  @override
  State<MissionAddScreen> createState() => _MissionAddScreenState();
}

class _MissionAddScreenState extends State<MissionAddScreen> {
  final DatePickerDemo datePickerFinishDate = DatePickerDemo('Ngày hết hạn: ');
  final DatePickerDemo datePickerStartDate = DatePickerDemo('Ngày bắt đầu: ');
  final TimePickerDemo timePickerStartTime =
      TimePickerDemo('Thời gian bắt đầu: ');
  final TimePickerDemo timePickerFinishTime =
      TimePickerDemo('Thời gian kết thúc: ');

  final GlobalKey<FormState> _formKey = GlobalKey();
  late NhiemVuControler _nhiemVuControler;
  @override
  void initState() {
    super.initState();
    _nhiemVuControler = context.read<NhiemVuControler>();

    // datePickerStartDate.setDateSelected(
    //     DateFormat('dd/MM/yyyy').parse(widget.nhiemVu.startDate));
    // datePickerFinishDate.setDateSelected(
    //     DateFormat('dd/MM/yyyy').parse(widget.nhiemVu.finishDate));

    // timePickerStartTime.setTime(TimeOfDay.fromDateTime(
    //     DateFormat('HH:mm').parse(widget.nhiemVu.startTime)));
    // timePickerFinishTime.setTime(TimeOfDay.fromDateTime(
    //     DateFormat('HH:mm').parse(widget.nhiemVu.finishTime)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Diary'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _add(context);
              // print(DateFormat('dd/MM/yyyy')
              //     .format(datePickerStartDate.getDateSelected()));
              // print(
              //     '${timePickerStartTime.getDateSelected().hour} : ${timePickerStartTime.getDateSelected().minute}');
              // print(DateFormat('dd/MM/yyyy')
              //     .format(datePickerFinishDate.getDateSelected()));
              // Navigator.of(context)..pushNamed('/');
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 5,
                bottom: 5,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          // initialValue: widget.nhiemVu.title,
                          decoration:
                              InputDecoration(hintText: 'Nhập tên nhiệm vụ '),
                          style: const TextStyle(
                            fontSize: 28,
                          ),
                          validator: (value) {
                            if (value == '') {
                              return 'Hãy nhập tên nhiệm vụ';
                            }
                          },
                          onSaved: (value) {
                            _nhiemVuData['title'] = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                  datePickerStartDate,
                  timePickerStartTime,
                  datePickerFinishDate,
                  timePickerFinishTime,
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          // initialValue: widget.nhiemVu.content,
                          maxLines: 16,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.0,
                                ),
                              ),
                              hintText: 'Nhập nội dung nhiệm vụ'),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          validator: (value) {},
                          onSaved: (value) {
                            _nhiemVuData['content'] = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _add(BuildContext contextT) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _nhiemVuData['startDate'] =
        '${datePickerStartDate.getDateSelected().day}/${datePickerStartDate.getDateSelected().month}/${datePickerStartDate.getDateSelected().year}';
    _nhiemVuData['finishDate'] =
        '${datePickerFinishDate.getDateSelected().day}/${datePickerFinishDate.getDateSelected().month}/${datePickerFinishDate.getDateSelected().year}';
    _nhiemVuData['startTime'] =
        '${timePickerStartTime.getTimeSelected().hour}:${timePickerStartTime.getTimeSelected().minute}';
    _nhiemVuData['finishTime'] =
        '${timePickerFinishTime.getTimeSelected().hour}:${timePickerFinishTime.getTimeSelected().minute}';
    _formKey.currentState!.save();

    NhiemVu nhiemVu = NhiemVu(
      id: '',
      title: _nhiemVuData['title']!,
      content: _nhiemVuData['content']!,
      userId: '',
      startDate: _nhiemVuData['startDate']!,
      startTime: _nhiemVuData['startTime']!,
      finishDate: _nhiemVuData['finishDate']!,
      finishTime: _nhiemVuData['finishTime']!,
      completed: _nhiemVuData['completed']!,
    );
    showLoadingDialog(contextT, "đang xử lý", 'Thông báo cực căng');
    try {
      await _nhiemVuControler.createNhiemVu(nhiemVu);
      Navigator.of(contextT)
        ..pop()
        ..pushNamed(NhiemVuScreen.routeName);
      showErrorDialog(context, 'Thêm thành công', 'Thông báo cực căng');
    } catch (e) {
      print(e);
      Navigator.of(contextT).pop();
      showErrorDialog(context, 'Lỗi thêm', 'Thông báo cực căng');
    }
    // print(ghiChuT.content);
  }
}
