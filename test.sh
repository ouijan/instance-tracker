docker run -t --rm \
  -v $(pwd -P):/tmp/dexec/build \
  dexec/lua test/main.lua
