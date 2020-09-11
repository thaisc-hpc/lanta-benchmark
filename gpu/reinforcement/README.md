``` bash
mkdir -p "${MINIGO_BAZEL_CACHE_DIR}"  && \ 
  bazel --output_user_root="${MINIGO_BAZEL_CACHE_DIR}" build -c opt \
  --cxxopt="-D_GLIBCXX_USE_CXX11_ABI=0" \
  --copt=-O3 --copt="-v" \
  --define=board_size="${BOARD_SIZE}" \
  --define=tf=1 \
  --spawn_strategy=local \
  cc:minigo_python.so
```
