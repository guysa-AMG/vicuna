#include <stdint.h>
#include <stdio.h>
#include <iostream>
#include <fstream>
#include <vector>

extern "C" {
    #include "sha256.h"
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
void compute_checksum(const char* path , unsigned char* ohash){
    std::ifstream file(path, std::ios::binary);
    if (!file.is_open()) return ;

    SHA256_CTX sha256;
    sha256_init(&sha256);

    constexpr size_t bufferSize = 1024 * 1024;

    std::vector<uint8_t> buffer(bufferSize);

    while (file.read(reinterpret_cast<char *> (buffer.data()),bufferSize) || file.gcount()>0){
       std::streamsize readSize = file.gcount();
       if (readSize>0){
        sha256_update(&sha256,buffer.data(),static_cast<size_t>(readSize));
       }
    }
    sha256_final(&sha256,ohash);
}
