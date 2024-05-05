import 'package:flutter/material.dart';
import 'package:taxi_code/services/http_request_service.dart';

class AutocompleteForm extends StatefulWidget {
  const AutocompleteForm({super.key});

  @override
  State<AutocompleteForm> createState() => _AutocompleteFormState();
}

class _AutocompleteFormState extends State<AutocompleteForm> {
  searchfromGooglePlaces(String query) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      "maps/api/place/autocomplete/json",
      {
        "input": query,
        "key": 'AIzaSyDpyL8irml46SsZtGFS3vXs3MZhMiEHQ6k',
      },
    );
    String? places = getPlaces(query, uri);
    if (places != null) {
      if (query.contains(places)) {
        return places;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue value) {
        if (value.text.replaceAll(' ', '').isEmpty) {
          return const ['Нет совпадений'];
        }
        print("========================================");
        print(value);
        print(value.text);
        print(searchfromGooglePlaces(value.text));
        return const ['Нет совпадений'];
      },
    );
  }
}
