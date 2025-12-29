cmake_minimum_required(VERSION 3.18)
project(NativeEngine VERSION 0.0.1 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)



# 3. DEFINE YOUR SHA256 LIBRARY
# We keep your code in its own little library
add_library(native_hash SHARED 
    sha256/hasher.cpp 
    sha256/sha256.c
    sha256/sha256.h
)

target_include_directories(native_hash PUBLIC sha256/ )