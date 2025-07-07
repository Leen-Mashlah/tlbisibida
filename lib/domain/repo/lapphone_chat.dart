import 'dart:convert';

List<String> decodeLabPhoneNumbers(String jsonString) {
  try {
    // Attempt to decode the input jsonString.
    // It can either be a JSON object string or a JSON array string.
    final dynamic decodedInnerData = jsonDecode(jsonString);

    if (decodedInnerData is Map<String, dynamic>) {
      // If it decodes to a Map (the old format: "{"1":"...", "2":"..."}")
      return decodedInnerData.values.map((e) => e.toString()).toList();
    } else if (decodedInnerData is List) {
      // If it decodes to a List (the new format: "["...", "..."]")
      return decodedInnerData.map((e) => e.toString()).toList();
    } else {
      // Handle unexpected types for the inner JSON string
      print(
          'Warning: Unexpected type for decoded inner phone data: ${decodedInnerData.runtimeType}');
      return [];
    }
  } on FormatException catch (e) {
    print(
        'FormatException: Invalid JSON string for phone numbers: "$jsonString". Error: $e');
    return [];
  } catch (e) {
    print(
        'General error processing phone numbers: $e for string: "$jsonString"');
    return [];
  }
}

String encodeLabPhoneNumbers(List<String> phoneNumbers) {
  // Create a map where keys are sequential numbers (as strings) and values are phone numbers.
  final Map<String, String> phoneMap = {};
  for (int i = 0; i < phoneNumbers.length; i++) {
    phoneMap[(i + 1).toString()] = phoneNumbers[i];
  }

  // Encode the phoneMap into a JSON string.
  final String innerJsonString = jsonEncode(phoneMap);

  // Create the outer map with the "lab_phone" key.
  final Map<String, String> outerMap = {
    "lab_phone": innerJsonString,
  };

  // Encode the outer map into the final JSON string.
  return jsonEncode(outerMap);
}
