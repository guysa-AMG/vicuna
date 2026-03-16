import "dart:ffi" as ffi;
import "dart:io";
import "package:ffi/ffi.dart";
import "package:flutter/services.dart";


typedef _NativeHashC = ffi.Void Function(
  ffi.Pointer<Utf8>path,
  ffi.Pointer<ffi.Uint8> output
);

typedef _NativeHashDart = void Function (
  ffi.Pointer<Utf8> path,
  ffi.Pointer<ffi.Uint8> output
);


class CHash{
  static final ffi.DynamicLibrary _lib =_loadLibrary();

  static ffi.DynamicLibrary _loadLibrary(){
    if(Platform.isAndroid || Platform.isLinux){
      return ffi.DynamicLibrary.open("libnative_hash.so");
    }
    else{
      throw UnsupportedError(" native hash is Only Android Supported");
    }
  }

  static Future<String> getSHA256(String filePath)async{
    final compute_func= _lib.lookupFunction<_NativeHashC,_NativeHashDart>("compute_checksum");

    final ffi.Pointer<Utf8> pathPointer = filePath.toNativeUtf8();
    final ffi.Pointer<ffi.Uint8> output = calloc<ffi.Uint8>(32);

    try{
        compute_func(pathPointer,output);

        final Uint8List hashByte = output.asTypedList(32);
        return hashByte.map((b)=>b.toRadixString(16).padLeft(2,"0")).join();
    }
    finally{
      calloc.free(pathPointer);
      calloc.free(output);
    }
  }
}