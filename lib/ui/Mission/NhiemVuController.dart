import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../models/NhiemVu.dart';

class NhiemVuControler with ChangeNotifier {
  List<NhiemVu> NhiemVus = [
    NhiemVu(
        id: '1',
        title: 'title',
        content: 'content',
        userId: 'userId',
        startDate: '20/11/2022',
        startTime: '12:00',
        finishDate: '20/11/2022',
        finishTime: '12:00'),
    NhiemVu(
        id: '2',
        title: 'title 2',
        content: 'content 2',
        userId: 'userId 2',
        startDate: '20/11/2022',
        startTime: '12:00',
        finishDate: '20/11/2022',
        finishTime: '12:00'),
  ];
}
