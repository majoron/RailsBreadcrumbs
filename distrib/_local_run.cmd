echo off

Rem: set path 
rem SET PATH=
SET PATH=%PATH%;D:/Binutils/Ruby192/bin
SET PATH=%PATH%;C:/Binutils/Ruby192/bin
SET PATH=%PATH%;D:/Binutils/Ruby-186-27/bin
SET PATH=%PATH%;C:/Binutils/Ruby-186-27/bin
SET PATH=%PATH%;D:/Binutils/rubygems-1.3.5/bin
SET PATH=%PATH%;C:/Binutils/rubygems-1.3.5/bin
SET PATH=C:/Binutils/apache-ant-1.7.0/bin/;%PATH%
SET PATH=D:/Binutils/apache-ant-1.7.0/bin/;%PATH%


echo on
Rem: set enviroment and execute ant script
ant

