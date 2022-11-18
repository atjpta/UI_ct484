import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/NhiemVu.dart';
import '../models/http_exception.dart';
import '../models/auth_token.dart';

class NhiemVuService {
  late AuthToken? authToken;
  String _buildNoteUrl(String method) {
    return 'https://api-ct484.vercel.app/api/mission/$method';
  }

  Future<List<NhiemVu>> getListNhiemVu() async {
    // print(authToken!.userId);
    final List<NhiemVu> NhiemVus = [];
    try {
      final url = Uri.parse(_buildNoteUrl(authToken!.userId));

      var response = await http.get(
        url,
        headers: <String, String>{
          HttpHeaders.authorizationHeader: authToken!.token,
          "Content-Type": "application/json",
        },
      );

      final responseJson = json.decode(response.body);

      for (int i = 0; i < responseJson.length; i++) {
        NhiemVus.add(NhiemVu.fromJson(responseJson[i]));
      }
      return NhiemVus;
    } catch (error) {
      print(" >> error: " + error.toString());
      rethrow;
    }
  }

  Future<List<NhiemVu>> getListNhiemVuFinish() async {
    // print(authToken!.userId);
    final List<NhiemVu> NhiemVus = [];
    try {
      final url = Uri.parse(_buildNoteUrl('finishtime/${authToken!.userId}'));

      var response = await http.get(
        url,
        headers: <String, String>{
          HttpHeaders.authorizationHeader: authToken!.token,
          "Content-Type": "application/json",
        },
      );

      final responseJson = json.decode(response.body);

      for (int i = 0; i < responseJson.length; i++) {
        NhiemVus.add(NhiemVu.fromJson(responseJson[i]));
      }
      return NhiemVus;
    } catch (error) {
      print(" >> error: " + error.toString());
      rethrow;
    }
  }

  Future<void> createNhiemVu(NhiemVu nhiemVu) async {
    final url = Uri.parse(_buildNoteUrl(''));
    // print(url);
    var response = await http.post(url,
        headers: <String, String>{
          HttpHeaders.authorizationHeader: authToken!.token,
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "title": nhiemVu.title,
          "content": nhiemVu.content,
          "id_user": authToken!.userId,
          "startDate": nhiemVu.startDate,
          "startTime": nhiemVu.startTime,
          "finishDate": nhiemVu.finishDate,
          "finishTime": nhiemVu.finishTime,
          "completed": "0",
        }));
    // print(response.body);
  }

  Future<void> updateNhiemVu(NhiemVu nhiemVu) async {
    print(nhiemVu.id!);
    final url = Uri.parse(_buildNoteUrl(nhiemVu.id!));
    // print(url);
    var response = await http.put(url,
        headers: <String, String>{
          HttpHeaders.authorizationHeader: authToken!.token,
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "title": nhiemVu.title,
          "content": nhiemVu.content,
          "id_user": authToken!.userId,
          "startDate": nhiemVu.startDate,
          "startTime": nhiemVu.startTime,
          "finishDate": nhiemVu.finishDate,
          "finishTime": nhiemVu.finishTime,
          "completed": "0",
        }));
    // print(response.body);
  }

  Future<void> deleteNhiemVu(NhiemVu nhiemVu) async {
    final url = Uri.parse(_buildNoteUrl(nhiemVu.id!));
    // print(url);
    var response = await http.delete(
      url,
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authToken!.token,
        "Content-Type": "application/json",
      },
    );
    // print(response.body);
  }

  Future<void> completedMission(NhiemVu nhiemVu) async {
    final url = Uri.parse(_buildNoteUrl('completed/${nhiemVu.id!}'));
    var response = await http.put(
      url,
      headers: <String, String>{
        HttpHeaders.authorizationHeader: authToken!.token,
        "Content-Type": "application/json",
      },
    );
  }
}
