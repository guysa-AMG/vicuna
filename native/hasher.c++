#include <stdint.h>
#include <stdio.h>
#include <iostream>
#include <fstream>
#include <vector>

#include "sha256.h"

extern "C" __attribute__((visibility("default"))) __attribute__((used))
void compute_checksum(const char* path , unsigned char* ohash){
    std::ifstream file(path, std::ios::binary);
    if (!file.is_open()) return ;

    SHA256_CTX sha256;
    SHA256_Init(&sha256);

    constexpr size_t bufferSize = 1024 * 1024;

    std::vector<uint8_t> buffer(bufferSize);

    while (file.read(reinterpret_cast<char *> (buffer.data()),bufferSize) || file.gcount()>0){
       std::streamsize readSize = file.gcount();
       if (readSize>0){
        SHA256_Update(&sha256,buffer.data(),static_cast<size_t>(readSize));
       }
    }
    SHA256_Final(ohash,&sha256);
}