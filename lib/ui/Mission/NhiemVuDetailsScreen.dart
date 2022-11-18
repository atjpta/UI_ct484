import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myshop/models/NhiemVu.dart';
import 'package:myshop/ui/Mission/NhiemVuController.dart';
import 'package:myshop/ui/Mission/NhiemVuScreen.dart';
import 'package:myshop/ui/NhatKy/GhiChuControler.dart';
import '../../models/GhiChu.dart';
import 'package:provider/provider.dart';
import '../Mission/PickerDate.dart';
import '../Mission/PickerTime.dart';
import '../shared/dialog_utils.dart';

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

class MissionDetailsScreen extends StatefulWidget {
  static const routeName = '/missionDetails';
  final NhiemVu nhiemVu;
  const MissionDetailsScreen(this.nhiemVu, {Key? key}) : super(key: key);

  @override
  State<MissionDetailsScreen> createState() => _MissionDetailsScreenState();
}

class _MissionDetailsScreenState extends State<MissionDetailsScreen> {
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
    datePickerStartDate.setDateSelected(
        DateFormat('dd/MM/yyyy').parse(widget.nhiemVu.startDate));
    datePickerFinishDate.setDateSelected(
        DateFormat('dd/MM/yyyy').parse(widget.nhiemVu.finishDate));

    timePickerStartTime.setTime(TimeOfDay.fromDateTime(
        DateFormat('HH:mm').parse(widget.nhiemVu.startTime)));
    timePickerFinishTime.setTime(TimeOfDay.fromDateTime(
        DateFormat('HH:mm').parse(widget.nhiemVu.finishTime)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (widget.nhiemVu.completed == '0')
          ? FloatingActionButton(
              onPressed: () {
                _completedNhiemVu(context);
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.check),
            )
          : null,
      appBar: AppBar(
        title: const Text('Your Diary'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _delete(context);
            },
          ),
          (widget.nhiemVu.completed == '0')
              ? IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () {
                    _update();
                    // print(DateFormat('dd/MM/yyyy')
                    //     .format(datePickerStartDate.getDateSelected()));
                    // print(
                    //     '${timePickerStartTime.getDateSelected().hour} : ${timePickerStartTime.getDateSelected().minute}');
                    // print(DateFormat('dd/MM/yyyy')
                    //     .format(datePickerFinishDate.getDateSelected()));
                    // Navigator.of(context)..pushNamed('/');
                  },
                )
              : Text(''),
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
                          initialValue: widget.nhiemVu.title,
                          style: const TextStyle(
                            fontSize: 28,
                          ),
                          validator: (value) {},
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
                          initialValue: widget.nhiemVu.content,
                          maxLines: 16,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
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

  Future<void> _update() async {
    // datePickerDemo
    //     .setDateSelected(DateFormat('dd/MM/yyyy').parse('25/11/2022'));
    // print(DateFormat('dd/MM/yyyy').format(datePickerDemo.getDateSelected()));
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
    _nhiemVuData['id'] = widget.nhiemVu.id!;
    NhiemVu nhiemVu = NhiemVu(
      id: _nhiemVuData['id'],
      title: _nhiemVuData['title']!,
      content: _nhiemVuData['content']!,
      userId: '',
      startDate: _nhiemVuData['startDate']!,
      startTime: _nhiemVuData['startTime']!,
      finishDate: _nhiemVuData['finishDate']!,
      finishTime: _nhiemVuData['finishTime']!,
    );
    try {
      showLoadingDialog(context, 'Đang xử lý', 'Thông báo cực căng');
      await _nhiemVuControler.updateNhiemVu(nhiemVu);
      Navigator.pop(context);
      showErrorDialog(context, 'Chỉnh sửa thành công', 'Thông báo cực căng');
    } catch (e) {
      print(e);
      showErrorDialog(context, 'Lỗi chỉnh sửa', 'Thông báo cực căng');
    }
    // print(ghiChuT.content);
  }

  Future<void> _delete(BuildContext contextT) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _nhiemVuData['id'] = widget.nhiemVu.id!;
    print(widget.nhiemVu.id!);
    _formKey.currentState!.save();

    NhiemVu nhiemVu = NhiemVu(
      id: _nhiemVuData['id'],
      title: '',
      content: '',
      userId: '',
      startDate: '',
      startTime: '',
      finishDate: '',
      finishTime: '',
      completed: '',
    );
    try {
      showLoadingDialog(context, 'Đang xử lý', 'Thông báo cực căng');
      await _nhiemVuControler.deleteNhiemVu(nhiemVu);
      Navigator.pop(context);
      Navigator.of(contextT)..pushNamed(NhiemVuScreen.routeName);
      showErrorDialog(context, 'Xóa thành công', 'Thông báo cực căng');
    } catch (e) {
      print(e);
      showErrorDialog(context, 'Lỗi xóa', 'Thông báo cực căng');
    }
    // print(ghiChuT.content);
  }

  Future<void> _completedNhiemVu(BuildContext contextT) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _nhiemVuData['id'] = widget.nhiemVu.id!;
    print(widget.nhiemVu.id!);
    _formKey.currentState!.save();

    NhiemVu nhiemVu = NhiemVu(
      id: _nhiemVuData['id'],
      title: '',
      content: '',
      userId: '',
      startDate: '',
      startTime: '',
      finishDate: '',
      finishTime: '',
      completed: '',
    );

    try {
      showLoadingDialog(context, 'Đang xử lý', 'Thông báo cực căng');
      await _nhiemVuControler.completedNhiemVu(nhiemVu);
      Navigator.of(contextT)..pushNamed(NhiemVuScreen.routeName);
      showErrorDialog(context, 'đã hoàn thành', 'Thông báo cực căng');
    } catch (e) {
      print(e);
      showErrorDialog(context, 'Lỗi chọn hoàn thành', 'Thông báo cực căng');
    }
    // print(ghiChuT.content);
  }
}
