# compile foo.so
gcc -shared -fPIC foo.c -o libfoo.so

# good libbar.so

gcc -shared -fPIC -o libbar.so bar.c -lfoo -L"$(pwd)" -Wl,--enable-new-dtags,-rpath,"/data/liz0f/linux-shlib-link-samples"

# bad libbar_dumb.so

gcc -shared -fPIC -o libbar_dumb.so bar.c

# linking main to libbar.so

# gcc -o app main.c -L"$(pwd)" -lbar -Wl,--enable-new-dtags,-rpath-link,"/data/liz0f/linux-shlib-link-samples",-rpath,"/data/liz0f/linux-shlib-link-samples"

# gcc -o app main.c -L"$(pwd)" -lbar -L"$(pwd)" -Wl,--enable-new-dtags,-rpath,"/data/liz0f/linux-shlib-link-samples"

# gcc -o app main.c -L"$(pwd)" -lbar -Wl,-rpath,"/data/liz0f/linux-shlib-link-samples"

# linking main to libbar_dumb.so
gcc -o app main.c -L"$(pwd)" -lbar_dumb