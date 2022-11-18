import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../models/NhiemVu.dart';
import '../../models/auth_token.dart';
import '../../services/nhiemVuService.dart';

class NhiemVuControler with ChangeNotifier {
  List<NhiemVu> nhiemVus = [];

  List<NhiemVu> nhiemVuIncomplete = [];
  List<NhiemVu> nhiemVuCompleted = [];

  int get NhiemVuCount {
    return nhiemVus.length;
  }

  int get nhiemVuIncompleteCount {
    return nhiemVuIncomplete.length;
  }

  int get nhiemVuCompletedCount {
    return nhiemVuCompleted.length;
  }

  set authToken2(AuthToken? authToken) {
    _nhiemVuService.authToken = authToken;
  }

  final NhiemVuService _nhiemVuService;

  late AuthToken authToken;
  NhiemVuControler([AuthToken? authToken]) : _nhiemVuService = NhiemVuService();

  Future<void> fetchNhiemVu() async {
    nhiemVus = await _nhiemVuService.getListNhiemVu();
    notifyListeners();
  }

  Future<void> fetchNhiemVuFinish() async {
    nhiemVus.clear();
    nhiemVuIncomplete.clear();
    nhiemVuCompleted.clear();
    nhiemVus = await _nhiemVuService.getListNhiemVuFinish();

    await SliptNhiemVu();
    notifyListeners();
  }

  Future<void> SliptNhiemVu() async {
    for (int i = 0; i < nhiemVus.length; i++) {
      if (nhiemVus[i].completed == '0') {
        nhiemVuIncomplete.add(nhiemVus[i]);
      } else {
        nhiemVuCompleted.add(nhiemVus[i]);
      }
    }
  }

  Future<void> updateNhiemVu(NhiemVu nhiemVu) async {
    await _nhiemVuService.updateNhiemVu(nhiemVu);
    await fetchNhiemVu();
    notifyListeners();
  }

  Future<void> createNhiemVu(NhiemVu nhiemVu) async {
    await _nhiemVuService.createNhiemVu(nhiemVu);
    await fetchNhiemVu();
    notifyListeners();
  }

  Future<void> deleteNhiemVu(NhiemVu nhiemVu) async {
    await _nhiemVuService.deleteNhiemVu(nhiemVu);
    await fetchNhiemVu();
    notifyListeners();
  }

  Future<void> completedNhiemVu(NhiemVu nhiemVu) async {
    await _nhiemVuService.completedMission(nhiemVu);
    await fetchNhiemVu();
    notifyListeners();
  }
}
