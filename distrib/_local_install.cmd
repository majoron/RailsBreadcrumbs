echo off

Rem: set path 
SET PATH=
SET PATH=%PATH%;D:/Binutils/Ruby193/bin
SET PATH=%PATH%;C:/Binutils/Ruby193/bin

echo on
Rem: set enviroment and execute ant script
gem install ./output/rails_breadcrumbs-0.5.4.gem --local
rem gem uninstall rails_breadcrumbs
rem rem gem list --local

