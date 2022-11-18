import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/GhiChu.dart';
import '../models/auth_token.dart';

class GhiChuService {
  late AuthToken? authToken;
  String _buildNoteUrl(String method) {
    return 'https://api-ct484.vercel.app/api/note/$method';
  }

  Future<List<GhiChu>> getListGhiChu() async {
    print(authToken!.userId);
    final List<GhiChu> ghiChus = [];
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
        ghiChus.add(GhiChu.fromJson(responseJson[i]));
      }
      return ghiChus;
    } catch (error) {
      print(" >> error: " + error.toString());
      rethrow;
    }
  }

  Future<void> createGhiChu(GhiChu ghiChu) async {
    final url = Uri.parse(_buildNoteUrl(''));
    // print(url);
    var response = await http.post(url,
        headers: <String, String>{
          HttpHeaders.authorizationHeader: authToken!.token,
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "title": ghiChu.title,
          "content": ghiChu.content,
          "id_user": authToken!.userId,
        }));
    // print(response.body);
  }

  Future<void> updateGhiChu(GhiChu ghiChu) async {
    final url = Uri.parse(_buildNoteUrl(ghiChu.id!));
    // print(url);
    var response = await http.put(url,
        headers: <String, String>{
          HttpHeaders.authorizationHeader: authToken!.token,
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "title": ghiChu.title,
          "content": ghiChu.content,
        }));
    // print(response.body);
  }

  Future<void> deleteGhiChu(GhiChu ghiChu) async {
    final url = Uri.parse(_buildNoteUrl(ghiChu.id!));
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

  // AuthToken _fromJson(Map<String, dynamic> json) {
  //   return AuthToken(
  //     token: json['accessToken'],
  //     userId: json['id'],
  //     username: json['username'],
  //   );
  // }
}
