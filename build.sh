set -e
cd emsdk
./emsdk update-tags
./emsdk install tot
./emsdk activate tot
source emsdk_env.sh

if ! command -v emcc &> /dev/null; then
    echo "Error: emcc not found. Emscripten environment not set up correctly."
    exit 1
fi
echo "Emscripten found: $(emcc --version | head -n 1)"

# clone busytex
cd busytex

# set make parallelism
export MAKEFLAGS=-j8

# download and patch texlive into ./source
make source/texlive.patched

# build native tools and fonts file into ./build/native
make native

# smoke test native binaries
make smoke-native

# build wasm tools into ./build/wasm
make wasm

# build TeX Directory Structure (TDS)
# make tds-basic (target removed)

# test native binaries
sh example/example.sh

# reproduce and pack Ubuntu TexLive packages into wasm data files
make build/wasm/texlive-basic.js

# copies binaries and TexLive TDS into ./dist
make dist-native dist-wasm

# remove ./build and ./source completely
make clean