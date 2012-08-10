echo off
rem examples of usage
rem


Rem: set path 
SET PATH=
SET PATH=%PATH%;D:/Binutils/Ruby193/bin
SET PATH=%PATH%;C:/Binutils/Ruby193/bin
SET PATH=C:/Progra~1/Git/bin;%PATH%

Rem: set enviroment and release gem
cd ./..
gem release
cd ./distrib

