import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelp {
  final String url;
  NetworkHelp(this.url);
  Future getdata() async {
    var url1 = Uri.parse(url);
    http.Response response = await http.get(url1);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      return (response.statusCode);
    }
  }
}
