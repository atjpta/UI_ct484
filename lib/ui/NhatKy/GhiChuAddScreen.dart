import 'package:flutter/material.dart';
import 'package:myshop/ui/NhatKy/GhiChuControler.dart';
import '../../models/GhiChu.dart';
import 'package:provider/provider.dart';
import '../shared/dialog_utils.dart';

final Map<String, String> _ghiChuData = {
  'id': '',
  'title': '',
  'content': '',
};

class GhiChuAddScreen extends StatefulWidget {
  static const routeName = '/diaryAdd';
  const GhiChuAddScreen({Key? key}) : super(key: key);

  @override
  State<GhiChuAddScreen> createState() => _GhiChuAddScreenState();
}

class _GhiChuAddScreenState extends State<GhiChuAddScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late GhiChuControler _ghiChuControler;

  @override
  void initState() {
    super.initState();
    _ghiChuControler = context.read<GhiChuControler>();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showConfirmDialog(context, 'Thoát sẽ không lưu, bạn chăc chứ?',
            'Thông báo cực căng', '/');
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Diary'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                _add(context);
                // Navigator.of(context)..pushNamed('/');
              },
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 5,
              bottom: 5,
            ),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(
                              fontSize: 28,
                            ),
                            decoration: const InputDecoration(
                                hintText: 'Gõ vô tiêu đề'),
                            validator: (value) {
                              if (value == '') {
                                return 'Không được rỗng';
                              }
                            },
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
                            maxLines: 14,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Gõ vô nội dung'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _add(BuildContext contextT) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    GhiChu ghiChuT = GhiChu(
      id: '',
      title: _ghiChuData['title']!,
      content: _ghiChuData['content']!,
      userId: '',
    );
    showLoadingDialog(contextT, "đang xử lý", 'Thông báo cực căng');
    try {
      await _ghiChuControler.createGhiChu(ghiChuT);
      Navigator.of(contextT).pop();
      Navigator.of(contextT)..pushNamed('/');
      showErrorDialog(context, 'Thêm thành công', 'Thông báo cực căng');
    } catch (e) {
      print(e);
      Navigator.of(contextT).pop();
      showErrorDialog(context, 'Lỗi thêm', 'Thông báo cực căng');
    }
    // print(ghiChuT.content);
  }
}
