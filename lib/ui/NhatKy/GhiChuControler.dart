import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../models/GhiChu.dart';
import '../../models/auth_token.dart';
import '../../services/GhiChuService.dart';

class GhiChuControler with ChangeNotifier {
  late AuthToken authToken;

  GhiChuControler([AuthToken? authToken]) : _ghiChuService = GhiChuService();

  List<GhiChu> nhatKys = [];

  set authToken2(AuthToken? authToken) {
    _ghiChuService.authToken = authToken;
  }

  final GhiChuService _ghiChuService;

  Future<void> fetchGhiChu() async {
    nhatKys = await _ghiChuService.getListGhiChu();
    notifyListeners();
  }

  Future<void> updateGhiChu(GhiChu ghiChu) async {
    await _ghiChuService.updateGhiChu(ghiChu);
    fetchGhiChu();
    notifyListeners();
  }

  Future<void> createGhiChu(GhiChu ghiChu) async {
    await _ghiChuService.createGhiChu(ghiChu);
    fetchGhiChu();
    notifyListeners();
  }

  Future<void> deleteGhiChu(GhiChu ghiChu) async {
    await _ghiChuService.deleteGhiChu(ghiChu);
    fetchGhiChu();
    notifyListeners();
  }

  int get NhatKyCount {
    return nhatKys.length;
  }

  void test() {
    print(' >> test here');
  }
}
