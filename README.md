[Premake](https://github.com/premake/premake-core) extension to support [cmake](http://www.cmake.org/)

### Features ###

* Support for C/C++ language projects

### Install ###
In your project directory:
```bash
git clone https://github.com/ovenpasta/premake5-cmake cmake
```
add this line to your premake5.lua:
```lua
require("cmake")
```

### Usage ###

Simply generate your project using the `cmake` action:
```bash
premake5 cmake
```
and open the generated project file in cmake.
