cmake_minimum_required(VERSION 3.10)

project(native_hash VERSION 0.0.1 LANGUAGES CXX)

add_library(native_hash SHARED
native_hash.cpp
hasher.c++
)

target_include_directories(native_hash PRIVATE .)