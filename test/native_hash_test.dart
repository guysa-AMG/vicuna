import 'dart:io';
import 'dart:isolate';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/native_bridge.dart'; // Import your FFI class

void main() {
  test('Verify C++ SHA-256 calculation', () async {


    final file = File('${Directory.systemTemp.path}/test.txt');
    await file.writeAsString("flutter_ffi_test_vector");

    const expectedHash = "4e6d425712e1286a1177656608889b91764619a86f9160533349942d7657d428";

    final resultHash = await Isolate.run(() => NativeValidator.calculateFileHash(file.path));

    print("Expected: $expectedHash");
    print("Actual:   $resultHash");t addd .
    
    expect(resultHash.toLowerCase(), expectedHash);
  });
}