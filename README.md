# ceedling

Docker image for [Ceedling](http://www.throwtheswitch.org/ceedling) -- 
build system targeted at TDD (Test-Driven Development) in C.

This image is built on Ubuntu base and includes:  
- [Ceedling](http://www.throwtheswitch.org/ceedling) with 
  [CMock](https://github.com/throwtheswitch/cmock), 
  [Unity](https://github.com/throwtheswitch/unity), 
  [CException](https://github.com/throwtheswitch/cexception)
- GCC with libc6-dev (GNU C Library)
- [Gcovr](https://gcovr.com/en/stable/index.html)

Can be used either interactively or as part of a CI build.  
