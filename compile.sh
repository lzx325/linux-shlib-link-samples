## !!! Please unset LD_LIBRARY_PATH to make sure that the environment variable does not have a role in library finding!!!
## !!! When LD_LIBRARY_PATH has a trailing colon, it will effectively add current directory to the search path !!!

## compile foo.so
gcc -shared -fPIC foo.c -o libfoo.so

## good libbar.so

#gcc -shared -fPIC -o libbar.so bar.c -lfoo -L"$(pwd)" -Wl,--enable-new-dtags,-rpath,"/data/liz0f/linux-shlib-link-samples"
gcc -shared -fPIC -o libbar.so bar.c -lfoo -L"$(pwd)" 


## bad libbar_dumb.so

gcc -shared -fPIC -o libbar_dumb.so bar.c

## linking main to libbar.so

# gcc -o app main.c -L"$(pwd)" -lbar -Wl,--enable-new-dtags,-rpath-link,"/data/liz0f/linux-shlib-link-samples",-rpath,"/data/liz0f/linux-shlib-link-samples"

# using gcc5 and gcc7, the following sets RUNPATH
gcc -o app main.c -L"$(pwd)" -lbar -L"$(pwd)" -Wl,--enable-new-dtags,-rpath,"/data/liz0f/linux-shlib-link-samples"

# using gcc 5, the following sets RPATH, but using gcc 7 the following sets RUNPATH
#gcc -o app main.c -L"$(pwd)" -lbar -Wl,-rpath,"/data/liz0f/linux-shlib-link-samples"

# using gcc 7, the following sets RPATH
gcc -o app main.c -L"$(pwd)" -lbar -Wl,--disable-new-dtags,-rpath,"/data/liz0f/linux-shlib-link-samples"


# without any path
#gcc -o app main.c -L"$(pwd)" -lbar 

# linking main to libbar_dumb.so
#gcc -o app main.c -L"$(pwd)" -lbar_dumb
