import 'dart:convert';

import 'package:http/http.dart' as http;

String getBookCover({required String isbn}) {
  String coverUrl = 'https://covers.openlibrary.org/b/isbn/$isbn-L.jpg';

  return coverUrl;
}

Future<String> getBookTItle(String isbn) async {
  String _title = '';

  try {
    final urlString =
        'https://www.googleapis.com/books/v1/volumes?q=isbn:$isbn';
    print('url String: $urlString');
    final urlUri = Uri.parse(urlString);
    final response = await http.get(urlUri);
    final json = jsonDecode(response.body);
    _title = json['items'][0]['volumeInfo']['title'];
  } catch (e) {
    print(e);
  }

  return _title;
}
