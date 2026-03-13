import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pininfo.dart';

class PinApi {
  static const baseUrl = 'http://localhost:5288'; 

static Future<void> deletePin(int? id) async {
  if (id == null) {
    return;
  }

    final response = await http.delete(Uri.parse('$baseUrl/api/pins/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete pin');
    }
  }

  static Future<void> updatePin(PinInfo pin) async {
  final response = await http.put(
    Uri.parse('$baseUrl/api/pins/${pin.id}'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(pin.toJson()),
  );

  if (response.statusCode != 204) {
    throw Exception('Failed to update pin ${pin.id}');
  }
}

Future<void> savePinToBackend(PinInfo pin) async {
  final url = Uri.parse('$baseUrl/api/pins');
  final body = jsonEncode({
    'imagePath': pin.imageUrl,
    'x': pin.x,
    'y': pin.y,
  });
  await http.post(url,
      headers: {'Content-Type': 'application/json'}, body: body);
}

  static Future<List<PinInfo>> getPins() async {
    final response = await http.get(Uri.parse('$baseUrl/api/pins'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => PinInfo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load pins');
    }
  }

  static Future<PinInfo> addPin(PinInfo pin) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/pins'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pin.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return PinInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.statusCode);
    }
  }
}