import 'dart:convert';
import 'dart:typed_data';

import 'package:bingo_with_coca/core/services/storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

/// A service that uploads a single [PlatformFile] via multipart/form-data
/// to a PHP endpoint (field name "photo") and returns the "url" from the JSON response.
///
/// This version is Web-compatible (no dart:io imports). You MUST call:
///   FilePicker.platform.pickFiles(type: FileType.image, withData: true)
/// so that `file.bytes` is non-null on Web (and mobile/desktop if you choose).
///
class HttpStorageService implements StorageService{
 @override
  Future<String> uploadFile({
    required dynamic file,
    required String path,
  }) async {
    // 1) Ensure we have bytes:
    final Uint8List? maybeBytes = file.bytes;
    if (maybeBytes == null || maybeBytes.isEmpty) {
      throw Exception(
        'PlatformFile.bytes is null or empty. '
            'Be sure you used `pickFiles(withData: true)`.',
      );
    }
    final Uint8List fileBytes = maybeBytes;
    final String fileName = file.name;

    // 2) Build multipart request:
    final uri = Uri.parse(path);
    final request = http.MultipartRequest('POST', uri);

    request.files.add(
      http.MultipartFile.fromBytes(
        'photo', // matches $_FILES['photo'] in PHP
        fileBytes,
        filename: fileName,
        contentType: MediaType('image', _detectSubtype(fileName)),
      ),
    );

    // 3) Send and await response:
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception(
        'Upload failed (HTTP ${response.statusCode}): ${response.body}',
      );
    }

    // 4) Parse JSON { "url": "…" }
    final Map<String, dynamic> jsonMap = json.decode(response.body);
    if (!jsonMap.containsKey('url')) {
      throw Exception(
        'Invalid response: missing "url". Body: ${response.body}',
      );
    }
    return jsonMap['url'] as String;
  }

  /// Determines image subtype from file extension. Defaults to 'jpeg'.
  String _detectSubtype(String filename) {
    final lower = filename.toLowerCase();
    if (lower.endsWith('.png')) return 'png';
    if (lower.endsWith('.gif')) return 'gif';
    if (lower.endsWith('.webp')) return 'webp';
    if (lower.endsWith('.bmp')) return 'bmp';
    return 'jpeg';
  }
}
