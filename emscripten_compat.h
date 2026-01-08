/*
 * Compatibility fixes for Emscripten/WASM builds
 * This header provides missing functions and prevents symbol conflicts
 */
#ifdef __EMSCRIPTEN__
#include <stdio.h>
#include <stdlib.h>

/* getpass is not available in emscripten */
static char* getpass(const char* prompt) {
  fprintf(stderr, "Password encryption is not supported in WASM builds\n");
  return NULL;
}

/* Prevent redeclaration of getopt by defining it before system headers */
#define getopt emscripten_getopt_workaround
#endif
