import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myshop/ui/NhatKy/GhiChuControler.dart';
import '../../models/GhiChu.dart';
import 'package:provider/provider.dart';
import '../shared/dialog_utils.dart';

final Map<String, String> _ghiChuData = {
  'id': '',
  'title': '',
  'content': '',
};

class GhiChuDetailsScreen extends StatefulWidget {
  static const routeName = '/diaryDetails';
  final GhiChu ghiChu;
  const GhiChuDetailsScreen(this.ghiChu, {Key? key}) : super(key: key);

  @override
  State<GhiChuDetailsScreen> createState() => _GhiChuDetailsScreenState();
}

class _GhiChuDetailsScreenState extends State<GhiChuDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late GhiChuControler _ghiChuControler;
  @override
  void initState() {
    super.initState();
    _ghiChuControler = context.read<GhiChuControler>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Diary'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _delete(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _update();
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
                          initialValue: widget.ghiChu.title,
                          style: const TextStyle(
                            fontSize: 28,
                          ),
                          validator: (value) {},
                          onSaved: (value) {
                            _ghiChuData['title'] = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: widget.ghiChu.content,
                          maxLines: 16,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          validator: (value) {},
                          onSaved: (value) {
                            _ghiChuData['content'] = value!;
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
    _ghiChuData['id'] = widget.ghiChu.id!;
    _formKey.currentState!.save();

    GhiChu ghiChuT = GhiChu(
      id: _ghiChuData['id'],
      title: _ghiChuData['title']!,
      content: _ghiChuData['content']!,
      userId: '',
    );
    try {
      await _ghiChuControler.updateGhiChu(ghiChuT);
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
    _ghiChuData['id'] = widget.ghiChu.id!;
    _formKey.currentState!.save();

    GhiChu ghiChuT = GhiChu(
      id: _ghiChuData['id'],
      title: _ghiChuData['title']!,
      content: _ghiChuData['content']!,
      userId: '',
    );
    try {
      await _ghiChuControler.deleteGhiChu(ghiChuT);
      Navigator.of(contextT)..pushNamed('/');
      showErrorDialog(context, 'Xóa thành công', 'Thông báo cực căng');
    } catch (e) {
      print(e);
      showErrorDialog(context, 'Lỗi xóa', 'Thông báo cực căng');
    }
    // print(ghiChuT.content);
  }
}
