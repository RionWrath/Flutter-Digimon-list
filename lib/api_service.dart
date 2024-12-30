import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "https://digimon-api.vercel.app/api/digimon";

  Future<List<Map<String, dynamic>>> getDigimonData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Jika respons berhasil (kode status 200)
      List<dynamic> digimonList = json.decode(response.body);
      // Konversi data JSON menjadi List<Map<String, dynamic>>

      return digimonList.cast<Map<String, dynamic>>();
      // Return data digimon dalam bentuk List<Map<String, dynamic>>
    } else {
      // Jika respons gagal
      throw Exception('Failed to load Digimon data');
    }
  }
}
