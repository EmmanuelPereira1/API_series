import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> request() async {
  var url = Uri.parse('https://academy-auth.herokuapp.com/students');
  
   await http.get(url,
    headers: {
      "x-access-token": 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjI3MTU4OThlNGE5MDE1YzgxZDVlYTE1IiwiZW1haWwiOiJwZWRybzEzQHRlc3RlLmNvbSIsImlhdCI6MTY1MTYwMzgwOCwiZXhwIjoxNjU0MTk1ODA4fQ.Jjh6UyXmfNICuqxyNzFybRfZ4hLo4zKZZ8Mteqz-Sf8',
    },
  );
  }