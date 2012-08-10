echo off

Rem: set path 
SET PATH=
SET PATH=%PATH%;D:/Binutils/Ruby193/bin
SET PATH=%PATH%;C:/Binutils/Ruby193/bin
SET PATH=C:/Binutils/apache-ant-1.7.0/bin/;%PATH%
SET PATH=D:/Binutils/apache-ant-1.7.0/bin/;%PATH%
SET PATH=C:/Progra~1/Git/bin;%PATH%

Rem: set java home
<<<<<<< HEAD
SET JAVA_HOME=C:/Progra~1/Java/jre7
=======
SET JAVA_HOME=C:/Progra~1/Java/jre6
>>>>>>> 9db075538f4633f571e74092a5b72888d6a3a1df

echo on
Rem: set enviroment and execute ant script
ant

